/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef OVERLAYIMAGEPROVIDER_H
#define OVERLAYIMAGEPROVIDER_H

#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QQuickImageProvider>

#include <QFileIconProvider>
#include <QMimeDatabase>


class Database;

/*
 * Provides the images that the frontend can request, these come from the database or from the Jahfx api
 * Preface with //guids when using from qml
 */
class OverlayImageProvider : public QQuickImageProvider
{
protected:
    QNetworkAccessManager *manager;

    QFileIconProvider   m_provider;
    QMimeDatabase       m_mimeDB;

public:
    OverlayImageProvider()
        : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {
        manager = new QNetworkAccessManager;
    }

    Database *db;
    void setDatabase(Database *db) {
        this->db = db;
    }

    QPixmap requestPixmap(const QString &guid, QSize *size, const QSize &requestedSize) override;
};

#endif // OVERLAYIMAGEPROVIDER_H