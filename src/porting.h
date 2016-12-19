/*
Minetest
Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 3.0 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

/*
	Random portability stuff
*/

#ifndef PORTING_HEADER
#define PORTING_HEADER

#ifdef _WIN32
	#ifdef _WIN32_WINNT
		#undef _WIN32_WINNT
	#endif
	#define _WIN32_WINNT 0x0501 // We need to do this before any other headers
		// because those might include sdkddkver.h which defines _WIN32_WINNT if not already set
#endif

#include <string>
#include <vector>
#include "irrlicht.h"
#include "irrlichttypes.h" // u32
#include "irrlichttypes_extrabloated.h"
#include "debug.h"
#include "constants.h"
#include "gettime.h"
#include "threads.h"

#ifdef _MSC_VER
	#define SWPRINTF_CHARSTRING L"%S"
#else
	#define SWPRINTF_CHARSTRING L"%s"
#endif

//currently not needed
//template<typename T> struct alignment_trick { char c; T member; };
//#define ALIGNOF(type) offsetof (alignment_trick<type>, member)

#ifdef _WIN32
	#include <windows.h>

	#define sleep_ms(x) Sleep(x)
#else
	#include <unistd.h>
	#include <stdint.h> //for uintptr_t

	#if (defined(linux) || defined(__linux) || defined(__GNU__)) && !defined(_GNU_SOURCE)
		#define _GNU_SOURCE
	#endif

	#define sleep_ms(x) usleep(x*1000)
#endif

#ifdef _MSC_VER
	#define ALIGNOF(x) __alignof(x)
	#define strtok_r(x, y, z) strtok_s(x, y, z)
	#define strtof(x, y) (float)strtod(x, y)
	#define strtoll(x, y, z) _strtoi64(x, y, z)
	#define strtoull(x, y, z) _strtoui64(x, y, z)
	#define strcasecmp(x, y) stricmp(x, y)
	#define strncasecmp(x, y, n) strnicmp(x, y, n)
#else
	#define ALIGNOF(x) __alignof__(x)
#endif

#ifdef __MINGW32__
	#define strtok_r(x, y, z) mystrtok_r(x, y, z)
#endif

// strlcpy is missing from glibc.  thanks a lot, drepper.
// strlcpy is also missing from AIX and HP-UX because they aim to be weird.
// We can't simply alias strlcpy to MSVC's strcpy_s, since strcpy_s by
// default raises an assertion error and aborts the program if the buffer is
// too small.
#if defined(__FreeBSD__) || defined(__NetBSD__)    || \
	defined(__OpenBSD__) || defined(__DragonFly__) || \
	defined(__APPLE__)   ||                           \
	defined(__sun)       || defined(sun)           || \
	defined(__QNX__)     || defined(__QNXNTO__)
	#define HAVE_STRLCPY
#endif

// So we need to define our own.
#ifndef HAVE_STRLCPY
	#define strlcpy(d, s, n) mystrlcpy(d, s, n)
#endif

#define PADDING(x, y) ((ALIGNOF(y) - ((uintptr_t)(x) & (ALIGNOF(y) - 1))) & (ALIGNOF(y) - 1))

#if defined(__APPLE__)
	#include <mach-o/dyld.h>
	#include <CoreFoundation/CoreFoundation.h>
#endif

#ifndef _WIN32 // Posix
	#include <sys/time.h>
	#include <time.h>
	#if defined(__MACH__) && defined(__APPLE__)
		#include <mach/clock.h>
		#include <mach/mach.h>
	#endif
#endif

namespace porting
{

/*
	Signal handler (grabs Ctrl-C on POSIX systems)
*/

void signal_handler_init(void);
// Returns a pointer to a bool.
// When the bool is true, program should quit.
bool * signal_handler_killstatus(void);

/*
	Path of static data directory.
*/
extern std::string path_share;

/*
	Directory for storing user data. Examples:
	Windows: "C:\Documents and Settings\user\Application Data\<PROJECT_NAME>"
	Linux: "~/.<PROJECT_NAME>"
	Mac: "~/Library/Application Support/<PROJECT_NAME>"
*/
extern std::string path_user;

/*
	Path to gettext locale files
*/
extern std::string path_locale;

/*
	Path to directory for storing caches.
*/
extern std::string path_cache;

/*
	Get full path of stuff in data directory.
	Example: "stone.png" -> "../data/stone.png"
*/
std::string getDataPath(const char *subpath);


/*
	Initialize path_*.
*/
void initializePaths();

/*
	Return system information
	e.g. "Linux/3.12.7 x86_64"
*/
std::string get_sysinfo();

void initIrrlicht(irr::IrrlichtDevice * );

/*
	Resolution is 10-20ms.
	Remember to check for overflows.
	Overflow can occur at any value higher than 10000000.
*/
#ifdef _WIN32 // Windows

	inline u32 getTimeS()
	{
		return GetTickCount() / 1000;
	}

	inline u32 getTimeMs()
	{
		return GetTickCount();
	}

	inline u32 getTimeUs()
	{
		LARGE_INTEGER freq, t;
		QueryPerformanceFrequency(&freq);
		QueryPerformanceCounter(&t);
		return (double)(t.QuadPart) / ((double)(freq.QuadPart) / 1000000.0);
	}

