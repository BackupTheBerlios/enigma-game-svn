# Process this file with autoconf to produce a configure script.
AC_INIT([enigma],[0.92])
AC_CANONICAL_BUILD
AC_CANONICAL_TARGET
AC_CONFIG_SRCDIR([src/enigma.cc])

AM_INIT_AUTOMAKE(AC_PACKAGE_TARNAME, AC_PACKAGE_VERSION, -)
AC_CONFIG_HEADERS([src/config.h])

ALL_LINGUAS="de fr nl it es"
AC_SUBST(ALL_LINGUAS)
AM_GNU_GETTEXT

case $host_os in
  *mingw32* ) MINGW32=yes;;
          * ) MINGW32=no;;
esac

case $host_os in
  *cygwin* ) CYGWIN=yes;;
         * ) CYGWIN=no;;
esac
AM_CONDITIONAL(MINGW32, test x$MINGW32 = xyes)


dnl ======================================================================
dnl Check for programs
dnl ======================================================================
AC_PROG_CC
AC_PROG_CXX
AC_PROG_CPP
AC_PROG_RANLIB

dnl Add -mno-cygwin to CXXFLAGS and CFLAGS if working under cygwin
if test "x$CYGWIN" = xyes; then
  CXXFLAGS="$CXXFLAGS -mno-cygwin"
  CFLAGS="$CFLAGS -mno-cygwin"
  CPPFLAGS="$CXXFLAGS -mno-cygwin"
  WINDRES="${WINDRES-windres}"
fi
AC_SUBST(WINDRES)

dnl ---------- Texi2html ----------
AC_PATH_PROG(TEXI2HTML, texi2html, "")

dnl ---------- Use the included tolua ----------
AC_SUBST([TOLUA])
TOLUA=["\$(top_builddir)/tools/tolua"]
dnl AC_PATH_PROG(TOLUA, tolua, "", ["\$(top_builddir)/tools/tolua"])

dnl ======================================================================
dnl Check for libraries
dnl ======================================================================
AM_PATH_SDL(1.2.0)
AC_SUBST(SDL_LIBS)
AC_SUBST(SDL_CFLAGS)

dnl The flags are now substituted inside the Makefile, but not used for the
dnl rest of the script. So we manually put them in. This is necessary if
dnl SDL has not been installed in the canonical locations.
CFLAGS="$CFLAGS $SDL_CFLAGS"
CXXFLAGS="$CXXFLAGS $SDL_CFLAGS"
LIBS="$LIBS $SDL_LIBS"

dnl When using the included gettext package from the /intl subdir
dnl /intl needs to be added to the list of include folders
if test "$BUILD_INCLUDED_LIBINTL" = yes; then
   CXXFLAGS="$CXXFLAGS -I\$(top_srcdir)/intl"
fi

dnl ----------------------------------------
dnl Check for SDL image library
dnl Check for SDL mixer library
dnl ----------------------------------------
AC_CHECK_LIB(SDL_image,main,,[AC_MSG_ERROR([SDL_image is required to compile Enigma])])
AC_CHECK_LIB(SDL_mixer,main,,[AC_MSG_ERROR([SDL_mixer is required to compile Enigma])])

SDL_LIBS="$SDL_LIBS -lSDL_image -lSDL_mixer"

AC_CHECK_LIB(SDL_mixer, Mix_QuickLoad_RAW, have_mix_quickload="yes", have_mix_quickload="no")

if test "$have_mix_quickload" = no; then
   AC_MSG_ERROR([SDL_mixer >= 1.5 is required to compile Enigma])
fi

dnl ----------------------------------------
dnl Check for SDL_ttf library
dnl ---------------------------------------
AC_CHECK_LIB(SDL_ttf,main,have_sdlttf="yes", have_sdlttf="no")
AM_CONDITIONAL(HAVESDLTTF, [test "$have_sdlttf" = yes])
if test "x$have_sdlttf" = xyes; then
  AC_DEFINE(HAVE_SDLTTF, , [Whether SDL_ttf library was found during configure])
  LIBS="$LIBS -lSDL_ttf"
else
  AC_MSG_ERROR([SDL_ttf is required to compile Enigma])
fi

dnl ----------------------------------------
dnl Check for libpng
dnl ---------------------------------------
AC_CHECK_LIB(png,png_create_write_struct,,[AC_MSG_ERROR([libpng is required to compile Enigma])])

dnl
dnl Activate optimizations when profiling, to get rid of
dnl inlineable functions.
dnl
AC_MSG_CHECKING(whether to include profiling information)
AC_ARG_ENABLE(profile,
  AS_HELP_STRING(--enable-profile,Compile with profiling information), ,
  enable_profile=no
)
if test "x$enable_profile" = xyes; then
  CXXFLAGS="$CXXFLAGS -pg -O2"
  AC_MSG_RESULT(yes)
