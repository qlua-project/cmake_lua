@echo off
if /I NOT "%1" == "/ENV" setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
if /I "%1" == "/ENV" goto EOF

set "_CONFIGBUILD="

if /I "%1"=="/DEBUG" (
    set cmake_build_dir=cmake-build-debug-%VSCMD_ARG_HOST_ARCH%
    set CMAKE_BUILD_TYPE=Debug

    if /I "%2" == "/CLEAN" goto CLEAN
    if /I "%2" == "/SYSINFO" goto SYSINFO
    if /I "%2" == "/BUILD" goto BUILD
    if /I "%2" == "/INSTALL" goto INSTALL
    if /I "%2" == "/DUMP" goto DUMPBIN
    if /I "%2" == "/DUMPBIN" goto DUMPBIN
    if /I "%2" == "/DEL" goto DELETE
    if /I "%2" == "/DELETE" goto DELETE
    if /I "%2" == "" set _CONFIGBUILD=yes
) else (
    set cmake_build_dir=cmake-build-release-%VSCMD_ARG_HOST_ARCH%
    set CMAKE_BUILD_TYPE=Release

    if /I "%1" == "/CLEAN" goto CLEAN
    if /I "%1" == "/SYSINFO" goto SYSINFO
    if /I "%1" == "/BUILD" goto BUILD
    if /I "%1" == "/INSTALL" goto INSTALL
    if /I "%1" == "/DUMP" goto DUMPBIN
    if /I "%1" == "/DUMPBIN" goto DUMPBIN
    if /I "%1" == "/DEL" goto DELETE
    if /I "%1" == "/DELETE" goto DELETE
    if /I "%1" == "" set _CONFIGBUILD=yes
)
set INSTALL_DIR=%~dp0

pushd %~dp0

:CONFIG
if NOT "%_CONFIGBUILD%" == "" echo - - - - - - - - - - - - - - - - - - - -
:: -G "NMake Makefiles" to skip Visual Studio project files which are generated by default.
:: -Wdev Enable developer warnings that are meant for the author of the CMakeLists.txt files.
:: -L This will effectively display current CMake settings.
:: --log-context message() command outputting context attached to each message
cmake -G "NMake Makefiles" -Wdev --warn-uninitialized --log-context -L -B "%cmake_build_dir%" --install-prefix "%INSTALL_DIR:~0,-1%"

if ERRORLEVEL==1 goto END
if NOT "%_CONFIGBUILD%" == "" goto BUILD
goto END

:BUILD
if NOT "%_CONFIGBUILD%" == "" echo - - - - - - - - - - - - - - - - - - - -
cmake --build "%cmake_build_dir%"

if ERRORLEVEL==1 goto END
if NOT "%_CONFIGBUILD%" == "" goto INSTALL
goto END

:INSTALL
if NOT "%_CONFIGBUILD%" == "" echo - - - - - - - - - - - - - - - - - - - -
cmake --install "%cmake_build_dir%"

if ERRORLEVEL==1 goto END
rem if NOT "%_CONFIGBUILD%" == "" goto DUMPBIN
goto END

:SYSINFO
:: --system-information [file] it will dump additional information such as the cache, log files etc.
cmake -G "NMake Makefiles" --system-information "cmake-build-sysinfo.txt"

goto END

:CLEAN
call del /Q %cmake_build_dir%\CMakeCache.txt"

goto END

:DELETE
rmdir /s /q "%cmake_build_dir%"

goto END

:DUMPBIN
dumpbin64.bat %cmake_build_dir%

:END
popd

:ENDLOCAL
endlocal

:EOF
