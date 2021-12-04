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
//  Main entry point for the project. Created using the demo project given as a starting point:
//    - https://www.digikey.com/eewiki/display/microcontroller/Getting+Started+with+the+Microsemi+SmartFusion+2+Maker-Board
//
// History
// 2019-01-16 by Tamkin Rahman and Joseph Howarth
// - Removed UART1 and IoT node code.
// 2019-02-08 by Tamkin Rahman
// - Add test code for SPI.
// 2019-02-24 by Tamkin Rahman
// - Update test code for SPI, and create a second task for SPI tests.
// 2019-03-28 by Tamkin Rahman
// - Add test code for CAN.
// 2019-04-16 by Tamkin Rahman
// - Add test code for watchdog and rtc.
// 2019-06-09 by Joseph Howarth
// - Add test code for flash.
// 2019-06-23 by Tamkin Rahman
// - Add test code for MRAM
// - Update test code for RTC to remove traps.
// - Prevent task switching instead of using mutexes for SPI read/write.

//-------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
    FreeRTOS V9.0.0 - Copyright (C) 2016 Real Time Engineers Ltd.
    All rights reserved

    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.

    ***************************************************************************
    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
    >>!   distribute a combined work that includes FreeRTOS without being   !<<
    >>!   obliged to provide the source code for proprietary components     !<<
    >>!   outside of the FreeRTOS kernel.                                   !<<
    ***************************************************************************

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
    link: http://www.freertos.org/a00114.html

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that is more than just the market leader, it     *
     *    is the industry's de facto standard.                               *
     *                                                                       *
     *    Help yourself get started quickly while simultaneously helping     *
     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
     *    tutorial book, reference manual, or both:                          *
     *    http://www.FreeRTOS.org/Documentation                              *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org/FAQHelp.html - Having a problem?  Start by reading
    the FAQ page "My application does not run, what could be wrong?".  Have you
    defined configASSERT()?

    http://www.FreeRTOS.org/support - In return for receiving this top quality
    embedded software for free we request you assist our global community by
    participating in the support forum.

    http://www.FreeRTOS.org/training - Investing in training allows your team to
    be as productive as possible as early as possible.  Now you can receive
    FreeRTOS training directly from Richard Barry, CEO of Real Time Engineers
    Ltd, and the world's leading authority on the world's leading RTOS.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.

    http://www.OpenRTOS.com - Real Time Engineers ltd. license FreeRTOS to High
    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and commercial middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/

/******************************************************************************
 * This project provides two demo applications.  A simple blinky style project,
 * and a more comprehensive test and demo application.  The
 * configCREATE_SIMPLE_BLINKY_DEMO_ONLY setting (defined in FreeRTOSConfig.h) is
 * used to select between the two.  The simply blinky demo is implemented and
 * described in main_blinky.c.  The more comprehensive test and demo application
 * is implemented and described in main_full.c.
 *
 * This file implements the code that is not demo specific, including the
 * hardware setup and FreeRTOS hook functions.
 *
 */

/* Standard includes. */
#include <stdio.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"
#include "semphr.h"

/* Driver includes. */
#include "drivers/mss_uart/mss_uart.h"    // For baud rate defines and instances

/* Application includes. */
#include "can.h"
#include "flash.h"
#include "leds.h"
#include "mram.h"
#include "rtc_time.h"
#include "spi.h"
#include "uart.h"
#include "watchdog.h"

/* External variables */
extern TaskHandle_t xUART0RxTaskToNotify;

/*
 * Set up the hardware ready to run this demo.
 */
static void prvSetupHardware( void );

/* Prototypes for the standard FreeRTOS callback/hook functions implemented
within this file. */
void vApplicationMallocFailedHook( void );
void vApplicationIdleHook( void );
void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName );
void vApplicationTickHook( void );

/*-----------------------------------------------------------*/
/* See the documentation page for this demo on the FreeRTOS.org web site for
full information - including hardware setup requirements. */

