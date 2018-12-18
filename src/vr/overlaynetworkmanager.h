/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef OVERLAYNETWORKMANAGER_H
#define OVERLAYNETWORKMANAGER_H

#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>

#include "overlayscene.h"

#include <qjsonobject.h>

/*
 * Solely handles using the Jahfx api to update, manage and query scene info from the main site
 */
class OverlayNetworkManager : public QObject
{
    Q_OBJECT
    QNetworkAccessManager *manager;

private slots:
    void managerFinished(QNetworkReply *reply);

signals:
    void sceneFetched(OverlayScene &scene);

public:
    OverlayNetworkManager();
    void makeRequest();

    QMap<int, QJsonObject> *requests;
};

#endif // OVERLAYNETWORKMANAGER_H