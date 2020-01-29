cmake_minimum_required(VERSION 3.0)
project(text2soled)

set(LIBS
  glibmm-2.4
  giomm-2.4
  glib-2.0
  gio-2.0
  gio-unix-2.0
  freetype2
  )

OPTION(DEV_PC
  "Do not expect a frame buffer device, maybe do some tests."
  OFF)

IF(DEV_PC)
  ADD_DEFINITIONS(-D_DEVELOPMENT_PC)
ENDIF(DEV_PC)

function(addLib name)
  pkg_check_modules(${name} REQUIRED ${name})
  include_directories(${${name}_INCLUDE_DIRS}) 
  link_directories(${${name}_LIBRARY_DIRS})
endfunction(addLib)

find_package(PkgConfig REQUIRED)
find_package(Threads REQUIRED)
find_package(Freetype REQUIRED)

foreach(lib ${LIBS})
  addLib(${lib})
endforeach(lib)

include_directories(src)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -Wdouble-promotion")
  
file(GLOB_RECURSE SOURCE_FILES
  src/*.cpp) 

add_executable(text2soled ${SOURCE_FILES})

TARGET_LINK_LIBRARIES(text2soled pthread)

function(linkLib name)
  pkg_check_modules(${name} REQUIRED ${name})
  target_link_libraries(text2soled ${${name}_LIBRARIES})
endfunction(linkLib)

foreach(lib ${LIBS})
  linkLib(${lib})
endforeach(lib)

file(GLOB RESOURCES resources/*)

install(FILES ${RESOURCES}
  DESTINATION resources
  )

install(TARGETS text2soled
  DESTINATION ./
  )

