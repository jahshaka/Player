#include "overlaynetworkmanager.h"

#include <QJsonDocument>
#include <QJsonArray>
#include <QFileInfo>
#include <QJsonObject>


OverlayNetworkManager::OverlayNetworkManager() {
    manager = new QNetworkAccessManager;
    QObject::connect(manager, &QNetworkAccessManager::finished,
        this, &OverlayNetworkManager::managerFinished);

    requests = new QMap<int, QJsonObject>();

    // This is very important
    // The DLLs should be the same or similar to the version of OpenSSL that Qt was compiled with
    // DLLS are here https://indy.fulgan.com/SSL/
    // https://stackoverflow.com/questions/42094214/why-is-qsslsocket-working-with-qt-5-3-but-not-qt-5-7-on-debian-stretch/42297296#42297296
    qDebug() << "SSL version use for build: " << QSslSocket::sslLibraryBuildVersionString();
    qDebug() << "SSL version use for run-time: " << QSslSocket::sslLibraryVersionNumber();
}

void OverlayNetworkManager::makeRequest() {
    QNetworkRequest request;
    request.setUrl(QUrl("https://www.jahfx.com/wp-json/api/v1/worlds"));

    //QSslConfiguration conf = request.sslConfiguration();
    //conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    //request.setSslConfiguration(conf);

    manager->get(request);
}

void OverlayNetworkManager::managerFinished(QNetworkReply *reply) {
    if (reply->error()) {
        qDebug() << reply->errorString();
        //reply->deleteLater();
        return;
    }

    QByteArray response_data = reply->readAll();
    QJsonDocument json = QJsonDocument::fromJson(response_data);

    for (const auto &resp : json.array()) {
        auto obj = resp.toObject();

        OverlayScene scene;
        scene.setTitle(obj.value("title").toString());
        scene.setGuid(QString::number(obj.value("id").toInt()));
        scene.setFeaturedImage(obj.value("featured_image").toString());
        scene.setActualGuid(obj.value("guid").toString());
        scene.setName(obj.value("name").toString());

        requests->insert(obj.value("id").toInt(), obj);

        emit sceneFetched(scene);
    }
}