else
  AC_MSG_RESULT(no)
fi

dnl ----------------------------------------
dnl Build the developer tools?
dnl ----------------------------------------

AC_ARG_ENABLE(tools,
  AS_HELP_STRING(--enable-tools,Build developer tools [default=no]), ,
  enable_tools=no
)

AM_CONDITIONAL(BUILDTOOLS, [test "$enable_tools" = yes])
AM_CONDITIONAL(BUILDTTF2BMF, [test "$have_sdlttf" = yes -a "$enable_tools" = yes])

dnl ----------------------------------------
dnl Include experimental features?
dnl ----------------------------------------
AC_ARG_ENABLE(experimental,
  AS_HELP_STRING(--enable-experimental,Include experimental features [default=no]), 
  , enable_experimental=no)
if test "x$enable_experimental" = xyes; then
  AC_DEFINE(ENABLE_EXPERIMENTAL, , [Include experimental features])
fi

dnl ----------------------------------------
dnl Optimize?
dnl ----------------------------------------

AC_ARG_ENABLE(optimize,
  AS_HELP_STRING(--enable-optimize,Compile with optimizations [default=no]), ,
  enable_optimize=no
)
if test "x$enable_optimize" = xyes; then
	CXXFLAGS="$CXXFLAGS -O2 -ffast-math -fomit-frame-pointer"
	AC_MSG_RESULT(yes)
else
	CXXFLAGS="$CXXFLAGS -g"
	AC_MSG_RESULT(no)
fi

dnl ----------------------------------------
dnl Check for gdb debugging
dnl ----------------------------------------

AC_MSG_CHECKING(whether to debug the game with gdb)
AC_ARG_ENABLE(debug-gdb,
  AS_HELP_STRING(--enable-debug-gdb,Compile with special debugging options for gdb), ,
  enable_debug_gdb=no
)
if test "x$enable_debug_gdb" = xyes; then
	CXXFLAGS="$CXXFLAGS -ggdb3 -fno-inline -fno-default-inline -fno-omit-frame-pointer -fno-optimize-sibling-calls"
	AC_MSG_RESULT(yes)
else
	CXXFLAGS="$CXXFLAGS"
	AC_MSG_RESULT(no)
fi

dnl ----------------------------------------------------------
dnl Check whether compiler warnings should be emitted
dnl ----------------------------------------------------------

AC_MSG_CHECKING(whether to enable warnings)
AC_ARG_ENABLE(warnings,
  AS_HELP_STRING(--enable-warnings,Enable additional compiler warnings), ,
  enable_warnings=no
)
if test "x$enable_warnings" = xyes; then
	CXXFLAGS="$CXXFLAGS -O2 -Wall -W"
	CXXFLAGS="$CXXFLAGS -Wundef -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align"
	CXXFLAGS="$CXXFLAGS -Wwrite-strings -Wconversion -Wsign-compare -Wformat"
	CXXFLAGS="$CXXFLAGS -Wdisabled-optimization -Wno-system-headers"
	AC_MSG_RESULT(yes)
else
	CXXFLAGS="$CXXFLAGS"
	AC_MSG_RESULT(no)
fi

dnl Setup default search path for game data
FC_EXPAND_DIR(ENIGMA_DATADIR, "$datadir/enigma")
AC_DEFINE_UNQUOTED(DEFAULT_DATA_PATH, "./data:~/.enigma:$ENIGMA_DATADIR", [Default data directory])

dnl Configure libraries
AC_CONFIG_SUBDIRS(lib-src/zipios++)
dnl AC_CONFIG_SUBDIRS(lib-src/enet)

AC_CONFIG_FILES([Makefile m4/Makefile  intl/Makefile 
           data/Makefile
           data/gfx/Makefile
           data/gfx32/Makefile
           data/gfx40/Makefile
           data/gfx48/Makefile
           data/levels/Makefile
           data/levels/Sokoban/Makefile
           data/levels/m_tutor/Makefile
           data/levels/patches/Makefile
           data/fonts/Makefile
           data/sound/Makefile
	   doc/Makefile
	   doc/manual/Makefile
	   doc/manual/images/Makefile
           doc/refman/Makefile
	   etc/Makefile
           lib-src/Makefile
	   lib-src/oxydlib/Makefile
	   lib-src/lua/Makefile
	   src/Makefile
           src/px/Makefile
	   tools/Makefile
	   etc/enigma.spec
	   etc/mingw32-dist.sh
	   etc/enigma.nsi
	   po/Makefile.in
])
AC_OUTPUT

AC_MSG_RESULT([

Enigma is now configured

   Source directory:    $srcdir
   Installation prefix: $prefix
   C++ compiler:        $CXX $CXXFLAGS
   Libraries:           $LIBS
   Linker options:      $LDFLAGS
   Languages:		$ALL_LINGUAS

If these values seem to make sense, you can now run make.
])

