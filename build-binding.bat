@echo off

git submodule update --init --recursive

setlocal EnableDelayedExpansion

where /Q cl.exe || (
	set __VSCMD_ARG_NO_LOGO=1
	for /f "tokens=*" %%i in ('"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath') do set VS=%%i
	if "!VS!" equ "" (
		echo ERROR: MSVC installation not found
		exit /b 1
	)
	call "!VS!\Common7\Tools\vsdevcmd.bat" -arch=x64 -host_arch=x64 || exit /b 1
)

if "%VSCMD_ARG_TGT_ARCH%" neq "x64" (
	if "%ODIN_IGNORE_MSVC_CHECK%" == "" (
		echo ERROR: please run this from MSVC x64 native tools command prompt, 32-bit target is not supported!
		exit /b 1
	)
)

REM I'm pretty sure we actually want ASSIMP_BUILD_ZLIB to be OFF but doing so causes the build to fail. Seems CMake requires zlib to be available for compilation.
cmake ./assimp/CMakeLists.txt -DASSIMP_BUILD_ZLIB=ON -DBUILD_SHARED_LIBS=OFF -DASSIMP_BUILD_TESTS=OFF -DASSIMP_INSTALL=OFF -DASSIMP_INSTALL_PDB=OFF -B build
cmake --build build

if not exist ".\odin-assimp" mkdir ".\odin-assimp"

move /y .\build\lib\Debug\assimp-vc143-mtd.lib .\odin-assimp\libassimp-windows.lib
copy /y .\assimp\LICENSE .\odin-assimp\LICENSE

where /Q bindgen.exe
if %ERRORLEVEL% == 0 (
    bindgen .
) else (
    echo ERROR: bindgen.exe not found in PATH. Please ensure it's installed correctly.
    echo You can run bindgen manually with: bindgen .
    exit /b 1
)

set PYTHON_CMD=

REM Try python command first (most common on Windows)
where /Q python.exe
if %ERRORLEVEL% == 0 (
    set PYTHON_CMD=python
) else (
    REM Try python3 command if python doesn't exist
    where /Q python3.exe
    if %ERRORLEVEL% == 0 (
        set PYTHON_CMD=python3
    )
)

REM If we found a valid Python command, use it
if "!PYTHON_CMD!" NEQ "" (
    !PYTHON_CMD! cleanup.py
) else (
    echo ERROR: No Python installation found in PATH.
    exit /b 1
)