/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef OVERLAYCONTROLLER_H
#define OVERLAYCONTROLLER_H

#include <QObject>
#include <QOffscreenSurface>
#include <QTimer>

#include <QtQuick/QQuickFrameBufferObject>
#include <QtQuick/QQuickRenderControl>
#include <QtQuick/QQuickWindow>
#include <QtQuick/QQuickRenderControl>
#include <QtGui/QOpenGLFramebufferObject>
#include <QtGui/QOpenGLContext>
#include <QtGui/QOffscreenSurface>

QT_FORWARD_DECLARE_CLASS(QQmlEngine)
QT_FORWARD_DECLARE_CLASS(QQmlComponent)
QT_FORWARD_DECLARE_CLASS(QQuickItem)

class SceneViewWidget;
class Database;
class OverlayListModel;
class OverlayImageProvider;
class OverlayNetworkManager;
class OverlayMethodHandler;
class OverlayScene;
class SwipeManager;

#include "irisgl/src/graphics/texture2d.h"

/*
 * This class provides the controller that wraps all the overlay_ classes into one component
 * An OverlayController instance handles interactions on the QML frontend and dispatches events
 * back to be handled. It also provides a raw texture pointer that can be used in an internal texture
 * to provide visual feedback. 
 * 
 * It basically allows us to project QML views unto a surface, handle raycast events that are then mapped back
 * to 2D and treated as regular click events. All of this is sent to a framebuffer that returns a texture.
 */
class OverlayController : public QObject
{
    Q_OBJECT

public:

    QSize dimensions;

public:
    OverlayController(SceneViewWidget *sceneView, QSize dimensions);
    ~OverlayController();

    Database *db;
    void setDatabase(Database *db) {
        this->db = db;
    }

    void kickOff(const QString &path);
    QOpenGLContext *getCurrentContext();
    QQuickWindow *getWindow();
    QQmlEngine *getQmlEngine();

    QList<QObject*> downloadedDataList;

    void attachExternalObject(const QString &objectName, QObject *object);
    void attachExternalObject(const QString &objectName, const QVariant &variant);

private slots:
    void run();

    void createFramebuffer();
    void destroyFramebuffer();
    void render();
    void requestUpdate();
    void handleScreenChange();

    void updateScene(const OverlayScene &scene);

private:
    void startQuick(const QString &pathToQML);
    void updateSizes();

    int counter;

private:
    std::unique_ptr<QQuickRenderControl> renderControl;
    std::unique_ptr<QQuickWindow> quickWindow;
    std::unique_ptr<QOpenGLFramebufferObject> frameBuffer;
    std::unique_ptr<QOpenGLContext> openglContext;
    std::unique_ptr<QOffscreenSurface> offscreenSurface;

    std::unique_ptr<QTimer> m_pPumpEventsTimer;
    std::unique_ptr<QTimer> m_pRenderTimer;

    std::unique_ptr<QQmlEngine> qmlEngine;
    std::unique_ptr<QQmlComponent> qmlComponent;
    std::unique_ptr<QQuickItem> rootItem;

    QTimer updateTimer;
    bool quickReady;
    bool quickInitialized;

    SceneViewWidget *sceneView;

    //QOpenGLContext *m_context;
    //QOffscreenSurface *m_offscreenSurface;
    //QQuickRenderControl *m_renderControl;
    //QQuickWindow *m_quickWindow;
    //QQmlEngine *m_qmlEngine;
    //QQmlComponent *m_qmlComponent;
    //QQuickItem *m_rootItem;
    //QOpenGLFramebufferObject *m_fbo;
    //bool m_quickInitialized;
    //bool m_quickReady;
    //QTimer m_updateTimer;

public:
    iris::Texture2DPtr texture;
    QString holderNodeGuid;
};

#endif