int main( void )
{
    BaseType_t status;

    /* Prepare the hardware to run this demo. */
    prvSetupHardware();

    // Create LED spinning task
//    status = xTaskCreate(    vTaskSpinLEDs,              // The task function that spins the LEDs
//                            "LED Spinner",               // Text name for debugging
//                            1000,                        // Size of the stack allocated for this task
//                            NULL,                        // Task parameter is not used
//                            1,                           // Task runs at priority 1
//                            NULL);                       // Task handle is not used
//
//    // Create UART0 RX Task
//    status = xTaskCreate(    vTaskUARTBridge,            // The task function that handles all UART RX events
//                            "UART0 Receiver",            // Text name for debugging
//                            1000,                        // Size of the stack allocated for this task
//                            (void *) &g_mss_uart0,       // Task parameter is the UART instance used by the task
//                            2,                           // Task runs at priority 2
//                            &xUART0RxTaskToNotify);      // Task handle for task notification
//
//    status = xTaskCreate(vTestSPI,
//                         "Test SPI",
//                         1000,
//                         NULL,
//                         1,
//                         NULL);
//
//    status = xTaskCreate(vTestSPI,
//                         "Test SPI2",
//                         1000,
//                         NULL,
//                         1,
//                         NULL);
//
//    // TODO - Starting to run out of heap space for these tasks... should start thinking about
//    // increasing heap space or managing memory in a smarter manner. First step would be looking
//    // at the FreeRTOS configurations and the linker file *.ld.
//    status = xTaskCreate(vTestCANTx,
//                         "Test CAN Tx",
//                         configMINIMAL_STACK_SIZE,
//                         NULL,
//                         1,
//                         NULL);
//
//    status = xTaskCreate(vTestCANRx,
//                         "Test CAN Rx",
//                         configMINIMAL_STACK_SIZE,
//                         NULL,
//                         1,
//                         NULL);
//
//    status = xTaskCreate(vTestWD,
//                         "Test WD",
//                         configMINIMAL_STACK_SIZE,
//                         NULL,
//                         1,
//                         NULL);
//
//    status = xTaskCreate(vTestRTC,
//                         "Test RTC",
//                         configMINIMAL_STACK_SIZE,
//                         NULL,
//                         1,
//                         NULL);
//
//	status = xTaskCreate(vTestFlash,
//                         "Test Flash",
//                         2000,
//                         NULL,
//                         1,
//                         NULL);
//
//    // TR - Not quite sure of the reason, but it appears that when we have a task created for both
//    //      vTestRTC and vTestMRAM, the device stops communicating over SPI after the vTestRTC task
//    //      finishes transmission (for the first time). In core_spi.c, the software gets stuck in the
//    //      while loop "while ( transfer_idx < transfer_size )" on line 134 in "SPI_block_read". The
//    //      rx_data_ready variable never evaluates to "true", and so the software is entering an infinite
//    //      loop, waiting for the CoreSPI status to be "rx ready" to perform the final read.
//    status = xTaskCreate(vTestMRAM,
//                         "Test MRAM",
//                         256,
//                         NULL,
//                         1,
//                         NULL);

    vTaskStartScheduler();

    return 0;
}

/*-----------------------------------------------------------*/
static void prvSetupHardware( void )
{
    /* Perform any configuration necessary to use the hardware peripherals on the board. */
    vInitializeLEDs();

    /* UARTs are set for 8 data - no parity - 1 stop bit, see the vInitializeUARTs function to modify
     * UART 0 set to 115200 to connect to terminal */
    vInitializeUARTs(MSS_UART_115200_BAUD);

    init_WD();
    init_spi();
    init_rtc();
    init_mram();
    init_CAN(CAN_BAUD_RATE_1000K);
}

/*-----------------------------------------------------------*/

void vApplicationMallocFailedHook( void )
{
    /* vApplicationMallocFailedHook() will only be called if
    configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
    function that will get called if a call to pvPortMalloc() fails.
    pvPortMalloc() is called internally by the kernel whenever a task, queue,
    timer or semaphore is created.  It is also called by various parts of the
    demo application.  If heap_1.c or heap_2.c are used, then the size of the
    heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
    FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
    to query the size of free heap space that remains (although it does not
    provide information on how the remaining heap might be fragmented). */

 // TODO - Log event!

    taskDISABLE_INTERRUPTS();
    for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationIdleHook( void )
{
    /* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
    to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
    task.  It is essential that code added to this hook function never attempts
    to block in any way (for example, call xQueueReceive() with a block time
    specified, or call vTaskDelay()).  If the application makes use of the
    vTaskDelete() API function (as this demo application does) then it is also
    important that vApplicationIdleHook() is permitted to return to its calling
    function, because it is the responsibility of the idle task to clean up
    memory allocated by the kernel to any task that has since been deleted. */

}
/*-----------------------------------------------------------*/

void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName )
{
    ( void ) pcTaskName;
    ( void ) pxTask;

    /* Run time stack overflow checking is performed if
    configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
    function is called if a stack overflow is detected. */

    // TODO - Log event!

    taskDISABLE_INTERRUPTS();
    for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationTickHook( void )
{
    /* This function will be called by each tick interrupt if
    configUSE_TICK_HOOK is set to 1 in FreeRTOSConfig.h.  User code can be
    added here, but the tick hook is called from an interrupt context, so
    code must not attempt to block, and only the interrupt safe FreeRTOS API
    functions can be used (those that end in FromISR()). */
}
/*-----------------------------------------------------------*/
