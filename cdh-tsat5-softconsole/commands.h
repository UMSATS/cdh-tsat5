/*
 * commands.h
 *
 *  Created on: Jun 9, 2019
 *      Author: njaoh
 */

#ifndef COMMANDS_H_
#define COMMANDS_H_

#include "FreeRTOS.h"
#include "FreeRTOS_CLI.h"

void initCommand( );

BaseType_t testCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t echoCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t versionCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t CANTestTCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t CANTestRCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t TestWDCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );

BaseType_t TestRTCCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );

BaseType_t TestSPICommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t CANTestTStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t CANTestRStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );
BaseType_t TestWDStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );

BaseType_t TestRTCStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );

BaseType_t TestSPIStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString );

#endif /* COMMANDS_H_ */
