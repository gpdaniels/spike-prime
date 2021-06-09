# Controller #

An attempt to create an application that can communicate with a hub to allow for remote control / sending of scripts / sensor logging without needing any of the LEGO apps.

## Android ##

The android controller opens up a bluetooth connection to the first paired device and logs any serial data received.

The controller can be built either using the command line (and CMake) or Android Studio.

To build on the command line you will need the paths to both the android sdk and ndk, and your java home. 

```shell
cd controller-android
mkdir BUILD
cd BUILD
cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
    -DANDROID_SDK=${ANDROID_SDK_ROOT} \
    -DANDROID_NDK=${ANDROID_NDK_ROOT} \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_STL=c++_static \
    -DJAVA_HOME=${JAVA_HOME} \
    ..
cmake --build .
```

To install and launch the app on a connected device using adb you can use this target:

```shell
cmake --build . --target apk-deploy
```

## Desktop ##

So far just a skeleton of a console program. To build it on linux you will need the bluetooth library.

```shell
sudo apt-get install libbluetooth-dev
```

```shell
cd controller-desktop
mkdir BUILD
cd BUILD
cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    ..
cmake --build .
```
