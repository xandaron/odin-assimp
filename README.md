# Odin-Assimp

Odin bindings for the Open Asset Import Library (Assimp), allowing you to import various 3D model formats into your Odin applications.

## Overview

This project provides Odin bindings to the [Assimp](https://github.com/assimp/assimp) library, which is a popular C++ library that loads various 3D file formats into a shared, in-memory format. Assimp supports more than 40 file formats for import and a growing selection of file formats for export.

With these bindings, you can:
- Load 3D models from multiple formats (FBX, OBJ, GLTF, etc.)
- Access mesh data, materials, textures, and animations
- Apply various post-processing steps to optimize your 3D models
- Export models to different formats

## Dependencies

- [Odin](https://odin-lang.org/) compiler
- C/C++ compiler (GCC, MSVC, Clang)
- CMake (version 3.10 or higher)
- [bindgen](https://github.com/karl-zylinski/odin-c-bindgen) (Make sure to add the executable to your PATH)

> **NOTE**: VS build tools is the recomended build tool for windows. It's required for the odin compiler and comes with a C/C++ compiler and CMake (You might need to add the CMake component).

## Building

### Build Assimp Library

First, you need to build the Assimp library using the provided build scripts:

```bash
# Clone the repo if you haven't already
git clone https://github.com/your-username/odin-assimp.git
cd odin-assimp

# To build libassimp and update the bindings
# Windows:
./build-binding.bat

# Linux:
./build-binding.sh

# To just build libassimp
# Windows:
./build-lib.bat

#Linux:
./build-lib.sh
```

## Supported 3D Formats

Assimp supports numerous file formats including (but not limited to):

- Autodesk FBX (.fbx)
- Wavefront OBJ (.obj)
- COLLADA (.dae)
- glTF (.gltf, .glb)
- STL (.stl)
- Blender (.blend)
- 3DS (.3ds)
- PLY (.ply)

For a complete list, refer to the [Assimp documentation](https://github.com/assimp/assimp/blob/master/doc/Fileformats.md).

## Post-Processing Options

The bindings support all Assimp post-processing flags, allowing you to:

- Triangulate polygons
- Generate normals and tangents
- Join identical vertices
- Optimize meshes for vertex cache locality
- And many more

## License

This project is licensed under the MIT License - see the LICENSE file for details. The Assimp library is licensed under a modified, 3-clause BSD-License.
