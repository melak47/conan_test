# where conan should install generated outputs to
set(CONAN_INSTALL_FOLDER ${CMAKE_BINARY_DIR}/conan)

set(CONANFILE ${CMAKE_CURRENT_SOURCE_DIR}/conanfile.txt)
set(LAST_CONANFILE ${CONAN_INSTALL_FOLDER}/conanfile.txt)

list(APPEND CMAKE_MODULE_PATH ${CONAN_INSTALL_FOLDER}) # for find_package in module mode (cmake_find_package generator)
list(APPEND CMAKE_PREFIX_PATH ${CONAN_INSTALL_FOLDER}) # for find_package in config mode (cmake_find_package_multi generator, CMakeDeps generator)

set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES ${CONAN_INSTALL_FOLDER})

# nuke conan generated files, to be sure old stuff doesn't stick around
file(REMOVE_RECURSE ${CONAN_INSTALL_FOLDER})
file(MAKE_DIRECTORY ${CONAN_INSTALL_FOLDER})

# make cmake to reconfigure (which reruns 'conan install') if conanfile.txt changes
configure_file(${CONANFILE} ${LAST_CONANFILE} COPYONLY)

include(${CMAKE_CURRENT_LIST_DIR}/conan.cmake)
conan_cmake_autodetect(CONAN_SETTINGS)
conan_cmake_install(
    PATH_OR_REFERENCE ${CONANFILE}
    BUILD missing
    GENERATOR cmake_find_package
    INSTALL_FOLDER ${CONAN_INSTALL_FOLDER}
    SETTINGS ${CONAN_SETTINGS}
)

# suppress lots of noisy messages from find_package of conan deps
set(CONAN_CMAKE_SILENT_OUTPUT ON)
