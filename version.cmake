# set ( LUA_INCLUDE_DIR ${LUA_DIR} )  # lua.h location
# find_package( Lua QUIET )  # LUA_VERSION_MAJOR LUA_VERSION_MINOR

function(lua_get_header_version src)
  file(STRINGS "${src}/lua.h" lua_version_strings REGEX "LUA_VERSION[_A-Z]+[ \t]+\"?[0-9]")
  foreach(item IN LISTS lua_version_strings)
    message(STATUS ${item})
    if (${item} MATCHES "LUA_VERSION_MAJOR[_A-Z]*[ \t]+\"?([0-9])")
      set(LUA_VERSION_MAJOR ${CMAKE_MATCH_1} PARENT_SCOPE)
    endif()
    if (${item} MATCHES "LUA_VERSION_MINOR[_A-Z]*[ \t]+\"?([0-9])")
      set(LUA_VERSION_MINOR ${CMAKE_MATCH_1} PARENT_SCOPE)
    endif()
  endforeach()
endfunction()
