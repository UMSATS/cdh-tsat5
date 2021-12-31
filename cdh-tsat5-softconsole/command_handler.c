//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// UMSATS 2018-2020
//
// License:
//  Available under MIT license.
//
// Repository:
//  Github: https://github.com/UMSATS/cdh-tsat5
//
// File Description:
//  Command handler module
//
// History
// 2021-01-30 by Matthew Kwiatkowski
// - Created.
// 2021-12-30 by Daigh Burgess
// - Add setting rtc in two steps - handlers
// - Add resyncing rtc - handler
//-------------------------------------------------------------------------------------------------------------------------------------------------------------


#include <zconf.h>
#include <stdio.h>
#include <assert.h>
#include "command_sender.h"
//#include "can.h"
#include "command_handler.h"

/**
 * The id of the current message being processed.
 */
CANMessage_t currmsg;

//SystemID systemIdMap[] = {CDH, VHF, PCU,0, 0,  ADCS, 0, PCU};

/**
 * This is a mapping of opcodes (such as 0x01 = shutdown)
 * to corresponding command handling functions
 * All functions in this map take as input the message that
 * was received.
 */
void (*command_function_map[(0x01<<COMMAND_MAP_SIZE)])(CANMessage_t)={NULL};


int val(int id);


void init_handler(){
        command_function_map[0x00] = handle_unknown_command; //by default any command pointing to 0 in the command map is ignored/reported.
        command_function_map[0x01] = handle_shut_down;
        command_function_map[0x90] = handle_set_rtc_step1;
        command_function_map[0x91] = handle_set_rtc_step2;
        command_function_map[0xD1] = handle_resync_rtc;
        ///////////////////////////////////////////
        //
        // ADD ALL OTHER COMMAND HANDLERS HERE
        //
        ///////////////////////////////////////////
//        printf("%d/n%d/n%d/n", val(0), val(1), val(2));
}

void handle_unknown_command(CANMessage_t msg){
    printf("Unrecognized Incoming command: %d", msg.id);

    //send a 'not acknowledged'
}

void handle_shut_down(CANMessage_t msg){

}

void handle_set_rtc_step1(CANMessage_t msg){
	if (set_external_rtc_step1(msg.data) == TIME_SUCCESS)
		send_default_ack();
	else
		send_default_non_ack();
}

void handle_set_rtc_step2(CANMessage_t msg){
	if (set_external_rtc_step2(msg.data) == TIME_SUCCESS){
		set_rtc_using_timestamp();
		send_default_ack();
	}
	else
		send_default_non_ack();
}

void handle_resync_rtc(CANMessage_t msg){
	if (resync_rtc() == TIME_SUCCESS)
		send_default_ack();
	else
		send_default_non_ack();
}


/**
 * Finds the associated handling function for the given message id
 * @param id the id to find a handling function for
 * @return a function pointer to the handling function, or NULL if there is none
 */
void (*get_handling_function(int id))(CANMessage_t){
    //precondition: the command id is valid
    assert(id < (0x01 << COMMAND_MAP_SIZE));
    return command_function_map[id];
}

/**
 * Peels the source system out of a message
 */
uint8_t get_source(CANMessage_t msg){
    return msg.id & 0b00000000111;
}


/**
 * Handles an incoming message
 */
void handle_incoming(CANMessage_t msg){
    //the first byte in data is the message opcode.
    currmsg = msg;
    void (*func)(CANMessage_t) = get_handling_function(msg.data[0]);
    if(func != NULL){
        (*func)(msg);
        send_default_ack();
    }else{
        //TODO error reporting
        handle_unknown_command(msg);
        send_default_non_ack();
    }
}


/**
 * Sends a default 'acknowledge' message, for the current incoming message being processed.
 */
void send_default_ack(){
    uint8_t data[] = {currmsg.data[0]};
    send_command(get_source(currmsg), ACKNOWLEDGE, data, 1);
}

/**
 * Sends a default 'nonacknowledge' message, for the current incoming message being processed.
 */
void send_default_non_ack(){
    uint8_t data[] = {currmsg.data[0]};
    send_command(get_source(currmsg), NON_ACKNOWLEDGE, data, 1);
}


void add_handler(uint8_t opcode, void(*handlerFunction)(CANMessage_t)){
    command_function_map[opcode] = handlerFunction;
}







