/*
	If CMake is used, includes the cmake-generated cmake_config.h.
	Otherwise use default values
*/

#ifndef CONFIG_H
#define CONFIG_H

#define STRINGIFY(x) #x
#define STR(x) STRINGIFY(x)


#if defined USE_CMAKE_CONFIG_H
	#include "cmake_config.h"
#elif defined (__ANDROID__)
	#define PROJECT_NAME "FreeCraft"
	#define PROJECT_NAME_C "FreeCraft"
	#define STATIC_SHAREDIR ""
	#include "android_version.h"
	#ifdef NDEBUG
		#define BUILD_TYPE "Release"
	#else
		#define BUILD_TYPE "Debug"
	#endif
#elif defined (__IOS__)
    #define PROJECT_NAME "FreeCraft"
    #define PROJECT_NAME_C "FreeCraft"
    #define STATIC_SHAREDIR ""
    #define VERSION_MAJOR 1
    #define VERSION_MINOR 1
    #define VERSION_PATCH 4
    #define VERSION_STRING "1.1.4"
    #ifdef NDEBUG
        #define BUILD_TYPE "Release"
    #else
        #define BUILD_TYPE "Debug"
    #endif
#else
	#ifdef NDEBUG
		#define BUILD_TYPE "Release"
	#else
		#define BUILD_TYPE "Debug"
	#endif
#endif

#define BUILD_INFO "BUILD_TYPE=" BUILD_TYPE \
		" RUN_IN_PLACE=" STR(RUN_IN_PLACE) \
		" USE_GETTEXT=" STR(USE_GETTEXT) \
		" USE_SOUND=" STR(USE_SOUND) \
		" USE_CURL=" STR(USE_CURL) \
		" USE_FREETYPE=" STR(USE_FREETYPE) \
		" USE_LUAJIT=" STR(USE_LUAJIT) \
		" STATIC_SHAREDIR=" STR(STATIC_SHAREDIR)

#endif
