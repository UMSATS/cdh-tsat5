
/*

* commands.c

 *
 *  Created on: Jun 9, 2019
 *      Author: njaoh
 */

#include "tests.h"
#include <string.h>

#include "commands.h"

#include "version.h"

#include "can.h"

#include "task.h"

#include <stdlib.h>

static const char* test = "string test\r\n";

static const CLI_Command_Definition_t xTestCommand =
{
    "test",
    "test: Prints a test message.\r\n",
	(void*)testCommand,
    0
};

static const CLI_Command_Definition_t xVersionCommand =
{
    "version",
    "version: Print the CDH version.\r\n",
	(void*)versionCommand,
    0
};

static const CLI_Command_Definition_t xEchoCommand =
{
    "echo",
    "echo: Prints back what has been typed.\r\n",
	(void*)echoCommand,
    1
};

static const CLI_Command_Definition_t xCANTestTCommand =
{
    "startCANtestt",
    "startCANtestt: Start CAN test Transmit.\r\n",
	(void*)CANTestTCommand,
    1
};

static const CLI_Command_Definition_t xCANTestRCommand =
{
    "startCANtestr",
    "startCANtestr: Start CAN test Receive.\r\n",
	(void*)CANTestRCommand,
    1
};

static const CLI_Command_Definition_t xTestSPICommand =
{
    "startSPItest",
    "startSPItestt: Start SPI test.\r\n",
	(void*)TestSPICommand,
    1
};

static const CLI_Command_Definition_t xTestRTCCommand =
{
    "startRTCtest",
    "startRTCtest: Start RTC test.\r\n",
	(void*)TestRTCCommand,
    1
};
static const CLI_Command_Definition_t xTestWDCommand =
{
    "startWDtest",
    "startWDtest: Start WD test.\r\n",
	(void*)TestWDCommand,
    1
};

static const CLI_Command_Definition_t xCANTestTStopCommand =
{
    "stopCANtestt",
    "stopCANtestt: stop CAN test Transmit.\r\n",
	(void*)CANTestTStopCommand,
    1
};

static const CLI_Command_Definition_t xCANTestRStopCommand =
{
    "stopCANtestr",
    "stopCANtestr: stop CAN test Receive.\r\n",
	(void*)CANTestRStopCommand,
    1
};

static const CLI_Command_Definition_t xTestSPIStopCommand =
{
    "stopSPItest",
    "stopSPItestt: stop SPI test.\r\n",
	(void*)TestSPIStopCommand,
    1
};

static const CLI_Command_Definition_t xTestRTCStopCommand =
{
    "stopRTCtest",
    "stopRTCtest: stop RTC test.\r\n",
	(void*)TestRTCStopCommand,
    1
};
static const CLI_Command_Definition_t xTestWDStopCommand =
{
    "stopWDtest",
    "stopWDtest: stop WD test.\r\n",
	(void*)TestWDStopCommand,
    1
};



void initCommand( )
{
	FreeRTOS_CLIRegisterCommand( &xTestCommand );
	FreeRTOS_CLIRegisterCommand( &xEchoCommand );
	FreeRTOS_CLIRegisterCommand( &xVersionCommand );
	FreeRTOS_CLIRegisterCommand( &xCANTestTCommand );
	FreeRTOS_CLIRegisterCommand( &xCANTestRCommand );
	FreeRTOS_CLIRegisterCommand( &xTestSPICommand );
	FreeRTOS_CLIRegisterCommand( &xTestRTCCommand );
	FreeRTOS_CLIRegisterCommand( &xTestWDCommand );
	FreeRTOS_CLIRegisterCommand( &xCANTestTStopCommand );
		FreeRTOS_CLIRegisterCommand( &xCANTestRStopCommand );
		FreeRTOS_CLIRegisterCommand( &xTestSPIStopCommand );
		FreeRTOS_CLIRegisterCommand( &xTestRTCStopCommand );
		FreeRTOS_CLIRegisterCommand( &xTestWDStopCommand );
}

BaseType_t testCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )
{
	strncpy( pcWriteBuffer,
	             test,
	             xWriteBufferLen );
	return pdTRUE;
}

BaseType_t versionCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )
{
	strncpy( pcWriteBuffer,
			(const uint8_t *) CDH_SW_VERSION_STRING,
		    xWriteBufferLen );
	return pdTRUE;
}

BaseType_t echoCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )
{
	int8_t *pcParameter1;
	BaseType_t xParameter1StringLength;
	pcParameter1 = FreeRTOS_CLIGetParameter( pcCommandString, 1, &xParameter1StringLength );
	char *returnStr = malloc(strlen(pcParameter1) + 7);
	strcpy(returnStr, "\n\r");
	strcat(returnStr, pcParameter1);
	strcat(returnStr, "\n\r");
	strncpy( pcWriteBuffer,
			returnStr,
	             xWriteBufferLen);
	memset(returnStr,0,strlen(returnStr));

	return pdTRUE;
}

BaseType_t CANTestTCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	xTaskCreate(vTestCANTx,
	                         "Test CAN Tx",
	                         configMINIMAL_STACK_SIZE,
	                         NULL,
	                         1,
	                         NULL);
    return pdTRUE;
}

BaseType_t CANTestRCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	xTaskCreate(vTestCANRx,
	                         "Test CAN Rx",
	                         configMINIMAL_STACK_SIZE,
	                         NULL,
	                         1,
	                         NULL);
	return pdTRUE;
}

BaseType_t TestWDCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	xTaskCreate(vTestWD,
	                         "Test WD",
	                         configMINIMAL_STACK_SIZE,
	                         NULL,
	                         1,
	                         NULL);
    return pdTRUE;
}

BaseType_t TestRTCCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	xTaskCreate(vTestRTC,
	                         "Test RTC",
	                         configMINIMAL_STACK_SIZE,
	                         NULL,
	                         1,
	                         NULL);
	return pdTRUE;
}

BaseType_t TestSPICommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{

	xTaskCreate(vTestSPI,
	                         "Test SPI",
	                         1000,
	                         NULL,
	                         1,
	                         NULL);
	return pdTRUE;
}
BaseType_t CANTestTStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	vTaskDelete(vTestCANTx);
    return pdTRUE;
}

BaseType_t CANTestRStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	vTaskDelete(vTestCANRx);
	return pdTRUE;
}

BaseType_t TestWDStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	vTaskDelete(vTestWD);
    return pdTRUE;
}

BaseType_t TestRTCStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{
	vTaskDelete(vTestRTC);
	return pdTRUE;
}

BaseType_t TestSPIStopCommand( int8_t *pcWriteBuffer,
                             size_t xWriteBufferLen,
                             const int8_t *pcCommandString )

{

	vTaskDelete(vTestSPI);
	return pdTRUE;
}
