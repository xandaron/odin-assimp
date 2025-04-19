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

cmake ./assimp/CMakeLists.txt -DBUILD_SHARED_LIBS=OFF -DASSIMP_BUILD_TESTS=OFF -DASSIMP_INSTALL=OFF -DASSIMP_INSTALL_PDB=OFF -B build
cmake --build build

where /Q bindgen.exe
if %ERRORLEVEL% == 0 (
    bindgen .
) else (
    echo ERROR: bindgen.exe not found in PATH. Please ensure it's installed correctly.
    echo You can run bindgen manually with: bindgen .
    exit /b 1
)

copy /y .\build\lib\Debug\assimp-vc143-mtd.lib .\odin-assimp\libassimp-windows.lib
copy /y .\assimp\LICENSE .\odin-assimp\LICENSE