if(MSVC)
    # Clear the default content of CMAKE_MSVC_RUNTIME_LIBRARY
    set(CMAKE_MSVC_RUNTIME_LIBRARY "")

	# Set the compiler options for the static multithreaded version.
	add_compile_options($<$<CONFIG:>:/MT> $<$<CONFIG:Debug>:/MTd> $<$<CONFIG:Release>:/MT>)

    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    # Force to always compile with W4
    if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
        string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    else()
        add_compile_options("/W4")
    endif()
else()
    # Update if necessary
    add_compile_options("-Wall" "-Wextra" "-Wno-long-long" "-pedantic")
endif()

if(WIN32)
    macro(get_WIN32_WINNT version)
        if (CMAKE_SYSTEM_VERSION)
            set(ver ${CMAKE_SYSTEM_VERSION})
            string(REGEX MATCH "^([0-9]+).([0-9])" ver ${ver})
            string(REGEX MATCH "^([0-9]+)" verMajor ${ver})
            # Check for Windows 10, b/c we'll need to convert to hex 'A'.
            if ("${verMajor}" MATCHES "10")
                set(verMajor "A")
                string(REGEX REPLACE "^([0-9]+)" ${verMajor} ver ${ver})
            endif ("${verMajor}" MATCHES "10")
            # Remove all remaining '.' characters.
            string(REPLACE "." "" ver ${ver})
            # Prepend each digit with a zero.
            string(REGEX REPLACE "([0-9A-Z])" "0\\1" ver ${ver})
            set(${version} "0x${ver}")
        endif(CMAKE_SYSTEM_VERSION)
    endmacro(get_WIN32_WINNT)
    get_WIN32_WINNT(ver)
    add_definitions(-D_WIN32_WINNT=${ver})
    add_definitions(-DNOMINMAX)
elseif(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()
