#
# The MIT License
# Copyright (c) 2020 Geoffrey Daniels. http://gpdaniels.com/
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE
#

# Define the minimum version of CMake that is required.
CMAKE_MINIMUM_REQUIRED(VERSION 3.5.1)
CMAKE_POLICY(VERSION 3.5.1)

# Project name.
SET(COMPANY_NAME "gpdaniels")
SET(PROJECT_NAME "controller")
SET(PACKAGE_NAME "com.${COMPANY_NAME}.${PROJECT_NAME}")
PROJECT(${PROJECT_NAME})

# Check for all the paths/variables we need, these are:
#  ANDROID_SDK - The android sdk.
#  ANDROID_NDK - The android ndk.
#  ANDROID_PLATFORM - The desired android platform to target.
#  JAVA_HOME - The java path.
IF(NOT DEFINED ANDROID_SDK)
    IF(DEFINED $ENV{ANDROID_SDK})
        SET(ANDROID_SDK "$ENV{ANDROID_SDK}" CACHE PATH "The android sdk path.")
    ENDIF()
    # Could add other paths to check here.
    #...
    IF(NOT DEFINED ANDROID_SDK)
        MESSAGE(FATAL_ERROR "Please provide the android sdk path in the variable ANDROID_SDK.")
    ENDIF()
ENDIF()

IF(NOT DEFINED ANDROID_NDK)
    IF(DEFINED $ENV{ANDROID_NDK})
        SET(ANDROID_NDK "$ENV{ANDROID_NDK}" CACHE PATH "The android ndk path.")
    ENDIF()
    # Could add other paths to check here.
    #...
    IF(NOT DEFINED ANDROID_NDK)
        MESSAGE(FATAL_ERROR "Please provide the android ndk path in the variable ANDROID_NDK.")
    ENDIF()
ENDIF()

IF(NOT DEFINED ANDROID_PLATFORM)
    IF(DEFINED $ENV{ANDROID_PLATFORM})
        SET(ANDROID_PLATFORM "$ENV{ANDROID_PLATFORM}" CACHE PATH "The desired android platform.")
    ENDIF()
    # Could add other paths to check here.
    #...
    IF(NOT DEFINED ANDROID_PLATFORM)
        MESSAGE(FATAL_ERROR "Please provide the desired android platform in the variable ANDROID_PLATFORM.")
    ENDIF()
ENDIF()

IF(NOT DEFINED JAVA_HOME)
    IF(DEFINED $ENV{JAVA_HOME})
        SET(JAVA_HOME "$ENV{JAVA_HOME}" CACHE PATH "The java path.")
    ENDIF()
    # Could add other paths to check here.
    #...
    IF(NOT DEFINED JAVA_HOME)
        MESSAGE(FATAL_ERROR "Please provide the java path in the variable JAVA_HOME.")
    ENDIF()
ENDIF()

# Get all installed android build-tools versions.
FILE(GLOB ANDROID_BUILD_TOOLS_DIR_LIST RELATIVE "${ANDROID_SDK}/build-tools" "${ANDROID_SDK}/build-tools/*")
SET(ANDROID_BUILD_TOOLS_VERSIONS "")
FOREACH(ANDROID_BUILD_TOOLS_DIR ${ANDROID_BUILD_TOOLS_DIR_LIST})
    IF(IS_DIRECTORY "${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_DIR}")
        LIST(APPEND ANDROID_BUILD_TOOLS_VERSIONS ${ANDROID_BUILD_TOOLS_DIR})
    ENDIF()
ENDFOREACH()
# Sort and reverse to get the most recent.
LIST(SORT ANDROID_BUILD_TOOLS_VERSIONS)
LIST(REVERSE ANDROID_BUILD_TOOLS_VERSIONS)
LIST(GET ANDROID_BUILD_TOOLS_VERSIONS 0 ANDROID_BUILD_TOOLS_VERSION_MAX)

# Get all installed android platform versions.
FILE(GLOB ANDROID_PLATFORMS_DIR_LIST RELATIVE "${ANDROID_SDK}/platforms" "${ANDROID_SDK}/platforms/*")
SET(ANDROID_PLATFORMS "")
FOREACH(ANDROID_PLATFORMS_DIR ${ANDROID_PLATFORMS_DIR_LIST})
    IF(IS_DIRECTORY "${ANDROID_SDK}/platforms/${ANDROID_PLATFORMS_DIR}")
        LIST(APPEND ANDROID_PLATFORMS ${ANDROID_PLATFORMS_DIR})
    ENDIF()
