#include "overlaymethodhandler.h"

#include <QTemporaryDir>
#include <qjsondocument.h>
#include <qjsonobject.h>

#include "uimanager.h"
#include "widgets/projectmanager.h"

#include "overlaynetworkmanager.h"

OverlayMethodHandler::OverlayMethodHandler(SwipeManager *_manager)
{
    manager = new QNetworkAccessManager;
    swipeManager = _manager;
    QObject::connect(manager, &QNetworkAccessManager::finished,
        this, &OverlayMethodHandler::managerFinished);
}

void OverlayMethodHandler::managerFinished(QNetworkReply *reply)
{
    if (reply->error()) {
        qDebug() << reply->errorString();
        //reply->deleteLater();
        return;
    }

    if (reply->isFinished()) {
        qDebug() << "finished properly";
    }
    else {
        qDebug() << "was not finished";
    }

    // uncomment all of this ok
    QByteArray fileDownloaded = reply->readAll();

    QTemporaryDir temporaryDir;
    if (!temporaryDir.isValid()) return;

    const QString writePath = temporaryDir.path();
    QFileInfo fileName(QDir(writePath).filePath("world.zip"));

    QFile file(fileName.absoluteFilePath());
    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "could not open for writing";
    }

    file.write(fileDownloaded);
    file.close();
    
    qDebug() << "Finished downloading " << reply->url();
  
    int worldId = reply->url().toString().split('=').last().toInt();
    emit worldDownloadComplete(worldId);

    currentDownloads.remove(worldId);
    reply->deleteLater();

    if (currentDownloads.isEmpty()) {
        qDebug() << "All downloads completed";
    }

    auto guid = requestsID.value(worldId);

    UiManager::getProjectManager()->importProjectFromDownloadSilently(fileName.absoluteFilePath(), guid);
    emit sceneFetched(guid);
}

void OverlayMethodHandler::selectMetadata(const QString &text)
{
    // text is guid for default lookup
    if (text == "empty") {
        emit swipeManager->metadata(QStringList("empty"));
    }
    else {
        auto project = db->fetchProject(text);
        QStringList str = { project.guid, project.name, "library", "null", "null" };
        emit swipeManager->metadata(str);
    }
}

void OverlayMethodHandler::emitMetadata(const QString &image_guid, const QString &scene_title, const QString &guid, const QString &scene_name, const QString &actual)
{
    QStringList str = { image_guid, scene_title, guid, scene_name, actual };
    emit swipeManager->metadata(str);
}

void OverlayMethodHandler::startDownload(const QString &id, const QString guid)
{
    QNetworkRequest request;
    request.setUrl(QUrl(id));

    ////QSslConfiguration conf = request.sslConfiguration();
    ////conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    ////request.setSslConfiguration(conf);

    QNetworkReply *currentReply = manager->get(request);
    downloadTime.start();

    int worldId = currentReply->url().toString().split('=').last().toInt();
    requestsID.insert(worldId, guid);
    currentDownloads.insert(worldId, currentReply);

    connect(currentReply, SIGNAL(downloadProgress(qint64, qint64)), SLOT(downloadProgress(qint64, qint64)));

    QHash<int, QNetworkReply*>::iterator iter;
    for (iter = currentDownloads.begin(); iter != currentDownloads.end(); ++iter) {
        connect(iter.value(), &QNetworkReply::downloadProgress, this, [=](qint64 bytesReceived, qint64 bytesTotal)
        {
            float percentage = ((bytesReceived / 1000000.f) / (bytesTotal / 1000000.f)) * 100.f;
            //emit worldDownloadProgress(worldId, QString::number(percentage, 'f', 1));
            emit swipeManager->downloadProgress(iter.key(), percentage / 100.f);
        });
    }
}

void OverlayMethodHandler::cancelDownload(const QString guid)
{
    if (currentDownloads.size()) {
        currentDownloads.value(guid.toInt())->abort();
        currentDownloads.remove(guid.toInt());
        requestsID.remove(guid.toInt());
    }
}

void OverlayMethodHandler::startSomething(int name, const QString &id)
{
    emit swipeManager->startSomething(name, id);
}

void OverlayMethodHandler::moveIndex(int index)
{
    emit swipeManager->setIndex(index);
}

void OverlayMethodHandler::downloadProgress(qint64 bytesReceived, qint64 bytesTotal)
{
    // calculate the download speed
    //double speed = bytesReceived * 1000.0 / downloadTime.elapsed();
    //QString unit;
    //if (speed < 1024) {
    //    unit = "bytes/sec";
    //}
    //else if (speed < 1024 * 1024) {
    //    speed /= 1024;
    //    unit = "kB/s";
    //}
    //else {
    //    speed /= 1024 * 1024;
    //    unit = "MB/s";
    //}

    //float percentage = ((bytesReceived / 1000000.f) / (bytesTotal / 1000000.f)) * 100.f;
    //qDebug() << currentDownload->url() << QString::number(percentage, 'f', 1);

    //emit currentDownloadProgress(QString::number(percentage, 'f', 1));

    //setDownloadPercentage(QString("Downloading %1%").arg(QString::number(percentage, 'f', 1)));
    //qDebug() << QString::fromLatin1("%1 %2").arg(speed, 3, 'f', 1).arg(unit);
    //qDebug() << QString::fromLatin1("BACK received %1MB of %2MB").arg(bytesReceived / 1000000.f).arg(bytesTotal / 1000000.f);
}

void OverlayMethodHandler::doSomething(const QString &guid)
{
    UiManager::getProjectManager()->openProjectFromGuid(guid);
}

void OverlayMethodHandler::importWorld(QString url)
{
    UiManager::getProjectManager()->importProjectFromDownload(url.remove(0, QString("file:///").length()));
}