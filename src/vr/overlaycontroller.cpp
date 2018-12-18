/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#include "overlaycontroller.h"

#include <QQmlEngine>
#include <QQmlComponent>
#include <QQuickItem>

#include <qqmlcontext.h>

#include <QImage>

#include "widgets/sceneviewwidget.h"

#include <qopengltexture.h>

#include "core/database/database.h"


#include "overlayscene.h"
#include "overlaylistmodel.h"
#include "overlayimageprovider.h"
#include "overlaynetworkmanager.h"
#include "overlaymethodhandler.h"

OverlayController::OverlayController(SceneViewWidget *sceneView, QSize dimensions)

{
    QSurfaceFormat format;// = sceneView->getCurrentContext()->format();
    format.setDepthBufferSize(16);
    format.setStencilBufferSize(8);
    format.setSamples(16);

    //QSurfaceFormat format;
    // Qt's QOpenGLPaintDevice is not compatible with OpenGL versions >= 3.0
    // NVIDIA does not care, but unfortunately AMD does
    // Are subtle changes to the semantics of OpenGL functions actually covered by the compatibility profile,
    // and this is an AMD bug?
    //format.setVersion(2, 1);
    //format.setProfile( QSurfaceFormat::CompatibilityProfile );
    //format.setDepthBufferSize(16);
    //format.setStencilBufferSize(8);
    //format.setSamples(16);

    quickInitialized = false;
    quickReady = false;

    this->dimensions = dimensions;

    //sceneView->setSharedContext(openglContext.get());

    openglContext.reset(new QOpenGLContext);
    openglContext->setFormat(format);
    openglContext->setShareContext(sceneView->getCurrentContext());
    openglContext->create();

    offscreenSurface.reset(new QOffscreenSurface);
    offscreenSurface->setFormat(openglContext->format());
    offscreenSurface->create();
    //openglContext->makeCurrent(offscreenSurface.get());

    // set renderer surface to pass to here
    //sceneView->setSharedContext(openglContext.get());

    // NOTE - this might have to be changed/subclassed later so we can accomodate different DPIs
    renderControl.reset(new QQuickRenderControl);

    quickWindow.reset(new QQuickWindow(renderControl.get()));
    //quickWindow->setGeometry(0, 0, 512, 512);
    //renderControl->initialize(openglContext.get());
    quickWindow->setClearBeforeRendering(true);
    quickWindow->setColor(QColor(Qt::transparent));

    qmlEngine.reset(new QQmlEngine);
    if (!qmlEngine->incubationController())
        qmlEngine->setIncubationController(quickWindow->incubationController());

    updateTimer.setSingleShot(true);
    updateTimer.setInterval(5);
    connect(&updateTimer, &QTimer::timeout, this, &OverlayController::render);

    //texture = iris::Texture2D::createFromId(10);
    counter = 0;

    connect(quickWindow.get(), &QQuickWindow::sceneGraphInitialized, this, &OverlayController::createFramebuffer);
    connect(quickWindow.get(), &QQuickWindow::sceneGraphInvalidated, this, &OverlayController::destroyFramebuffer);
    connect(renderControl.get(), &QQuickRenderControl::renderRequested, this, &OverlayController::requestUpdate);
    connect(renderControl.get(), &QQuickRenderControl::sceneChanged, this, &OverlayController::requestUpdate);

    //texture = iris::Texture2D::load("C:/Users/Jahshaka/Desktop/Fire2.png");


  
}

void OverlayController::kickOff(const QString &path) {
    // TODO - move this to some expose event somewhere please
    if (!quickInitialized) {
        qDebug() << "kickoff" << path;
        startQuick(path);
    }
}

QOpenGLContext *OverlayController::getCurrentContext() {
    return openglContext.get();
}

QQuickWindow *OverlayController::getWindow() {
    return quickWindow.get();
}

QQmlEngine *OverlayController::getQmlEngine() {
    return qmlEngine.get();
}

void OverlayController::attachExternalObject(const QString &objectName, QObject *object) {
    qmlEngine->rootContext()->setContextProperty(objectName, object);
}

void OverlayController::attachExternalObject(const QString &objectName, const QVariant &variant) {
    qmlEngine->rootContext()->setContextProperty(objectName, variant);
}

OverlayController::~OverlayController()
{
    // Make sure the context is current while doing cleanup. Note that we use the
    // offscreen surface here because passing 'this' at this point is not safe: the
    // underlying platform window may already be destroyed. To avoid all the trouble, use
    // another surface that is valid for sure.
    //openglContext->makeCurrent(offscreenSurface.get());
    //openglContext->doneCurrent();
}

