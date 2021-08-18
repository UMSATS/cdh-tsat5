//
// Created by Matthew Kwiatkowski on 2021-02-13.
//
#include "command_sender.h"
#include <stdio.h>
#include <assert.h>
#include <string.h>


void (*outputController)(CANMessage_t);

void printPacket(CANMessage_t t){
    printf("id: %x, data:", t.id);
    for(int i = 0; i < sizeof(t.data); i++){
        printf("%x,",t.data[i]);
    }
    printf("\n");
}

/**
 * Sends a command to the given subsystem
 * A Custom priority is used
 * @param systemId the subsystem to send the command to
 * @param command the command Opcode
 * @param data the data associated with the command (or null if no extra data)
 *        *** DATA SHOULD BE ≤ 7 bytes
 * @param priority the custom priority of the command (max is 0b00000, min is 0b11111)
 */
void send_command_priority(SystemID systemId, OutgoingCommand command, uint8_t data[],uint8_t datalength, uint8_t priority){
    assert(datalength <= 7);
    uint8_t opcode = (command & (0xFF00))>>8;
    //id: leftmost 5 bits is the priority, next 3 is destination, next 3 is source id
    uint32_t id = (priority & 0b11111) << 6 | (systemId & 0b111) << 3 | (CDH & 0b111);
    uint8_t sendData[8] = {opcode, 0}; //data that will actually get sent
    if(data != NULL){
        memcpy(&sendData[1], data, (datalength < 7) ? datalength : 7);
    }
    CANMessage_t message = {id, 1, 8, sendData};
    (*outputController)(message);
    printPacket(message);
}

/**
 * Sends a command to the given subsystem
 * @param systemId the subsystem to send the command to
 * @param command the command Opcode
 * @param data the data associated with the command (or null if no extra data)
 *        *** DATA SHOULD BE ≤ 7 bytes
 */
void send_command(SystemID systemId, OutgoingCommand command, uint8_t data[], uint8_t datalength){
    send_command_priority(systemId, command, data, datalength, command & (0x00FF));
}

void set_output_controller(void(*func)(CANMessage_t)){
    outputController = func;
}

