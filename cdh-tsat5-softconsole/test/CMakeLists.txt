# 'Google_test' is the subproject name
project(Google_tests)

# 'lib' is the folder with Google Test sources
add_subdirectory(gtest)
include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

# 'Google_Tests_run' is the target name
# 'test1.cpp tests2.cpp' are source files with tests
add_executable(Google_Tests_run
        CommandHandlerTest.cpp CommandSenderTest.cpp LinkedListTest.cpp HandlerControlIntegrationTest.cpp
        ../command_handler.h ../command_handler.c ../command_sender.h ../command_sender.c
        ../llist.h ../llist.c ../dummytask.h ../dummytask.c ../control_module.h ../control_module.c)
target_link_libraries(Google_Tests_run gtest gtest_main)