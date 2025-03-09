Lua v5.3.5 build for Windows using CMake.

https://www.lua.org/source/5.3/luaconf.h.html

- https://www.lua.org/source/5.3/luaconf.h.html#LUA_COMPAT_5_2
    compatibility with Lua 5.2

    LUA_COMPAT_MATHLIB
      controls the presence of several deprecated functions
      in the mathematical library
    LUA_COMPAT_APIINTCASTS
      controls the presence of macros for manipulating 
      other integer types (lua_pushunsigned, lua_tounsigned,
      luaL_checkint, luaL_checklong, etc.)
    LUA_COMPAT_BITLIB
      controls the presence of library 'bit32'
    LUA_COMPAT_IPAIRS
      controls the effectiveness of the __ipairs metamethod
    LUA_COMPAT_LT_LE
      controls the emulation of the '__le' metamethod using '__lt'

- https://www.lua.org/source/5.3/luaconf.h.html#LUA_COMPAT_5_1
    compatibility with Lua 5.1

    LUA_COMPAT_MATHLIB
    LUA_COMPAT_APIINTCASTS
      Incompatibilities from 5.2 -> 5.3
    LUA_COMPAT_UNPACK
      controls the presence of global 'unpack'.
      You can replace it with 'table.unpack'.
    LUA_COMPAT_LOADERS
      controls the presence of table 'package.loaders'.
      You can replace it with 'package.searchers'.
    LUA_COMPAT_LOG10
      defines the function 'log10' in the math library.
      You can rewrite 'log10(x)' as 'log(x, 10)'.
    LUA_COMPAT_LOADSTRING
      defines the function 'loadstring' in the base library.
      You can rewrite 'loadstring(s)' as 'load(s)'.
    LUA_COMPAT_MAXN
      defines the function 'maxn' in the table library.
    LUA_COMPAT_MODULE
      controls compatibility with previous
      module functions 'module' (Lua) and 'luaL_register' (C).

- https://www.lua.org/source/5.3/luaconf.h.html#LUA_COMPAT_FLOATSTRING
    makes Lua format integral floats without a a float mark ('.0').
    This macro is not on by default even in compatibility mode,
    because this is not really an incompatibility.

- https://www.lua.org/source/5.3/luaconf.h.html#LUA_USE_WINDOWS
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
