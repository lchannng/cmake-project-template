# Define where vcpkg will be cloned
set(VCPKG_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/vcpkg")

# Clone vcpkg if it doesn't exist
if(NOT EXISTS ${VCPKG_ROOT})
    message(STATUS "Cloning vcpkg...")
    execute_process(
        COMMAND git clone https://github.com/microsoft/vcpkg.git ${VCPKG_ROOT}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
endif()

# Bootstrap vcpkg if necessary
if(NOT EXISTS ${VCPKG_ROOT}/vcpkg)
    message(STATUS "Bootstrapping vcpkg...")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E chdir ${VCPKG_ROOT} ./bootstrap-vcpkg.sh
    )
endif()

# Set up CMake toolchain file
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
    CACHE STRING "Vcpkg toolchain file")
