cmake_minimum_required(VERSION 3.3 FATAL_ERROR)
add_compile_options($<$<CXX_COMPILER_ID:MSVC>:/MP>)
foreach(p CMP0071) # 3.10: Let AUTOMOC and AUTOUIC process GENERATED files
    if(POLICY ${p})
        cmake_policy(SET ${p} NEW)
    endif()
endforeach()
project(Player)

set(APP_OUTPUT_NAME "Jahshaka Player")

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(OpenGL REQUIRED) # is this needed?
find_package(Qt5 REQUIRED COMPONENTS Concurrent Network Widgets Sql Svg)

include(UseModernCpp)
include(BuildType)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY AUTOGEN_TARGETS_FOLDER AutoMocFolder)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/irisgl)

set(SRCS
    src/main.cpp
    src/mainwindow.cpp 
    src/dialogs/preferencesdialog.cpp 
    src/dialogs/aboutdialog.cpp 
    src/dialogs/preferences/worldsettings.cpp 
    src/dialogs/loadmeshdialog.cpp 
    src/core/nodekeyframeanimation.cpp 
    src/core/project.cpp 
    src/core/settingsmanager.cpp 
    src/core/surfaceview.cpp 
    src/editor/editorcameracontroller.cpp 
    src/dialogs/infodialog.cpp 
    src/globals.cpp 
    src/widgets/sceneviewwidget.cpp 
    src/editor/cameracontrollerbase.cpp 
    src/widgets/skypresets.cpp 
    src/editor/orbitalcameracontroller.cpp 
    src/io/scenewriter.cpp 
    src/core/thumbnailmanager.cpp 
    src/io/assetiobase.cpp 
    src/io/materialpresetreader.cpp 
    src/core/keyboardstate.cpp 
    src/io/scenereader.cpp 
    src/editor/editorvrcontroller.cpp 
    src/io/materialreader.cpp 
    src/dialogs/newprojectdialog.cpp 
    src/io/assetmanager.cpp 
    src/uimanager.cpp 
    src/dialogs/getnamedialog.cpp 
    src/core/database/database.cpp 
    src/core/database/projectdatabase.cpp 
    src/core/guidmanager.cpp 
    src/dialogs/progressdialog.cpp 
    src/widgets/screenshotwidget.cpp 
    src/widgets/projectmanager.cpp 
    src/widgets/dynamicgrid.cpp 
    src/widgets/itemgridwidget.cpp 
    src/dialogs/renameprojectdialog.cpp 
    src/editor/thumbnailgenerator.cpp 
    src/widgets/mainwindowviewport.cpp 
    src/editor/viewercontroller.cpp 
    src/dialogs/donatedialog.cpp
	src/editor/outlinerenderer.cpp
	src/editor/viewermaterial.cpp
	src/editor/animationpath.cpp
    src/constants.cpp
	src/misc/updatechecker.cpp
	src/dialogs/softwareupdatedialog.cpp
    src/core/assethelper.cpp
    src/core/scenenodehelper.cpp
    src/misc/upgrader.cpp
    src/misc/QtAwesome.cpp
    src/misc/QtAwesomeAnim.cpp
    src/dialogs/toast.cpp
    src/helpers/tooltip.cpp
    src/widgets/colorvaluewidget.cpp
    src/widgets/colorpickerwidget.cpp
    src/widgets/colorchooser.cpp
    src/widgets/colorcircle.cpp
)

set(HEADERS
    src/mainwindow.h 
    src/helpers/settingshelper.h 
    src/dialogs/preferencesdialog.h 
    src/dialogs/aboutdialog.h 
    src/dialogs/preferences/worldsettings.h 
    src/helpers/collisionhelper.h 
    src/dialogs/infodialog.h 
    src/dialogs/loadmeshdialog.h 
    src/core/keyframeanimation.h 
    src/core/keyframes.h 
    src/core/nodekeyframe.h 
    src/core/nodekeyframeanimation.h 
    src/core/project.h 
    src/core/settingsmanager.h 
    src/core/surfaceview.h 
    src/editor/editorcameracontroller.h 
    src/globals.h 
    src/widgets/sceneviewwidget.h 
    src/editor/orbitalcameracontroller.h 
    src/editor/cameracontrollerbase.h 
    src/widgets/skypresets.h 
    src/io/scenewriter.h 
    src/io/scenereader.h 
    src/core/thumbnailmanager.h 
    src/core/meshmanager.h 
    src/io/assetiobase.h 
    src/core/materialpreset.h 
    src/io/materialpresetreader.h 
    src/io/materialpresetreader.h 
    src/core/keyboardstate.h 
    src/editor/editordata.h 
    src/editor/editorvrcontroller.h 
    src/io/materialreader.hpp 
    src/dialogs/newprojectdialog.h 
    src/io/assetmanager.h 
    src/constants.h 
    src/uimanager.h 
    src/dialogs/getnamedialog.h 
    src/core/database/database.h 
    src/core/database/projectdatabase.h 
    src/core/guidmanager.h 
    src/dialogs/progressdialog.h 
    src/widgets/screenshotwidget.h 
    src/widgets/projectmanager.h 
    src/widgets/dynamicgrid.h 
    src/widgets/itemgridwidget.hpp 
    src/dialogs/renameprojectdialog.h 
    src/editor/thumbnailgenerator.h 
    src/widgets/mainwindowviewport.h 
    src/editor/viewercontroller.h 
    src/dialogs/donatedialog.h
	src/materials/jahdefaultmaterial.h
    src/editor/outlinerenderer.h 
    src/editor/viewermaterial.h
    src/editor/animationpath.h
    src/misc/updatechecker.h
    src/dialogs/softwareupdatedialog.h
    src/editor/animationpath.h
    src/core/assethelper.h
    src/core/scenenodehelper.h
    src/misc/upgrader.h
    src/misc/QtAwesome.h
    src/misc/QtAwesomeAnim.h 
    src/dialogs/toast.h
	src/helpers/tooltip.h
    src/subclass/switch.h
    src/widgets/basewidget.h
    src/widgets/colorvaluewidget.h
    src/widgets/colorpickerwidget.h
    src/widgets/colorchooser.h
    src/widgets/colorcircle.h
)

