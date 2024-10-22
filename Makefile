# Makefile for building project with CMake presets and vcpkg

# Default build type
BUILD_TYPE ?= debug

# Platform options
PLATFORM ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')

ifeq ($(PLATFORM),linux)
	CONFIGURE_PRESET = linux-x64-static-$(BUILD_TYPE)
	BUILD_PRESET = linux-x64-static-$(BUILD_TYPE)
else ifeq ($(PLATFORM),darwin)
	CONFIGURE_PRESET = linux-x64-static-$(BUILD_TYPE) # Adjust for macOS if needed
	BUILD_PRESET = linux-x64-static-$(BUILD_TYPE)
else
	CONFIGURE_PRESET = windows-x64-static-$(BUILD_TYPE)
	BUILD_PRESET = windows-x64-static-$(BUILD_TYPE)
endif

# Default target
all: build

# Configure the project
configure:
	cmake --preset=$(CONFIGURE_PRESET)

# Build the project
build: configure
	cmake --build --preset=$(BUILD_PRESET) --parallel

# Clean the build directory
clean:
	rm -rf build/

.PHONY: all configure build clean
