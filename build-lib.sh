#!/bin/bash

# Exit on any error
set -e

# Update git submodules
git submodule update --init --recursive

# Check if cmake is available
if ! command -v cmake &> /dev/null; then
    echo "ERROR: cmake is not installed or not in PATH"
    echo "Please install cmake: sudo apt-get install cmake (Ubuntu/Debian)"
    exit 1
fi

# Check if build tools are available
if ! command -v make &> /dev/null && ! command -v ninja &> /dev/null; then
    echo "ERROR: No build system found (make or ninja)"
    echo "Please install build tools: sudo apt-get install build-essential (Ubuntu/Debian)"
    exit 1
fi

# Set source and build directories
SOURCE_DIR="./assimp"
BINARIES_DIR="./build/linux"

# Configure the build with cmake
echo "Configuring build..."
cmake "$SOURCE_DIR" -S "$SOURCE_DIR" -B "$BINARIES_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DASSIMP_BUILD_TESTS=OFF \
    -DASSIMP_INSTALL=ON \
    -DASSIMP_INSTALL_PDB=OFF

# Build the project
echo "Building project..."
cmake --build "$BINARIES_DIR" --config Release

# Create output directory if it doesn't exist
mkdir -p "./odin-assimp"

# Copy the license
echo "Copying license..."
cp "./assimp/LICENSE" "./odin-assimp/LICENSE"

echo "Build completed successfully!"
