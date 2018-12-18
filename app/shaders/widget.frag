/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#version 150 core

uniform sampler2D u_matTexture;

in vec2 v_texCoord;

out vec4 fragColor;

void main()
{
    fragColor = texture( u_matTexture, v_texCoord ).rgba;
}