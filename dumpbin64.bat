@echo off
setlocal

call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

set "CMAKE_BINARY_DIR=cmake-build-release-x64"
if /I NOT "%1"=="" set "CMAKE_BINARY_DIR=%1"
set "DUMPBIN_DIR=%CMAKE_BINARY_DIR:build=dump%"

pushd %~dp0
mkdir %DUMPBIN_DIR%

pushd %DUMPBIN_DIR%

    dumpbin /headers ..\%CMAKE_BINARY_DIR%\lua.exe > lua.exe.headers.txt
    dumpbin /exports ..\%CMAKE_BINARY_DIR%\lua.exe > lua.exe.exports.txt
    dumpbin /dependents ..\%CMAKE_BINARY_DIR%\lua.exe > lua.exe.dependents.txt
    dumpbin /imports ..\%CMAKE_BINARY_DIR%\lua.exe > lua.exe.imports.txt

    dumpbin /headers ..\%CMAKE_BINARY_DIR%\luac.exe > luac.exe.headers.txt
    dumpbin /exports ..\%CMAKE_BINARY_DIR%\luac.exe > luac.exe.exports.txt
    dumpbin /dependents ..\%CMAKE_BINARY_DIR%\luac.exe > luac.exe.dependents.txt
    dumpbin /imports ..\%CMAKE_BINARY_DIR%\luac.exe > luac.exe.imports.txt

    dumpbin /headers ..\%CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.headers.txt
    dumpbin /exports ..\%CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.exports.txt
    dumpbin /dependents ..\%CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.dependents.txt
    dumpbin /imports ..\%CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.imports.txt

popd
popd

endlocal
