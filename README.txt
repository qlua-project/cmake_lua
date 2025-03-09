Lua v5.4.1 build for Windows using CMake.

https://www.lua.org/source/5.4/luaconf.h.html

- https://www.lua.org/source/5.4/luaconf.h.html#LUA_COMPAT_5_3
    compatibility with Lua 5.3

    LUA_COMPAT_MATHLIB
      controls the presence of several deprecated functions
      in the mathematical library
      (These functions were already officially removed in 5.3;
      nevertheless they are still available here.)
    LUA_COMPAT_APIINTCASTS
      controls the presence of macros for manipulating 
      other integer types (lua_pushunsigned, lua_tounsigned,
      luaL_checkint, luaL_checklong, etc.)
      (These macros were also officially removed in 5.3, but they are still
      available here.)
    LUA_COMPAT_LT_LE
      controls the emulation of the '__le' metamethod using '__lt'.

- https://www.lua.org/source/5.4/luaconf.h.html#LUA_USE_WINDOWS
    #define LUA_DL_DLL      /* enable support for DLL */
    #define LUA_USE_C89     /* broadly, Windows is C89 */

    LUA_USE_C89
      controls the use of non-ISO-C89 features.
      Define it if you want Lua to avoid the use of a few C99 features
      or Windows-specific features on Windows.
    LUA_C89_NUMBERS
      ensures that Lua uses the largest types available for C89
      ('long' and 'double'); Windows always has '__int64', so it does
      not need to use this case.
