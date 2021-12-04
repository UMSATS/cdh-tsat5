//
// Created by Matthew Kwiatkowski on 2021-02-13.
//

#ifndef COMMANDHANDLER_COMMAND_SENDER_H
#define COMMANDHANDLER_COMMAND_SENDER_H

#include "command_handler.h"

/**
 * Enum types for outgoing messages
 * first 2 bytes is id, last 2 bytes is priority
 * (max value for priority is 0b11111 (0x1F) = LOWEST priority)
 */
 typedef enum{
     ACKNOWLEDGE = 0x0106,
     NON_ACKNOWLEDGE = 0x0205,
     SHUTDOWN = 0x1000,
     HEARTBEAT = 0x201F
 }OutgoingCommand;


/**
 * Sends a command to the given subsystem
 * Default (recommended) priority is used
 * @param systemId the subsystem to send the command to
 * @param command the command Opcode
 * @param data the data associated with the command (or null if no extra data)
 * @param datalength the length of the data sent. (≤7!!).
 */
 void send_command(SystemID systemId, OutgoingCommand command, uint8_t data[], uint8_t datalength);

 /**
  * Sends a command to the given subsystem
  * A Custom priority is used
  * @param systemId the subsystem to send the command to
  * @param command the command Opcode
  * @param data the data associated with the command (or null if no extra data)
  * @param datalength the length of data sent. (≤7!!!).
  * @param priority the custom priority of the command (max is 0b00000, min is 0b11111)
  */
 void send_command_priority(SystemID systemId, OutgoingCommand command, uint8_t data[],uint8_t datalength, uint8_t priority);

 void set_output_controller(void(*func)(CANMessage_t));

#endif //COMMANDHANDLER_COMMAND_SENDER_H
