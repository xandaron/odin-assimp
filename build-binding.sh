#! /bin/bash

git submodule update --init --recursive

cmake ./assimp/CMakeLists.txt -DASSIMP_INJECT_DEBUG_POSTFIX=OFF -DASSIMP_BUILD_ZLIB=ON -DBUILD_SHARED_LIBS=OFF -DASSIMP_BUILD_TESTS=OFF -DASSIMP_INSTALL=OFF -B build
cmake --build build

mkdir odin-assimp

mv build/lib/libassimp.a odin-assimp/libassimp.a
cp assimp/LICENSE odin-assimp/LICENSE

# Check if bindgen exists
if command -v bindgen &> /dev/null; then
    bindgen .
else
    echo "ERROR: bindgen not found in PATH. Please ensure it's installed correctly."
    echo "You can run bindgen manually with: bindgen ."
    exit 1
fi

# Find available Python command
PYTHON_CMD=""

# Try python3 first (preferred on modern Linux)
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
# Fall back to python if python3 isn't available
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
fi

# If we found a valid Python command, use it
if [ -n "$PYTHON_CMD" ]; then
    $PYTHON_CMD cleanup.py
else
    echo "ERROR: No Python installation found in PATH."
    exit 1
fi