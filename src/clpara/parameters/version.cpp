﻿#include "version.h"
#include <version.h>
#if !defined(__MSDOS__) && !defined(__wasm__)
    #include "../../path/install_path.h"
#endif

#if __has_cpp_attribute(__gnu__::__cold__)
[[__gnu__::__cold__]]
#endif
::uwvm::cmdline::parameter_return_type(::uwvm::parameter::details::version_callback)(::std::size_t,
                                                                                     ::fast_io::vector<::uwvm::cmdline::parameter_parsing_results>&) noexcept
{
    ::fast_io::io::perr(::uwvm::u8err,
                        u8"\033[0m"
#ifdef __MSDOS__
                        u8"\033[35m"
#else
                        u8"\033[95m"
#endif
                        u8"Ultimate WebAssembly Virtual Machine\n"

    // Debug Mode
#ifdef _DEBUG
                        u8"\033[32m"
                        u8"(Debug Mode)\n"
#endif
                        u8"\033[0m"
                        // Copyright
                        u8"Copyright (C) 2024-present UltiELF Open Source Group"
    // Install Path
#if !defined(__MSDOS__) && !defined(__wasm__)
                        u8"\nInstall Path: ",
                        ::uwvm::path::module_install_path,
#endif
                        // Version
                        u8"\nVersion: "
                        u8"\033[32m",
                        ::uwvm::uwvm_version,
                        u8"\033[0m"
                        // Git
                        u8"\nFETCH_HEAD: ",
                        ::uwvm::git_fetch_head,
                        // Compiler
                        u8"\nCompiler: "
#ifdef __clang__
                        u8"LLVM clang " __clang_version__
#elif defined(__GNUC__) && defined(__VERSION__)
                        u8"GCC " __VERSION__
#elif defined(_MSC_VER)
                        u8"Microsoft Visual C++ ",
                        _MSC_VER,
#else
                        u8"Unknown C++ compiler"
#endif

                        // std Lib
                        u8"\nC++ STD Library: "
#if defined(_LIBCPP_VERSION)
                        u8"LLVM libc++ ",
                        _LIBCPP_VERSION,
#elif defined(__GLIBCXX__)
                        u8"GNU C++ Library ",
                        _GLIBCXX_RELEASE,
                        u8" ",
                        __GLIBCXX__,
#elif defined(_MSVC_STL_UPDATE)
                        u8"Microsoft Visual C++ STL ",
                        _MSVC_STL_UPDATE,
#else
                        u8"Unknown C++ standard library",
#endif

                        // architecture
                        u8"\nArchitecture: "
#if defined(__wasm__)
                        u8"WASM"
    #if defined(__wasm32__)
                        u8"32"
    #elif defined(__wasm64__)
                        u8"64"
    #endif
#elif defined(__alpha__)
                        u8"DEC Alpha"
#elif defined(__arm64__) || defined(__aarch64__) || defined(_M_ARM64)
                        u8"AArch64"
#elif defined(__arm__) || defined(_M_ARM)
                        u8"ARM"
#elif defined(__x86_64__) || defined(_M_AMD64)
                        u8"x86_64"
#elif defined(__i386__) || defined(_M_IX86)
                        u8"i386"
#elif defined(__BFIN__)
                        u8"Blackfin"
#elif defined(__convex__)
                        u8"Convex Computer"
#elif defined(__e2k__)
                        u8"E2K"
#elif defined(__IA64__) || defined(_M_IA64)
                        u8"Intel Itanium 64"
#elif defined(__loongarch64__)
                        u8"LoongArch64"
#elif defined(__loongarch__)
                        u8"LoongArch"
#elif defined(__m68k__)
                        u8"Motorola 68k"
#elif defined(__MIPS__)
                        u8"MIPS"
#elif defined(__HPPA__)
                        u8"HP/PA RISC"
#elif defined(__riscv)
    #if defined(__riscv_xlen) && __riscv_xlen == 64
                        u8"RISC-V 64"
    #else
                        u8"RISC-V"
    #endif
#elif defined(__370__) || defined(__THW_370__)
                        u8"System/370"
#elif defined(__s390__) || defined(__s390x__)
                        u8"System/390"
#elif defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__)
                        u8"PowerPC64"
#elif defined(__THW_RS6000) || defined(_IBMR2) || defined(_POWER) || defined(_ARCH_PWR) || defined(_ARCH_PWR2)
                        u8"RS/6000"
#elif defined(__CUDA_ARCH__)
                        u8"PTX"
#elif defined(__sparc__)
                        u8"SPARC"
#elif defined(__sh__)
                        u8"SuperH"
#elif defined(__SYSC_ZARCH__)
                        u8"z/Architecture"
#else
                        u8"Unknown Arch"
#endif

    // ARM PROFILE
#if defined(__ARM_ARCH_PROFILE)
    #if __ARM_ARCH_PROFILE == 'A'
                        u8" (Cortex-A)"
    #elif __ARM_ARCH_PROFILE == 'R'
                        u8" (Cortex-R)"
    #else
                        u8" (Cortex-M)"
    #endif
#endif

    // Native
#ifdef UWVM_NATIVE
                        u8"\033[33m"
                        u8" (Native Instructions Mode)"
                        u8"\033[0m"
#endif
    // SIMD
#if defined(__wasm_simd128__)
                        u8"\nSIMD support: WebAssembly SIMD"
#elif defined(__loongarch__) && defined(__loongarch_sx)
                        u8"\nSIMD support: LoongSX "
    #if defined(__loongarch_asx)
                        u8"LoongASX "
    #endif
#elif defined(__ARM_NEON) || ((defined(_MSC_VER) && !defined(__clang__)) && defined(_M_ARM64) && !defined(_KERNEL_MODE))
                        /*
                         * https://arm-software.github.io/acle/main/acle.html
                         */
                        u8"\nSIMD support: NEON "
    #if defined(__ARM_FEATURE_SVE)
                        u8"SVE "
    #endif
    #if defined(__ARM_FEATURE_SVE2)
                        u8"SVE2 "
    #endif
#elif(defined(__x86_64__) || defined(_M_AMD64) || defined(__i386__) || defined(_M_IX86)) && defined(__MMX__)
                        u8"\nSIMD support: "
    #if defined(__MMX__)
                        u8"MMX "
    #endif
    #if defined(__SSE__)
                        u8"SSE "
    #endif
    #if defined(__SSE2__)
                        u8"SSE2 "
    #endif
    #if defined(__SSE3__)
                        u8"SSE3 "
    #endif
    #if defined(__SSSE3__)
                        u8"SSSE3 "
    #endif
    #if defined(__SSE4_1__)
                        u8"SSE4.1 "
    #endif
    #if defined(__SSE4_2__)
                        u8"SSE4.2 "
    #endif
    #if defined(__FMA__)
                        u8"FMA "
    #endif
    #if defined(__AVX__)
                        u8"AVX "
    #endif
    #if defined(__AVX2__)
                        u8"AVX2 "
    #endif
    #if defined(__MIC__)
                        u8"MIC "
    #endif
    #if defined(__AVX512F__)
                        u8"AVX512F "
    #endif
    #if defined(__AVX512BW__)
                        u8"AVX512BW "
    #endif
    #if defined(__AVX512VL__)
                        u8"AVX512VL "
    #endif
    #if defined(__AVX512DQ__)
                        u8"AVX512DQ "
    #endif
    #if 0
        #if defined(__AVX512BF16__)
                          u8"AVX512BF16 "
        #endif
        #if defined(__AVX512FP16__)
                          u8"AVX512FP16 "
        #endif
    #endif
    #if defined(__AVX512VBMI__)
                        u8"AVX512VBMI "
    #endif
#elif defined(__VECTOR4DOUBLE__) || defined(__VSX__) || (defined(__ALTIVEC__) || defined(__VEC__))
                        u8"\nSIMD support: PPC SIMD"
#endif

                        // OS
                        u8"\nOS: "
#if defined(__CYGWIN__)
                        u8"Cygwin"
#elif defined(_WIN32) || defined(_WIN64) || defined(__WIN32__) || defined(__TOS_WIN__) || defined(__WINDOWS__) || defined(_WIN32_WINNT) ||                     \
    defined(_WIN32_WINDOWS)
                        u8"Microsoft Windows"
    #if defined(_WIN32_WINDOWS)
                        u8", minimum system support: "
        #if _WIN32_WINDOWS >= 0x0490
                        u8"Windows ME"
        #elif _WIN32_WINDOWS >= 0x0410
                        u8"Windows 98"
        #elif _WIN32_WINDOWS >= 0x0400
                        u8"Windows 95"
        #endif
    #elif defined(_WIN32_WINNT)
                        u8", minimum system support: "
        #if _WIN32_WINNT >= 0x0A00
                        u8"Windows 10"
        #elif _WIN32_WINNT >= 0x0603
                        u8"Windows 8.1"
        #elif _WIN32_WINNT >= 0x0602
                        u8"Windows 8"
        #elif _WIN32_WINNT >= 0x0601
                        u8"Windows 7"
        #elif _WIN32_WINNT >= 0x0600
                        u8"Windows Server 2008, Windows Vista"
        #elif _WIN32_WINNT >= 0x0502
                        u8"Windows Server 2003 with SP1, Windows XP with SP2"
        #elif _WIN32_WINNT >= 0x0501
                        u8"Windows Server 2003, Windows XP"
        #endif
    #endif
#elif defined(__MSDOS__)
                        u8"Microsoft Dos"

#elif defined(__linux) || defined(__linux__) || defined(__gnu_linux__)
                        u8"Linux"
#elif defined(__APPLE__) && defined(__MACH__)
    #if defined(__ENVIRONMENT_IPHONE_OS_VERSION_MIN_REQUIRED__)
                        u8"iOS"
    #else
                        u8"Mac OS"
    #endif
#elif defined(__DragonFly__)
                        u8"DragonFlyBSD"
#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
                        u8"FreeBSD"
#elif defined(__NetBSD__)
                        u8"NetBSD"
#elif defined(__OpenBSD__)
                        u8"OpenBSD"
#elif defined(BSD) || defined(_SYSTYPE_BSD)
                        u8"BSD"
#elif defined(__VMS)
                        u8"VMS"
#elif defined(__sun)
                        u8"Solaris"
#elif defined(__QNX__) || defined(__QNXNTO__)
                        u8"QNX"
#elif defined(__BEOS__)
                        u8"BeOS"
#elif defined(AMIGA) || defined(__amigaos__)
                        u8"AmigaOS"
#elif defined(_AIX) || defined(__TOS_AIX__)
                        u8"IBM AIX"
#elif defined(__OS400__)
                        u8"IBM OS/400"
#elif defined(__sgi)
                        u8"IRIX"
#elif defined(__hpux)
                        u8"HP-UX"
#elif defined(__HAIKU__)
                        u8"Haiku"
#elif defined(__unix) || defined(_XOPEN_SOURCE) || defined(_POSIX_SOURCE)
                        u8"Unix Environment"
#else
                        u8"Unknown OS"
#endif
                        // C Library
                        u8"\nC Library: "
#if defined(__wasi__)
                        u8"WASI"
#elif defined(__MINGW32__) && !defined(_UCRT) && !defined(__BIONIC__)
                        u8"MSVCRT"
#elif(defined(_MSC_VER) || defined(_UCRT)) && !defined(__WINE__) && !defined(__CYGWIN__) && !defined(__BIONIC__)
                        u8"UCRT"
#elif defined(__APPLE__) || defined(__DARWIN_C_LEVEL)
                        u8"Darwin"
#elif defined(__GLIBC__)
                        u8"GNU LIBC ",
                        __GLIBC__,
                        u8".",
                        __GLIBC_MINOR__,
#elif defined(__BIONIC__)
                        u8"Bionic"
#elif defined(__cloudlibc__)
                        u8"cloudlibc"
#elif defined(__UCLIBC__)
                        u8"uClibc"
#elif defined(__CRTL_VER)
                        u8"VMS"
#elif defined(__LIBREL__)
                        u8"z/OS"
#elif defined(__AVR__) || defined(_PICOLIBC__)
                        u8"AVR"
#elif defined(__LLVM_LIBC_TYPES_FILE_H__)
                        u8"LLVM LIBC "
#elif defined(__MLIBC_O_CLOEXEC)
                        u8"MLIBC"
#elif defined(__wasi__)
                        u8"WASI"
#elif defined(__NEED___isoc_va_list) || defined(__musl__)
                        u8"MUSL"
#elif defined(__serenity__)
                        u8"serenity"
#elif defined(__DJGPP__)
                        u8"djgpp"
#elif defined(__BSD_VISIBLE) || (defined(__NEWLIB__) && !defined(__CUSTOM_FILE_IO__)) || defined(__MSDOS__)
                        u8"unix"
#else
                        u8"Unknown"
#endif
                        u8"\nAllocator: "
#if defined(FAST_IO_USE_CUSTOM_GLOBAL_ALLOCATOR)
                        u8"custom global"
#elif defined(FAST_IO_USE_MIMALLOC)
                        u8"mimalloc"
#elif(defined(__linux__) && defined(__KERNEL__)) || defined(FAST_IO_USE_LINUX_KERNEL_ALLOCATOR)
                        u8"linux kmalloc"
#elif((__STDC_HOSTED__ == 1 && (!defined(_GLIBCXX_HOSTED) || _GLIBCXX_HOSTED == 1) && !defined(_LIBCPP_FREESTANDING)) ||                                       \
      defined(FAST_IO_ENABLE_HOSTED_FEATURES))
    #if defined(_WIN32) && !defined(__CYGWIN__) && !defined(__WINE__) && !defined(FAST_IO_USE_C_MALLOC)
        #if defined(_DEBUG) && defined(_MSC_VER)
                        u8"wincrt malloc dbg"
        #else
            #if defined(_WIN32_WINDOWS)
                        u8"win32 heapalloc"
            #else
                        u8"nt rtlallocateheap"
            #endif
        #endif
    #else
        #if defined(_DEBUG) && defined(_MSC_VER)
                        u8"wincrt malloc dbg"
        #else
                        u8"c malloc"
        #endif
    #endif
#else
                        u8"custom global"
#endif
                        u8"\n\n"  // endl
    );

    return ::uwvm::cmdline::parameter_return_type::return_imme;
}
