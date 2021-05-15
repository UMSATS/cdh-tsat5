adc.c
J
Type
Text
Size
781 bytes
Storage used
781 bytes
Location
42-External A/D Converter
Owner
me
Modified
Feb 8, 2020 by me
Opened
7:53 PM by me
Created
Feb 8, 2020 with Google Drive Web
Add a description
Viewers can download
#include "adc.h"
#include "cdh_tsat5_system_hw_platform.h"
#include "spi.h"
#include "drivers/mss_gpio/mss_gpio.h"
#include "drivers/CoreSPI/core_spi.h"
#define SS_DISABLE_GPIO_STATE 1
#define SS_ENABLE_GPIO_STATE  0

#define SPI_GPIO_SS_ENABLE(pin)   MSS_GPIO_set_output((pin), SS_ENABLE_GPIO_STATE)
#define SPI_GPIO_SS_DISABLE(pin)  MSS_GPIO_set_output((pin), SS_DISABLE_GPIO_STATE)

uint16_t readADC(CoreSPIInstance_t core,
		mss_gpio_id_t pin,       // The GPIO pin to used for slave select on the ADC
	    ADC_Input_Line ADCLine) {

	uint8_t result[3] = {0, 0, 0};

	spi_adc_read(core, SPI_SLAVE_0, pin, &ADCLine, &result);

	uint16_t resultNumber = result[1];
	resultNumber = resultNumber << 8;
	resultNumber |= result[2];

	return resultNumber;
}
