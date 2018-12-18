/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef OVERLAYLISTMODEL_H
#define OVERLAYLISTMODEL_H

#include <QAbstractListModel>

class OverlayScene;
/*
 * Provides a model between C++ (backend) and QML(frontend) that will automatically update
 * when changes are made.
 */
class OverlayListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum AnimalRoles {
        NameRole = Qt::UserRole + 1,
        GuidRole,
        ImageRole,
        TitleRole,
        ActualGuidRole,

        DownloadedProgressRole,
        InLibraryRole
    };

    OverlayListModel(QObject *parent = 0);

    void addScene(const OverlayScene &scene);
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

public slots:
    //void receiveSceneDownloadProgress(QString guid, QString progressText);
    //void receiveSceneCompletionProgress(QString guid);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<OverlayScene> m_scenes;
};

#endif // OVERLAYLISTMODEL_H