<div style="text-align:center">
    <img src="documents/images/logo_256x256.png" , alt="logo" />
    <h1>Ultimate WebAssembly Virtual Machine</h1>
    <a href="LICENSE.md">
        <img src="https://img.shields.io/badge/License-Apache%202.0-green.svg" , alt="License" />
    </a>
    <a href="https://zh.cppreference.com">
        <img src="https://img.shields.io/badge/language-c++23-blue.svg" ,alt="cppreference" />
    </a>
    <a
        href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=XZB6BqBhkGX9RI8lNIvPRQpqjIHYDCpZ&authKey=OPmC%2FnGNXThLAV7IKmEQ57uiQCTfb8EraImxCWzVgq9%2FmdgxGU6rA3wZB%2BbCVxjq&noverify=0&group_code=284938376">
        <img src="https://img.shields.io/badge/chat-on%20QQ-red.svg" , alt="QQ" />
    </a>
</div>

[[English]](README.md)

## 联系我们

- QQ: [284938376](http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=XZB6BqBhkGX9RI8lNIvPRQpqjIHYDCpZ&authKey=OPmC%2FnGNXThLAV7IKmEQ57uiQCTfb8EraImxCWzVgq9%2FmdgxGU6rA3wZB%2BbCVxjq&noverify=0&group_code=284938376)
- repositories: [Gitee](https://gitee.com/UltiELF/ulti-wvm), [GitHub](https://github.com/UltiELF/ulti-wvm)

## 介绍

Ultimate WebAssembly 虚拟机

## 如何构建
1. 安装 [[xmake]](https://github.com/xmake-io/xmake/)
2. 安装 [[gcc14+]](https://github.com/trcrsired/gcc-releases/releases) or [[llvm18+]](https://github.com/trcrsired/llvm-releases/releases)
3. 开始构建
```bash
On Windows:

> xmake f -p mingw
> xmake 
> xmake install -o OutputPath 
```
```bash
On Other Platforms:

$ xmake 
$ xmake install -o OutputPath 
```
4. 构建参数
```bash
$ xmake f -m [release|releasedbg|debug] -p [mingw|macosx|linux|iphoneos ..] -a [x86_64|i386|aarch|aarch64|loongarch64 ..] --cppstdlib=[default|libstdc++|libc++] ..
```
* 目前只支持 gcc 14+ 和 llvm 18+，暂不支持 msvc，所以windows上本地编译请将平台设置成 mingw(unknown-windows-gnu)，而不是默认的 windows(unknown-windows-msvc)
* 目前windows上只支持 Windows NT 3.1+ 的系统，不支持Windows 9x (未来可能会支持)。若要编译兼容win10 (默认) 以下系统，请添加参数
```bash 
--min-win32-sys=[WIN10|WINBLUE|WIN8|WIN7|WS08|VISTA|WS03|WINXP]
```
* 对于WIN9X (暂不支持)
```bash
--min-win32-sys=[WINME|WIN98|WIN95]
```
* 若要使用llvm编译器，请添加参数
```bash 
--use-llvm=y
```
* 若要进行交叉编译，请关闭编译本地指令集
```bash 
--native=n
```
* 选择工具链
```bash 
--sdk=ToolchainPath
```