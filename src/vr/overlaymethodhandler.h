/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef OVERLAYMETHODHANDLER_H
#define OVERLAYMETHODHANDLER_H

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

#include "core/database/database.h"

#include "overlaycontroller.h"
#include "overlayscene.h"

class SwipeManager : public QObject {
    Q_OBJECT
public:
    using QObject::QObject;

signals:
    void setIndex(int index);
    void selectedTileGuid(QString g);
    void metadata(QStringList str);
    void startSomething(int name, QString id);
    void downloadProgress(int id, float prog);
};

/*
 * This is a helper class of sorts, any events that can be triggered by our frontend via QML *should* be handled here
 */
class OverlayMethodHandler : public QObject
{
    Q_OBJECT

        //    Q_PROPERTY(QString downloadPercentage READ downloadPercentage WRITE setDownloadPercentage NOTIFY downloadPercentageChanged)
        //    Q_PROPERTY(bool downloaded READ downloaded WRITE setDownloaded NOTIFY downloadCompleted)
        //
        //public:
        //    void setDownloadPercentage(const QString &dp) {
        //        if (dp != m_downloadPercentage) {
        //            m_downloadPercentage = dp;
        //            emit downloadPercentageChanged();
        //        }
        //    }
        //
        //    void setDownloaded(bool value) {
        //        if (value != m_downloaded) {
        //            m_downloaded = value;
        //            emit downloadCompleted();
        //        }
        //    }
        //
        //    bool downloaded() {
        //        return m_downloaded;
        //    }
        //
        //    QString downloadPercentage() const {
        //        return m_downloadPercentage;
        //    }

private:
 /*   QString m_downloadPercentage;
    bool m_downloaded;*/

    QNetworkAccessManager *manager;
    QTime downloadTime;
    QNetworkReply *currentDownload = nullptr;
    QHash<int, QNetworkReply*> currentDownloads;
    SwipeManager *swipeManager;

    QString currentlySelectedTileGuid;

signals:
    void openProject(QString guid);
    //void downloadPercentageChanged();
    //void downloadCompleted();
    void worldDownloadProgress(QString guid, QString progress);
    void worldDownloadComplete(int id);
    void toRight();
    void toLeft();
    void metadata(QStringList data);
    void sceneFetched(const QString &guid);

private slots:
    void managerFinished(QNetworkReply *reply);
    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);

public:
    explicit OverlayMethodHandler(SwipeManager *manager = nullptr);
    Database *db;
    void setDatabase(Database *db) {
        this->db = db;
    }

    OverlayController *controller;

    QMap<int, QString> requestsID;

public slots:
    void doSomething(const QString &text);
    void importWorld(QString url);
    void selectMetadata(const QString &text);
    void emitSelectedTile(const QString &text);
    void emitMetadata(const QString &author, const QString &featured_image, const QString &guid, const QString &name, const QString &actual);
    void startDownload(const QString &id, const QString guid);
    void cancelDownload(const QString guid);
    void startSomething(int name, const QString &id);
    void moveIndex(int index);
};

#endif // OVERLAYMETHODHANDLER_H