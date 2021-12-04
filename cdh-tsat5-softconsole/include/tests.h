/*
 * tests.h
 *
 *  Created on: Dec. 4, 2021
 *      Author: Jonathan Balewicz
 */

#ifndef INCLUDE_TESTS_H_
#define INCLUDE_TESTS_H_

/* Application includes. */
#include "can.h"
#include "flash.h"
#include "leds.h"
#include "mram.h"
#include "rtc_time.h"
#include "spi.h"
#include "uart.h"
#include "watchdog.h"

/*-----------------------------------------------------------*/
void vTestSPI(void *pvParameters);

/*-----------------------------------------------------------*/
void vTestCANTx(void *pvParameters);

/*-----------------------------------------------------------*/
void vTestCANRx(void *pvParameters);

/*-----------------------------------------------------------*/
void vTestWD(void *pvParameters);

/*-----------------------------------------------------------*/
void vTestRTC(void *pvParameters);

/*-----------------------------------------------------------*/
void vTestFlash(void *pvParameters);

void vTestMRAM(void *pvParameters);


#endif /* INCLUDE_TESTS_H_ */