void OverlayController::run()
{
    disconnect(qmlComponent.get(), &QQmlComponent::statusChanged, this, &OverlayController::run);

    if (qmlComponent->isError()) {
        const QList<QQmlError> errorList = qmlComponent->errors();
        for (const QQmlError &error : errorList)
            qWarning() << error.url() << error.line() << error;
        return;
    }

    QObject *rootObject = qmlComponent->create();
    if (qmlComponent->isError()) {
        const QList<QQmlError> errorList = qmlComponent->errors();
        for (const QQmlError &error : errorList)
            qWarning() << error.url() << error.line() << error;
        return;
    }

    rootItem.reset(qobject_cast<QQuickItem*>(rootObject));
    if (!rootItem) {
        qWarning("run: Not a QQuickItem");
        delete rootObject;
        return;
    }

    // The root item is ready. Associate it with the window.
    rootItem->setParentItem(quickWindow->contentItem());

    // Update item and rendering related geometries.
    updateSizes();

    // Initialize the render control and our OpenGL resources.
    openglContext->makeCurrent(offscreenSurface.get());
    renderControl->initialize(openglContext.get());
    quickInitialized = true;
}

void OverlayController::createFramebuffer()
{
    openglContext->makeCurrent(offscreenSurface.get());

    QOpenGLFramebufferObjectFormat fboFormat;
    fboFormat.setAttachment(QOpenGLFramebufferObject::CombinedDepthStencil);
    fboFormat.setTextureTarget(GL_TEXTURE_2D);
    fboFormat.setInternalTextureFormat(GL_RGBA8);
    //fboFormat.setSamples(4);
    frameBuffer.reset(new QOpenGLFramebufferObject(dimensions, fboFormat));

    quickWindow->setRenderTarget(frameBuffer.get());

    qDebug() << "valid fbo " << frameBuffer->isValid() << " size " << frameBuffer->height() << frameBuffer->width();

    qDebug() << "Created fbo - " << frameBuffer->texture();

    texture = iris::Texture2D::createFromId(frameBuffer->texture());
    auto gl = openglContext->functions();
    gl->glBindTexture(GL_TEXTURE_2D, frameBuffer->texture());
    gl->glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    gl->glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    gl->glBindTexture(GL_TEXTURE_2D, 0);
}

void OverlayController::destroyFramebuffer()
{
    // reset fbo
}

void OverlayController::render()
{
    if (!openglContext->makeCurrent(offscreenSurface.get())) return;

    // Polish, synchronize and render the next frame (into our fbo).  In this example
    // everything happens on the same thread and therefore all three steps are performed
    // in succession from here. In a threaded setup the render() call would happen on a
    // separate thread.
    renderControl->polishItems();
    renderControl->sync();
    renderControl->render();

    quickWindow->resetOpenGLState();
    QOpenGLFramebufferObject::bindDefault();

    openglContext->functions()->glFlush();

    quickReady = true;

    // Get something onto the screen.
    //sceneView->acceptQMLFramebuffer(openglContext.get(), quickReady ? frameBuffer->texture() : 0);
    if (quickReady) {
        //texture->texture->bind(frameBuffer->texture());
        //qDebug() << "test" << frameBuffer->texture();
        //renderControl->grab().save(QString("C:/Users/iKlsR/Desktop/files/squidward%1.png").arg(QString::number(counter++)));

        //QImage fboImage(frameBuffer->toImage());
        //fboImage.save(QString("C:/Users/Jahshaka/Desktop/files/squidward%1.png").arg(QString::number(counter++)));
    }
}

void OverlayController::requestUpdate()
{
    if (!updateTimer.isActive()) updateTimer.start();
}

void OverlayController::handleScreenChange()
{

}

void OverlayController::updateScene(const OverlayScene &scene)
{

}

void OverlayController::updateSizes()
{
    // Behave like SizeRootObjectToView.
    rootItem->setWidth(dimensions.width());
    rootItem->setHeight(dimensions.height());

    quickWindow->setGeometry(0, 0, dimensions.width(), dimensions.height());
}

void OverlayController::startQuick(const QString &pathToQML)
{
    qmlComponent.reset(new QQmlComponent(qmlEngine.get(), QUrl(pathToQML)));
    if (qmlComponent->isLoading())
        connect(qmlComponent.get(), &QQmlComponent::statusChanged, this, &OverlayController::run);
    else
        run();
}