	inline u32 getTimeNs()
	{
		LARGE_INTEGER freq, t;
		QueryPerformanceFrequency(&freq);
		QueryPerformanceCounter(&t);
		return (double)(t.QuadPart) / ((double)(freq.QuadPart) / 1000000000.0);
	}

#else // Posix
	inline void _os_get_clock(struct timespec *ts)
	{
#if defined(__MACH__) && defined(__APPLE__)
	// from http://stackoverflow.com/questions/5167269/clock-gettime-alternative-in-mac-os-x
	// OS X does not have clock_gettime, use clock_get_time
		clock_serv_t cclock;
		mach_timespec_t mts;
		host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &cclock);
		clock_get_time(cclock, &mts);
		mach_port_deallocate(mach_task_self(), cclock);
		ts->tv_sec = mts.tv_sec;
		ts->tv_nsec = mts.tv_nsec;
#elif defined(CLOCK_MONOTONIC_RAW)
		clock_gettime(CLOCK_MONOTONIC_RAW, ts);
#elif defined(_POSIX_MONOTONIC_CLOCK)
		clock_gettime(CLOCK_MONOTONIC, ts);
#else
		struct timeval tv;
		gettimeofday(&tv, NULL);
		TIMEVAL_TO_TIMESPEC(&tv, ts);
#endif // defined(__MACH__) && defined(__APPLE__)
	}

	// Note: these clock functions do not return wall time, but
	// generally a clock that starts at 0 when the process starts.
	inline u32 getTimeS()
	{
		struct timespec ts;
		_os_get_clock(&ts);
		return ts.tv_sec;
	}

	inline u32 getTimeMs()
	{
		struct timespec ts;
		_os_get_clock(&ts);
		return ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
	}

	inline u32 getTimeUs()
	{
		struct timespec ts;
		_os_get_clock(&ts);
		return ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
	}

	inline u32 getTimeNs()
	{
		struct timespec ts;
		_os_get_clock(&ts);
		return ts.tv_sec * 1000000000 + ts.tv_nsec;
	}

	/*#include <sys/timeb.h>
	inline u32 getTimeMs()
	{
		struct timeb tb;
		ftime(&tb);
		return tb.time * 1000 + tb.millitm;
	}*/
#endif

inline u32 getTime(TimePrecision prec)
{
	switch (prec) {
		case PRECISION_SECONDS:
			return getTimeS();
		case PRECISION_MILLI:
			return getTimeMs();
		case PRECISION_MICRO:
			return getTimeUs();
		case PRECISION_NANO:
			return getTimeNs();
	}
	return 0;
}

/**
 * Delta calculation function taking two 32bit arguments.
 * @param old_time_ms old time for delta calculation (order is relevant!)
 * @param new_time_ms new time for delta calculation (order is relevant!)
 * @return positive 32bit delta value
 */
inline u32 getDeltaMs(u32 old_time_ms, u32 new_time_ms)
{
	if (new_time_ms >= old_time_ms) {
		return (new_time_ms - old_time_ms);
	} else {
		return (old_time_ms - new_time_ms);
	}
}


#ifndef SERVER
float getDisplayDensity();

v2u32 getDisplaySize();
v2u32 getWindowSize();

std::vector<core::vector3d<u32> > getSupportedVideoModes();
std::vector<irr::video::E_DRIVER_TYPE> getSupportedVideoDrivers();
const char *getVideoDriverName(irr::video::E_DRIVER_TYPE type);
const char *getVideoDriverFriendlyName(irr::video::E_DRIVER_TYPE type);
#endif

inline const char *getPlatformName()
{
	return
#if defined(ANDROID)
	"Android"
#elif defined(linux) || defined(__linux) || defined(__linux__)
	"Linux"
#elif defined(_WIN32) || defined(_WIN64)
	"Windows"
#elif defined(__DragonFly__) || defined(__FreeBSD__) || \
		defined(__NetBSD__) || defined(__OpenBSD__)
	"BSD"
#elif defined(__APPLE__) && defined(__MACH__)
	#if TARGET_OS_IPHONE
		"iOS"
	#elif TARGET_OS_MAC
		"OSX"
	#else
		"Apple"
	#endif
#elif defined(_AIX)
	"AIX"
#elif defined(__hpux)
	"HP-UX"
#elif defined(__sun) || defined(sun)
	#if defined(__SVR4)
		"Solaris"
	#else
		"SunOS"
	#endif
#elif defined(__CYGWIN__)
	"Cygwin"
#elif defined(__unix__) || defined(__unix)
	#if defined(_POSIX_VERSION)
		"Posix"
	#else
		"Unix"
	#endif
#else
	"?"
#endif
	;
}

void setXorgClassHint(const video::SExposedVideoData &video_data,
	const std::string &name);

// This only needs to be called at the start of execution, since all future
// threads in the process inherit this exception handler
void setWin32ExceptionHandler();

bool secure_rand_fill_buf(void *buf, size_t len);
} // namespace porting

#ifdef __ANDROID__
#include "porting_android.h"
#endif

#ifdef __IOS__
#include "porting_ios.h"
#endif

#endif // PORTING_HEADER
