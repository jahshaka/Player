/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef EDITORCAMERACONTROLLER_H
#define EDITORCAMERACONTROLLER_H

#include <QPoint>
#include <QVector3D>
#include <QSharedPointer>
#include "cameracontrollerbase.h"

namespace iris
{
    class CameraNode;
}

class SceneViewWidget;
class EditorCameraController : public CameraControllerBase
{
    QSharedPointer<iris::CameraNode> camera;

    float lookSpeed;
    float linearSpeed;

    float yaw;
    float pitch;

	float orthoZoom;

	SceneViewWidget* sceneWidget;

	bool movementEnabled;
	bool zoomEnabled;
	bool panEnabled;

public:
    EditorCameraController(SceneViewWidget* sceneWidget);

    QSharedPointer<iris::CameraNode>  getCamera();
    void setCamera(QSharedPointer<iris::CameraNode>  cam) override;

    QVector3D getPos();

    void setLinearSpeed(float speed);
    float getLinearSpeed();

    void setLookSpeed(float speed);
    float getLookSpeed();

    //incomplete
    void tilt(float angle);

    //incomplete
    void pan(float angle);

    void onMouseMove(int x,int y) override;
    void onMouseWheel(int delta) override;
	void onKeyPressed(Qt::Key key);
	void onKeyReleased(Qt::Key key);

    void updateCameraRot();

    void update(float dt);

	bool canLeftMouseDrag();

	void enableMovement(bool enable = true);
	void disableMovement()
	{
		enableMovement(false);
	}

	void enableZoom(bool enable = true);
	void disableZoom()
	{
		enableZoom(false);
	}

	void enablePan(bool enable = true)
	{
		panEnabled = enable;
	}

	void disablePan()
	{
		enablePan(false);
	}
};

#endif // EDITORCAMERACONTROLLER_H
