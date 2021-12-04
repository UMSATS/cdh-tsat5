//
// Created by Matthew Kwiatkowski on 2021-02-27.
//
#include "gtest/gtest.h"
extern "C" {
// Get declaration for f(int i, char c, float x)
    #include "../command_handler.h"
}

bool hey = false;
int count = 0;

void handle_inc(CANMessage_t in){
     hey = true;
     count++;
}

TEST(CommandHandlerTest, TestBasic){
    hey = false;
    init_handler();
    add_handler(0x01, handle_inc);
    uint8_t msg[] = {0x01};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_TRUE(hey);
}

TEST(CommandHandlerTest, TestOnlySingleHandlerCalled){
    hey = false;
    init_handler();
    add_handler(0x02, handle_inc);
    uint8_t msg[] = {0x01};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_FALSE(hey);
}

TEST(CommandHandlerTest, TestMultiMessageReceived){
    count = 0;
    init_handler();
    add_handler(0x01, handle_inc);
    uint8_t msg[] = {0x01};
    CANMessage_t testMessage = {0, 1, 8, msg};
    int checks = 10;
    for(int i = 0; i < checks; i++){
        handle_incoming(testMessage);
    }
    ASSERT_EQ(checks, count);
}

TEST(CommandHandlerTest, TestMaxOpcode){
    hey = false;
    init_handler();
    add_handler(0xFF, handle_inc);
    uint8_t msg[] = {0xFF};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_TRUE(hey);
}





