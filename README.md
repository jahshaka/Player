## Building From Source

### Requirements
- Git
- Cmake *(latest version recommended)*
- Qt versions *5.7* to *5.9* are recommended *(other versions might work but aren't tested, versions that will break are 5.8 and 5.9.4)*
- A C++ compiler with support for C++11 or later (choose a compiler for your OS when installing the Qt SDK. G++, MSVC and clang are all supported). If building on Windows, choose the default mingw compiler `MinGW 5.3.0 32 bit` as well as `msvc2017 64-bit` so you can build with Visual Studio as well which is what we recommend.
- Qt Creator (also comes with the Qt SDK, latest version recommended) *AND OR* Microsoft Visual Studio 2017 Community Edition

### Build steps
Stable (usually months old releases are available by default), for up to date code (might include bugs), checkout the [`dev` branch](https://github.com/jahshaka/VR/tree/dev) instead of `master`

- Clone the repo from the project page or download a zipped copy of the source for a specific version from the Releases tab
- Fetch the submodules by opening a command window inside the project and using `git submodule update --init --recursive`

If you will be cloning the repo you can do both steps in one command by using `git clone --recurse-submodules -j8 git://github.com/jahshaka/VR.git`. See https://stackoverflow.com/a/4438292/996468

Again, if you want to build the latest code, you might want to do a `git checkout dev` at this point.

**If using Qt Creator (on any platform)**
- If you are on a nix based system you will also need to install the QtQuick modules `libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtquick-layouts qml-module-qtquick-extras` 
- Make sure Cmake has been installed and properly added to your path.
- Open the `CMakeLists.txt` file (it will run and configure the default build target).
- Build the application.

**If using MSVC (recommended for x64 builds)**
- There are several ways to go about this, the easiest is to use the `cmake-gui` tool.
- Point to the folder where you have the source and a folder where you want to build by using the Browse Source and Browse Build buttons respectively.
- Add Qt to cmake's prefix path by pressing Add Entry, for name enter `CMAKE_PREFIX_PATH`, type should be set to `PATH` and the value should point to where you installed Qt and the msvc tools for example `C:\Qt\5.9.2\msvc2017_64`.
- Press Configure and for the generator select `Visual Studio 15 2017 Win64` and then Finish.
- Now press Generate and finally you can use the Open Project button to launch visual studio with the solution opened.
- Finally, you might want to change the build target from the default `ALL_BUILD` to `Jahshaka` in the Solution Explorer.
- Build the application.

- After building, due to how the QML tooling for Qt is at the moment, it's not possible to have it copy over the QML libraries automatically `windeployqt.exe` has to be run manually. This is located at `C:/Qt/bin/windeployqt.exe`. Run it with `--qmldir="path_to_qml_dir`. For example `C:/Qt/bin/windeployqt.exe --qmldir=C:/Qt/5.9.3/msvc2017_64/qml Jahshaka\ Player.exe`.
- Depending on the version of Qt you have, you will need to get the matching dlls for OpenSSL that Qt was built with. Inside the console on first run you will see something like *SSL version use for build:  "OpenSSL 1.0.2j  26 Sep 2016"*, navigate to https://indy.fulgan.com/SSL/Archive/ and find the matching package for x64 and copy `libeay32.dll` and `ssleay32.dll` to the same directory as your executable.

If you encounter any issues building, please open an issue.

## License(GPLv3)
    http://www.jahshaka.com
    Copyright (c) 2016 Jahshaka LLC <coders@jahshaka.com>

    This is free software: you may copy, redistribute
    and/or modify it under the terms of the GPLv3 License

    For more information see the LICENSE file