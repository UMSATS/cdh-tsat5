cmake_minimum_required(VERSION 3.15)
project(CommandHandler C)

set(CMAKE_C_STANDARD 99)


add_executable(CommandHandler main.c llist.h llist.c command_handler.h command_sender.h command_handler.c command_sender.c dummytask.h dummytask.c control_module.c)