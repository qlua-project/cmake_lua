cmake_minimum_required ( VERSION 3.30 )
project ( lua C )
set ( CMAKE_C_STANDARD 99 )
set ( CMAKE_C_STANDARD_REQUIRED True )
include( version.cmake )

include ( CMakePrintSystemInformation )
include ( CMakePrintHelpers )
cmake_print_variables (
  CMAKE_CURRENT_SOURCE_DIR
  )

add_compile_options( /W4 )  # -Wall

set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")

set ( LUA_DIR src.lua CACHE PATH "Where to search Lua sources." )
set ( LUAC_DIR src.luac CACHE PATH "Where to search Luac sources." )

lua_get_header_version( ${LUA_DIR} )

# see makefile
set ( SRC_CORE lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c
  lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c
  ltm.c lundump.c lvm.c lzio.c )  # ltests.c
set ( SRC_AUX lauxlib.c )
set ( SRC_LIB lbaselib.c ldblib.c liolib.c lmathlib.c loslib.c ltablib.c lstrlib.c
  lutf8lib.c loadlib.c lcorolib.c linit.c )
set ( SRC_LUA lua.c )
set ( SRC_LUAC luac.c )

set ( INSTALL_HEADERS lua.h luaconf.h lualib.h lauxlib.h lua.hpp )

list( TRANSFORM SRC_CORE PREPEND "${LUA_DIR}/" )
list( TRANSFORM SRC_LIB  PREPEND "${LUA_DIR}/" )
list( TRANSFORM SRC_AUX  PREPEND "${LUA_DIR}/" )
list( TRANSFORM SRC_LUA  PREPEND "${LUA_DIR}/" )
list( TRANSFORM SRC_LUAC PREPEND "${LUAC_DIR}/" )
list( TRANSFORM INSTALL_HEADERS PREPEND "${LUA_DIR}/" )


include_directories ( ${LUA_DIR} )

add_library ( libluadll SHARED ${SRC_LIB} ${SRC_CORE} ${SRC_AUX} )
target_compile_definitions ( libluadll PRIVATE LUA_BUILD_AS_DLL )
target_sources ( libluadll INTERFACE FILE_SET publicheaders TYPE HEADERS BASE_DIRS ${LUA_DIR} FILES ${INSTALL_HEADERS} )
set_target_properties ( libluadll PROPERTIES OUTPUT_NAME "lua${LUA_VERSION_MAJOR}${LUA_VERSION_MINOR}" )

add_executable ( lua ${SRC_LUA} )
target_link_libraries ( lua PRIVATE libluadll )

add_executable ( luac ${SRC_LUAC} ${SRC_CORE} ${SRC_AUX} )

install( TARGETS lua RUNTIME )
install( TARGETS luac RUNTIME )
install( TARGETS libluadll RUNTIME )
install( TARGETS libluadll FILE_SET publicheaders )
