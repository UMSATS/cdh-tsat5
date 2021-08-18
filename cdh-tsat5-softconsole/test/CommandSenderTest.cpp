//
// Created by Matthew Kwiatkowski on 2021-02-27.
//
#include "gtest/gtest.h"
extern "C" {
// Get declaration for f(int i, char c, float x)
#include "../command_handler.h"
#include "../command_sender.h"
}

bool got_command = false;

void get_command(CANMessage_t msg){
    got_command = true;
}

CANMessage_t expected;

bool compareArrays(uint8_t a[], uint8_t b[], int n) {
    int ii;
    for(ii = 1; ii <= n; ii++) {
        if (a[ii] != b[ii]) return false;
        // better:
        // if(fabs(a[ii]-b[ii]) < 1e-10 * (fabs(a[ii]) + fabs(b[ii]))) {
        // with the appropriate tolerance
    }
    return true;
}

void got_command_equals(CANMessage_t msg){
    if(expected.id == msg.id && compareArrays(msg.data, expected.data, msg.dlc)){
        got_command = true;
    }
    got_command = false;
}



TEST(CommandSenderTest, TestDispatching){
    got_command = false;
    set_output_controller(get_command);
    uint8_t arr[] = {1};
    send_command(CDH, HEARTBEAT, arr, 1);
    ASSERT_TRUE(got_command);
}
