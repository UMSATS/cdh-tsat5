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
//  Command handler module - header file
//
// History
// 2021-01-30 by Matthew Kwiatkowski
// - Created.
// 2021-12-30 by Daigh Burgess
// - Add function prototypes & descriptons: setting rtc in two steps - handlers
// - Add function prototype & descripton: resyncing rtc - handler
//-------------------------------------------------------------------------------------------------------------------------------------------------------------


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


//HANDLERS:

/**
 * Handles unknown incoming commands.
 * Some sort of reporting should be done here.
 * @param msg the unknown command received.
 */
void handle_unknown_command(CANMessage_t msg);

/**
 * Handles the shutdown command
 */
void handle_shut_down(CANMessage_t msg);

/**
 * Set the first half of the rtc timestamp using the 4 data bytes in the CAN message
 * Sets: seconds, minutes, hours, days
 *
 * Sends an ACK if the first half of the rtc timestamp has been set successfully
 * Otherwise sends a NACK
 */
void handle_set_rtc_step1(CANMessage_t msg);

/**
 * Set the second half of the rtc timestamp using the 4 data bytes in the CAN message
 * Sets: months, years, weekday, week
 * Write the completed timestamp to the external rtc if the rtc timestamp is valid
 * Resync the internal rtc with the newly set external rtc
 *
 * Sends an ACK if the complete rtc timestamp has been set successfully
 * Otherwise sends a NACK
 */
void handle_set_rtc_step2(CANMessage_t msg);

/**
 * Write the date from the external rtc to the internal rtc
 *
 * Sends an Ack if the resync is successful
 * Otherwise sends a NACK
 */
void handle_resync_rtc(CANMessage_t msg);


#endif //COMMANDHANDLER_COMMAND_HANDLER_H
