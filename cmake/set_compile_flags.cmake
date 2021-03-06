# Logic for handling warnings
if(AMR_WIND_ENABLE_ALL_WARNINGS)
  # GCC, Clang, and Intel seem to accept these
  list(APPEND AMR_WIND_CXX_FLAGS "-Wall" "-Wextra" "-pedantic")
  if(NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    # ifort doesn't like -Wall
    list(APPEND AMR_WIND_Fortran_FLAGS "-Wall")
  else()
    # Intel always reports some diagnostics we don't necessarily care about
    list(APPEND AMR_WIND_CXX_FLAGS "-diag-disable:11074,11076,15335")
  endif()
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 7.0)
    # Avoid notes about -faligned-new with GCC > 7
    list(APPEND AMR_WIND_CXX_FLAGS "-faligned-new")
  endif()
endif()

# Add our extra flags according to language
separate_arguments(AMR_WIND_CXX_FLAGS)
target_compile_options(
  ${amr_wind_lib_name} PRIVATE
  $<$<COMPILE_LANGUAGE:CXX>:${AMR_WIND_CXX_FLAGS}>)
if (AMR_WIND_ENABLE_FORTRAN)
  separate_arguments(AMR_WIND_Fortran_FLAGS)
  target_compile_options(
    ${amr_wind_lib_name} PRIVATE
    $<$<COMPILE_LANGUAGE:Fortran>:${AMR_WIND_Fortran_FLAGS}>)
endif()

# Building on CUDA requires additional considerations
if (AMR_WIND_ENABLE_CUDA)
  set_target_properties(
    ${amr_wind_lib_name} PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON)
endif()

# Disable loop not vectorized warnings on Clang. This generates a lot of
# diagnostic messages when compiling AMReX that we can't do anything about
# within amr-wind
if (${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang" OR
    ${CMAKE_CXX_COMPILER_ID} STREQUAL "AppleClang")
  if (${AMR_WIND_USE_INTERNAL_AMREX})
    target_compile_options(
      amrex PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-pass-failed>)
  else()
    target_compile_options(
      ${amr_wind_lib_name} PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-pass-failed>)
  endif()
endif()
