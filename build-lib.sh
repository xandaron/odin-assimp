#! /bin/bash

git submodule update --init --recursive

cmake assimp/CMakeLists.txt -DBUILD_SHARED_LIBS=OFF -DASSIMP_BUILD_TESTS=OFF -DASSIMP_INSTALL=OFF -DASSIMP_INSTALL_PDB=OFF -B build
cmake --build build

cp build/lib/libassimp.a odin-assimp/libassimp-linux.a
cp assimp/LICENSE odin-assimp/LICENSE