ENDFOREACH()
# Sort and reverse to get the most recent.
LIST(SORT ANDROID_PLATFORMS)
LIST(REVERSE ANDROID_PLATFORMS)
LIST(GET ANDROID_PLATFORMS 0 ANDROID_PLATFORM_MAX)

# Android paths, variables, and tools.
SET(ANDROID_AAPT            "${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION_MAX}/aapt")
SET(ANDROID_JAR             "${ANDROID_SDK}/platforms/${ANDROID_PLATFORM_MAX}/android.jar")
SET(ANDROID_DX              "${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION_MAX}/dx")
SET(ANDROID_ZIPALIGN        "${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION_MAX}/zipalign")
SET(ANDROID_ADB             "${ANDROID_SDK}/platform-tools/adb")

SET(JAVA_JARSIGNER          "${JAVA_HOME}/bin/jarsigner")
SET(JAVA_KEYTOOL            "${JAVA_HOME}/bin/keytool")
SET(JAVA_JAVAC              "${JAVA_HOME}/bin/javac")

SET(ANDROID_R_JAVA          "${CMAKE_BINARY_DIR}/src/com/${COMPANY_NAME}/${PROJECT_NAME}/R.java")
SET(ANDROID_R_CLASS         "${CMAKE_BINARY_DIR}/obj/com/${COMPANY_NAME}/${PROJECT_NAME}/R.class")
SET(ANDROID_CLASSES_DEX     "${CMAKE_BINARY_DIR}/bin/classes.dex")

SET(ANDROID_PLATFORMS        armeabi-v7a arm64-v8a x86 x86_64)

SET(ANDROID_KEYSTORE_DEBUG  "${CMAKE_BINARY_DIR}/keystore/debug.keystore")

SET(ANDROID_APK_UNSIGNED    "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.unsigned.apk")
SET(ANDROID_APK_UNALIGNED   "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.unaligned.apk")
SET(ANDROID_APK             "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.apk")

SET(ANDROID_STL             "c++_static")