# Todo - trim these down to nothing eventually
set(FORMS
    src/dialogs/preferencesdialog.ui 
    src/dialogs/aboutdialog.ui 
    src/dialogs/preferences/worldsettings.ui 
    src/dialogs/infodialog.ui 
    src/dialogs/loadmeshdialog.ui 
    src/widgets/skypresets.ui 
    src/widgets/colorvaluewidget.ui 
    src/widgets/colorpickerwidget.ui 
    src/mainwindow.ui 
    src/dialogs/newprojectdialog.ui 
    src/dialogs/getnamedialog.ui 
    src/dialogs/progressdialog.ui 
    src/widgets/screenshotwidget.ui 
    src/widgets/projectmanager.ui 
    src/dialogs/renameprojectdialog.ui 
    src/dialogs/donate.ui
    src/dialogs/softwareupdatedialog.ui
)

set(LIBS Qt5::Concurrent Qt5::Sql Qt5::Svg Qt5::Widgets Qt5::Network IrisGL ${OPENGL_LIBRARIES})

#include(IncludeMiner)

# these macros are deprecated
#qt5_wrap_cpp(HEADERS_moc ${HEADERS})
#qt5_wrap_ui(UI_moc ${FORMS})

# Todo - trim these down to nothing eventually
qt5_add_resources(QRCS
    ${CMAKE_SOURCE_DIR}/app/fonts.qrc
    ${CMAKE_SOURCE_DIR}/app/icons.qrc
    ${CMAKE_SOURCE_DIR}/app/images.qrc
    ${CMAKE_SOURCE_DIR}/app/models.qrc
    ${CMAKE_SOURCE_DIR}/app/shaders.qrc 
)

# Disable compiler specific warnings if we are building with MSVC
# NOMINMAX - http://www.suodenjoki.dk/us/archive/2010/min-max.htm
if(MSVC)
    add_definitions("-D_CRT_SECURE_NO_WARNINGS" "-DNOMINMAX")
    # Disable ZERO_CHECK if need be
    # set(CMAKE_SUPPRESS_REGENERATION true)
endif()

if(WIN32 AND CMAKE_BUILD_TYPE STREQUAL Release)
    set(CMAKE_WIN32_EXECUTABLE ON)
endif()

if(${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
    set(DestDir ${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})
    # set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${CMAKE_PROJECT_NAME})
else()
    set(DestDir ${CMAKE_BINARY_DIR}/bin)
endif()

# git commit hash macro
execute_process(
    COMMAND git log -1 --pretty=format:%h
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_COMMIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
add_definitions("-DGIT_COMMIT_HASH=\"${GIT_COMMIT_HASH}\"")

execute_process(
    COMMAND git log -1 --pretty=format:%cd
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_COMMIT_DATE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
add_definitions("-DGIT_COMMIT_DATE=\"${GIT_COMMIT_DATE}\"")

# For convenience, put the shared files built from IrisGL along with the final binary
# Also note MSVC build path is different from GNU in that it containts the build type
set_target_properties(IrisGL PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set_target_properties(assimp PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
if (MINER_ENABLED)
    set_target_properties(JahMiner PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()
#set_target_properties(cuda_gpu_list PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# osx icon
# https://stackoverflow.com/questions/22745728/cmake-set-icon-for-a-mac-osx-app

set(MACOSX_BUNDLE_ICON_FILE iconp.icns)
set(BUNDLE_ICON ${CMAKE_CURRENT_SOURCE_DIR}/app/icons/iconp.icns)

set_source_files_properties(${BUNDLE_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

# https://stackoverflow.com/a/37211780/996468
source_group(moc FILES ${HEADERS_moc} ${QRCS})

add_executable(${CMAKE_PROJECT_NAME} MACOSX_BUNDLE src/main.cpp ${SRCS} ${HEADERS_moc} ${QRCS} app/winapp_player.rc ${BUNDLE_ICON})

set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${APP_OUTPUT_NAME})

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${CMAKE_PROJECT_NAME})
target_include_directories(${PROJECT_NAME} PUBLIC
							src
							irisgl/include
							irisgl/src
							irisgl/src/assimp/include
                            irisgl/src/libovr/Include
                            irisgl/src/bullet3/src/)
   
target_link_libraries(${CMAKE_PROJECT_NAME} ${LIBS})

include(CopyResources)
include(CopyDependencies)

