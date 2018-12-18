/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef OVERLAYSCENE_H
#define OVERLAYSCENE_H

#include <QString>

/*
 * Serves as a template class for what data a scene in VR will need or contain at any given time
 */
class OverlayScene
{
public:
    OverlayScene() {}
    OverlayScene(const QString &name, const QString &guid);
    OverlayScene(const QString &name, const QString &guid, const QString &featured_image, const QString &actual_guid, const QString &title);

    QString name() const;
    QString guid() const;
    QString actual_guid() const;
    QString featured_image() const;
    QString title() const;
    QString download_progress() const;

    bool in_library() const;

    void setName(const QString &value);
    void setGuid(const QString &value);
    void setActualGuid(const QString &value);
    void setFeaturedImage(const QString &value);
    void setTitle(const QString &value);
    void setDownloadProgress(const QString &value);
    void setInLibrary(bool value);

private:
    QString m_name;
    QString m_guid;
    QString m_actual_guid;
    QString m_featured_image;
    QString m_title;
    QString m_download_progress;
    bool    m_in_library;
};

#endif // OVERLAYSCENE_H