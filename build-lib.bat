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

SET SOURCE_DIR=./assimp

SET BINARIES_DIR="./build/windows"
cmake ./assimp -A x64 -S %SOURCE_DIR% -B %BINARIES_DIR% -DBUILD_SHARED_LIBS=OFF -DASSIMP_BUILD_TESTS=OFF -DASSIMP_INSTALL=OFF -DASSIMP_INSTALL_PDB=OFF -DUSE_STATIC_CRT=ON
cmake --build %BINARIES_DIR% --config release

if not exist ".\odin-assimp" mkdir ".\odin-assimp"

move /y .\build\windows\lib\Release\assimp-vc143-mt.lib .\odin-assimp\libassimp.lib
copy /y .\assimp\LICENSE .\odin-assimp\LICENSE