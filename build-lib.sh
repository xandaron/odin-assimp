#! /bin/bash

git submodule update --init --recursive

cmake ./assimp/CMakeLists.txt -DASSIMP_INJECT_DEBUG_POSTFIX=OFF -DASSIMP_BUILD_ZLIB=ON -DBUILD_SHARED_LIBS=OFF -DASSIMP_BUILD_TESTS=OFF -DASSIMP_INSTALL=OFF -B build
cmake --build build

mkdir odin-assimp

mv build/lib/libassimp.a odin-assimp/libassimp.a
cp assimp/LICENSE odin-assimp/LICENSE