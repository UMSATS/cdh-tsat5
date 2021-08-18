//
// Created by Matthew Kwiatkowski on 2021-03-13.
//
#include "gtest/gtest.h"
extern "C" {
// Get declaration for f(int i, char c, float x)
#include "../command_handler.h"
#include "../control_module.h"
}

TEST(HandlerControlIntegrationtest, TestHoldingStateChange){
    init_handler();
    controlModuleInit();
    uint8_t msg[] = {0xA0};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_EQ(getState(), Holding);
}

TEST(HandlerControlIntegrationtest, TestSPAMStateChange){
    init_handler();
    controlModuleInit();
    uint8_t msg[] = {0xA1};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_EQ(getState(), SPAMDeployment);
}

TEST(HandlerControlIntegrationtest, TestSelfieStateChange){
    init_handler();
    controlModuleInit();
    //first set state to holding
    uint8_t msg2[] = {0xA0};
    CANMessage_t testMessage2 = {0, 1, 8, msg2};
    handle_incoming(testMessage2);
    ASSERT_EQ(getState(), Holding);

    //selfie goes back to holding after is done
    uint8_t msg[] = {0xA2};//selfie message
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_EQ(getState(), Holding);
}

TEST(HandlerControlIntegrationtest, TestPayloadStateChange){
    init_handler();
    controlModuleInit();
    //first set state to holding
    uint8_t msg2[] = {0xA0};
    CANMessage_t testMessage2 = {0, 1, 8, msg2};
    handle_incoming(testMessage2);
    ASSERT_EQ(getState(), Holding);

    //goes back to holding after is done
    uint8_t msg[] = {0xA3};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_EQ(getState(), Holding);
}

TEST(HandlerControlIntegrationtest, TestLowPowerStateChange){
    init_handler();
    controlModuleInit();
    uint8_t msg[] = {0xA4};
    CANMessage_t testMessage = {0, 1, 8, msg};
    handle_incoming(testMessage);
    ASSERT_EQ(getState(), LowPowerMode);
}


