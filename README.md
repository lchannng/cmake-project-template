# CMake Project Template

This is a basic CMake project template using `vcpkg` for dependency management and `CMakePresets.json` for streamlined build configurations.

## Prerequisites

- [CMake](https://cmake.org/download/) 3.21 or later
- [vcpkg](https://github.com/microsoft/vcpkg) for managing dependencies
- A compatible C++ compiler (e.g., GCC, Clang, MSVC)


    
## Setting Up the Project

Clone the vcpkg repository and integrate it with your project:

```bash
git clone https://github.com/microsoft/vcpkg.git
./vcpkg/bootstrap-vcpkg.sh  # Use .bat for Windows
```

