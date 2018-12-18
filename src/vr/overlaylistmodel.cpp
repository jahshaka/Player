#include "overlaylistmodel.h"

#include "overlayscene.h"

#include <QTime>
#include <qdebug.h>

OverlayListModel::OverlayListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void OverlayListModel::addScene(const OverlayScene &scene)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_scenes.append(scene);
    endInsertRows();
}

int OverlayListModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_scenes.size();
}

QVariant OverlayListModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_scenes.count())
        return QVariant();

    const OverlayScene &scene = m_scenes[index.row()];
    if (role == NameRole)
        return scene.name();
    else if (role == GuidRole)
        return scene.guid();
    else if (role == ImageRole)
        return scene.featured_image();
    else if (role == TitleRole)
        return scene.title();
    else if (role == DownloadedProgressRole)
        return scene.download_progress();
    else if (role == InLibraryRole)
        return scene.in_library();
    else if (role == ActualGuidRole)
        return scene.actual_guid();

    return QVariant();
}

bool OverlayListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    // if this doesn't work check this line 
    // https://stackoverflow.com/questions/44777999/manipulate-data-in-a-qabstractlistmodel-from-a-qml-listview
    if (!hasIndex(index.row(), index.column(), index.parent()) || !value.isValid())
        return false;

    OverlayScene &scene = m_scenes[index.row()];

    if (role == NameRole) scene.setName(value.toString());
    else if (role == GuidRole) scene.setGuid(value.toString());
    else if (role == ImageRole) scene.setFeaturedImage(value.toString());
    else if (role == TitleRole) scene.setTitle(value.toString());
    else if (role == DownloadedProgressRole) scene.setDownloadProgress(value.toString());
    else if (role == InLibraryRole) scene.setInLibrary(value.toBool());
    else if (role == ActualGuidRole) scene.setActualGuid(value.toString());
    else return false;

    emit dataChanged(index, index, { role });

    return true;
}

QHash<int, QByteArray> OverlayListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole]                 = "name";
    roles[GuidRole]                 = "guid";
    roles[ImageRole]                = "featured_image";
    roles[TitleRole]                = "title";
    roles[DownloadedProgressRole]   = "download_progress";
    roles[InLibraryRole]            = "in_library";
    roles[ActualGuidRole]           = "actual_guid";
    return roles;
}

//void OverlayListModel::receiveSceneDownloadProgress(QString guid, QString progressText)
//{
//    QModelIndex start_index = createIndex(0, 0);
//    QModelIndex end_index = createIndex((m_scenes.count() - 1), 0);
//    dataChanged(start_index, end_index);
//
//    for (auto &scene : m_scenes) {
//        if (scene.guid() == guid) {
//            scene.setDownloadProgress(progressText);
//            emit QAbstractListModel::dataChanged(start_index, end_index);
//            break;
//        }
//    }
//}

//void OverlayListModel::receiveSceneCompletionProgress(QString guid)
//{
//    QModelIndex start_index = createIndex(0, 0);
//    QModelIndex end_index = createIndex((m_scenes.count() - 1), 0);
//    dataChanged(start_index, end_index);
//
//    for (auto &scene : m_scenes) {
//        if (scene.guid() == guid) {
//            scene.setInLibrary(true);
//            emit QAbstractListModel::dataChanged(start_index, end_index);
//            break;
//        }
//    }
//}
