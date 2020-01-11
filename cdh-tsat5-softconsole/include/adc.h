/*
 * adc.h
 *
 *  Created on: Nov 16, 2019
 *      Author: njaoh
 */

#ifndef INCLUDE_ADC_H_
#define INCLUDE_ADC_H_

#include "spi.h"
#include "drivers/CoreSPI/core_spi.h"
#include "cdh_tsat5_system_hw_platform.h"

typedef enum __ADC_Input_Line
{
    IN0 = 0b000000,
    IN1 = 0b001000,
    IN2 = 0b010000,
    IN3 = 0b011000,
	IN4 = 0b100000,
	IN5 = 0b101000,
	IN6 = 0b110000,
	IN7 = 0b111000,
} ADC_Input_Line;

//Initialize the SPI for reading the ADC
void initADC();

// Read the ADC and return the result.
uint16_t readADC
		(CoreSPIInstance_t core, mss_gpio_id_t pin,       // The GPIO pin to used for ADC
		ADC_Input_Line ADCline);

#endif /* INCLUDE_ADC_H_ */
