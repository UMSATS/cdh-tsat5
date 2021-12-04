//
// Created by Matthew Kwiatkowski on 2021-01-30.
//

#ifndef COMMANDHANDLER_COMMAND_HANDLER_H
#define COMMANDHANDLER_COMMAND_HANDLER_H

#include <stdint.h>

#define COMMAND_MAP_SIZE 8




/**
 * Enum type for addressing different subsystems
 */
typedef enum{
    CDH = 0x00,
    VHF = 0x01,
    PCU = 0x02,
    ADCS = 0x05,
    PAYLOAD = 0x07
} SystemID;



typedef struct
{
    uint32_t id;                         // Message ID.
    //first (leftmost) 5 bits is message priority, where 0b11111 is lowest
    //next 3 bits is the destination system id
    //and final 3 bits is the source system id

    uint8_t  extended;                   // 1 if extended, 0 otherwise.
    uint8_t  dlc;                        // Data length code (i.e. number of bytes).
    uint8_t*  data;  // Array containing the data bytes (up to 8).
} CANMessage_t;



/**
 * Initializes the command handler
 */
void init_handler();

/**
 * Handles an incoming message
 */
void handle_incoming(CANMessage_t);

/**
 * Sets the handler function of the specific given opcode
 * to be the given function.
 * Any previous handlers will be overridden.
 * WARNING: make sure init_handler() was called
 * before using this
 * @param opcode the operation code to map for (i.e 0x01 is shutdown opcode)
 * @param handlerFunction the function to handle incoming messages,
 *        should take as input the message
 */
void add_handler(uint8_t, void(*handlerFunction)(CANMessage_t));

/**
 * Sends a default 'acknowledge' message, for the current incoming message being processed.
 */
void send_default_ack();

/**
 * Sends a default 'nonacknowledge' message, for the current incoming message being processed.
 */
void send_default_non_ack();




#endif //COMMANDHANDLER_COMMAND_HANDLER_H
