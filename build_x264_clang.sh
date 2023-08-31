#!/bin/bash

export NDK=/home/w/ffmpeg/android-ndk-r20b #这里配置先你的 NDK 路径
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64


function build_android
{
./configure \
    --prefix=$PREFIX \
	  --disable-cli \
    --disable-shared \
    --enable-static \
    --enable-pic \
    --host=$my_host \
	--cross-prefix=$CROSS_PREFIX \
    --sysroot=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot \

make clean
make -j8
make install
}

#arm64-v8a
API=21
PREFIX=./android/arm64-v8a
my_host=aarch64-linux-android
export TARGET=aarch64-linux-android
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
build_android

#armeabi-v7a
PREFIX=./android/armeabi-v7a
API=19
my_host=armv7a-linux-android
export TARGET=armv7a-linux-androideabi
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
build_android
