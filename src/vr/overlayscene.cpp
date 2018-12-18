#include "overlayscene.h"

OverlayScene::OverlayScene(const QString &name, const QString &guid)
    : m_name(name), m_guid(guid)
{
    m_download_progress = QString::number(0);
    m_in_library = false;
}

OverlayScene::OverlayScene(const QString &name, const QString &guid, const QString &featured_image, const QString &actual_guid, const QString &title)
    : m_name(name), m_guid(guid), m_featured_image(featured_image), m_actual_guid(actual_guid), m_title(title)
{
    m_download_progress = QString::number(0);
    m_in_library = false;
}

QString OverlayScene::name() const
{
    return m_name;
}

QString OverlayScene::guid() const
{
    return m_guid;
}

QString OverlayScene::actual_guid() const
{
    return m_actual_guid;
}

QString OverlayScene::title() const
{
    return m_title;
}

QString OverlayScene::download_progress() const
{
    // return strings to combat some weird qml uninitialized issue...
    return QString("%1%").arg(m_download_progress);
}

bool OverlayScene::in_library() const
{
    return m_in_library;
}

QString OverlayScene::featured_image() const
{
    return m_featured_image;
}

void OverlayScene::setName(const QString &value)
{
    m_name = value;
}

void OverlayScene::setGuid(const QString &value)
{
    m_guid = value;
}

void OverlayScene::setActualGuid(const QString & value)
{
    m_actual_guid = value;
}

void OverlayScene::setFeaturedImage(const QString &value)
{
    m_featured_image = value;
}

void OverlayScene::setTitle(const QString &value)
{
    m_title = value;
}

void OverlayScene::setDownloadProgress(const QString &value)
{
    m_download_progress = value;
}

void OverlayScene::setInLibrary(bool value)
{
    m_in_library = value;
}
