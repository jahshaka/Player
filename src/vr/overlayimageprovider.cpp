#include "overlayimageprovider.h"

#include <QPainter>
#include <QFileInfo>
#include <QEventLoop>

#include "core/database/database.h"

QPixmap OverlayImageProvider::requestPixmap(const QString &guid, QSize *size, const QSize &requestedSize) 
{
    //int width = 376;
    //int height = 136;

/*     if (size)
        *size = QSize(width, height);
    QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : width,
        requestedSize.height() > 0 ? requestedSize.height() : height);
    pixmap.fill(QColor(id).rgba());*/

    qDebug() << "request " << guid;

    int width = requestedSize.width() > 0 ? requestedSize.width() : 64;
    int height = width;
    if (size) *size = QSize(width, height);

    if (QFileInfo(guid).isDir()) {
        return m_provider.icon(QFileIconProvider::Folder).pixmap(width, height);
    }
    else if (QFileInfo(guid).isFile()) {
        QMimeType mime = m_mimeDB.mimeTypeForFile(guid);
        if (QIcon::hasThemeIcon(mime.iconName())) return QIcon::fromTheme(mime.iconName()).pixmap(width, height);
        return m_provider.icon(QFileIconProvider::File).pixmap(width, height);
    }

    //QRegExp re("\\d*");  // a digit (\d), zero or more times (*)
    //if (re.exactMatch(guid)) {
    //    qDebug() << "all digits";
    if (QFileInfo(guid).suffix() == "png" || QFileInfo(guid).suffix() == "jpg") {
        //QUrl url("https://www.jahfx.com/wp-json/api/v1/worlds/" + guid);
        // just use the whole url for now
        QUrl url(guid);
        QNetworkReply* reply = manager->get(QNetworkRequest(url));
        QEventLoop eventLoop;
        QObject::connect(reply, SIGNAL(finished()), &eventLoop, SLOT(quit()));
        eventLoop.exec();
        if (reply->error() != QNetworkReply::NoError)
            return QPixmap::fromImage(QImage());
        QImage image = QImage::fromData(reply->readAll());
        size->setWidth(image.width());
        size->setHeight(image.height());
        return QPixmap::fromImage(image);

        //if (size)
        //    *size = QSize(width, height);
        //QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : width,
        //    requestedSize.height() > 0 ? requestedSize.height() : height);
        //pixmap.fill(QColor("red").rgba());
        //return pixmap;
    }

    auto project = db->fetchProject(guid);

    // TODO return empty image for null tiles???
    QPixmap pixmap;
    if (pixmap.loadFromData(project.thumbnail, "PNG")) {
        return pixmap;
    }

    // write the color name
    //QPainter painter(&pixmap);
    //QFont f = painter.font();
    //f.setPixelSize(20);
    //painter.setFont(f);
    //painter.setPen(Qt::black);
    //if (requestedSize.isValid())
    //    painter.scale(requestedSize.width() / width, requestedSize.height() / height);
    //painter.drawText(QRectF(0, 0, width, height), Qt::AlignCenter, id);
}