################################################################################
# The build script. 
################################################################################
# NOTE: This is designed to produce no targets during the configure stage.
# NOTE: Rather when the "apk" target is built it will configure this project for each platform.
# NOTE: The "apk" target is then tied to ALL so that it runs for the default build.
IF(DEFINED CMAKE_TOOLCHAIN_FILE AND DEFINED ANDROID_ABI AND DEFINED ANDROID_STL)
    # Add the native app glue code from the NDK.
    ADD_LIBRARY(native_app_glue STATIC 
        "${ANDROID_NDK}/sources/android/native_app_glue/android_native_app_glue.h"
        "${ANDROID_NDK}/sources/android/native_app_glue/android_native_app_glue.c"
    )
    TARGET_INCLUDE_DIRECTORIES(native_app_glue PUBLIC "${ANDROID_NDK}/sources/android/native_app_glue")

    # Define a global symbol for the shared linker which is defined in the glue library.
    SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -u ANativeActivity_onCreate")

    # Add the project code.
    FILE(GLOB_RECURSE SOURCE_FILES CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/source/*.hpp" "${CMAKE_SOURCE_DIR}/source/*.cpp")
    ADD_LIBRARY(controller SHARED ${SOURCE_FILES})

    # Link the project to all the libraries.
    TARGET_LINK_LIBRARIES(controller native_app_glue)
    TARGET_LINK_LIBRARIES(controller android)
    TARGET_LINK_LIBRARIES(controller log)
    
ELSE()
    # The custom targets for making an apk and deploying to a phone/emulator.

    # Create the building targets.
    ADD_CUSTOM_TARGET(apk ALL
        DEPENDS "${ANDROID_APK}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Building apk..."
    )

    ADD_CUSTOM_TARGET(apk-install
        COMMAND "${ANDROID_ADB}" install -r "${ANDROID_APK}"
        DEPENDS "${ANDROID_APK}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Installing apk..."
    )

    ADD_CUSTOM_TARGET(apk-uninstall
        COMMAND "${ANDROID_ADB}" uninstall "${PACKAGE_NAME}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Uninstalling apk..."
    )

    ADD_CUSTOM_TARGET(apk-deploy
        COMMAND "${ANDROID_ADB}" install -r -d "${ANDROID_APK}"
        COMMAND "${ANDROID_ADB}" logcat -c
        COMMAND "${ANDROID_ADB}" shell monkey -p "${PACKAGE_NAME}" -c android.intent.category.LAUNCHER 1
        COMMAND "${ANDROID_ADB}" logcat -v brief -m 1 -e "Killing .*:${PACKAGE_NAME}/.*: remove task" --print ActivityManager:I "${PROJECT_NAME}:D" *:S
        DEPENDS "${ANDROID_APK}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Deploying apk..."
    )

    ADD_CUSTOM_TARGET(apk-force-stop
        COMMAND "${ANDROID_ADB}" shell am force-stop "${PACKAGE_NAME}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Uninstalling apk..."
    )

    ADD_CUSTOM_TARGET(apk-record
        COMMAND "${ANDROID_ADB}" shell screenrecord --time-limit 5 "/sdcard/screen.mp4"
        COMMAND "${ANDROID_ADB}" pull "/sdcard/screen.mp4" "${CMAKE_BINARY_DIR}/screen.mp4"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Recording screen for 5 seconds..."
    )
ENDIF()

################################################################################
# The building scripts of each apk part.
################################################################################

ADD_CUSTOM_COMMAND(
    OUTPUT  ${ANDROID_APK}
    COMMAND "${ANDROID_ZIPALIGN}" -f 4 "${ANDROID_APK_UNALIGNED}" "${ANDROID_APK}"
    DEPENDS "${ANDROID_APK_UNALIGNED}"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    COMMENT "Running zipalign..."
)

ADD_CUSTOM_COMMAND(
    OUTPUT  "${ANDROID_APK_UNALIGNED}"
    COMMAND "${JAVA_JARSIGNER}" -keystore "${ANDROID_KEYSTORE_DEBUG}" -storepass "android" -keypass "android" -signedjar "${ANDROID_APK_UNALIGNED}" "${ANDROID_APK_UNSIGNED}" "androiddebugkey"
    DEPENDS "${ANDROID_APK_UNSIGNED}" "${ANDROID_KEYSTORE_DEBUG}"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    COMMENT "Running jarsigner..."
)

SET(PLATFORM_PATHS "")
SET(PLATFORM_COMMANDS "")
FOREACH(PLATFORM ${ANDROID_PLATFORMS})
    LIST(APPEND PLATFORM_PATHS        "lib/${PLATFORM}/lib${PROJECT_NAME}.so" )
    LIST(APPEND PLATFORM_COMMANDS   COMMAND "${ANDROID_AAPT}" add "${ANDROID_APK_UNSIGNED}" "lib/${PLATFORM}/lib${PROJECT_NAME}.so")
ENDFOREACH()

ADD_CUSTOM_COMMAND(
    OUTPUT  "${ANDROID_APK_UNSIGNED}"
    COMMAND "${ANDROID_AAPT}" package -f -M "${CMAKE_SOURCE_DIR}/AndroidManifest.xml" -S "${CMAKE_SOURCE_DIR}/resources" -I "${ANDROID_JAR}" -F "${ANDROID_APK_UNSIGNED}"
    ${PLATFORM_COMMANDS}
    DEPENDS "${CMAKE_SOURCE_DIR}/AndroidManifest.xml" ${PLATFORM_PATHS}
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    COMMENT "Running aapt..."
)

ADD_CUSTOM_COMMAND(
    OUTPUT  "${ANDROID_KEYSTORE_DEBUG}"
    COMMAND "${CMAKE_COMMAND}" -E make_directory "${CMAKE_BINARY_DIR}/keystore"
    COMMAND "${JAVA_KEYTOOL}" -genkey -v -keystore "${ANDROID_KEYSTORE_DEBUG}" -dname "CN=Android Debug,O=Android,C=US" -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    COMMENT "Creating debug keystore..."
)

FOREACH(PLATFORM ${ANDROID_PLATFORMS})
    ADD_CUSTOM_COMMAND(
        OUTPUT  "lib/${PLATFORM}/lib${PROJECT_NAME}.so"
        COMMAND "${CMAKE_COMMAND}"
            -H"${CMAKE_SOURCE_DIR}"
            -B"${CMAKE_BINARY_DIR}/lib/${PLATFORM}/"
            -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake
            -DANDROID_SDK=${ANDROID_SDK}
            -DANDROID_NDK=${ANDROID_NDK}
            -DANDROID_PLATFORM=${ANDROID_PLATFORM}
            -DANDROID_ABI=${PLATFORM}
            -DANDROID_STL=${ANDROID_STL}
            -DJAVA_HOME=${JAVA_HOME}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}/lib/${PLATFORM}/"
        DEPENDS ${SOURCE_FILES}
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Creating c++ shared libraries (${PLATFORM})..."
    )
ENDFOREACH()
