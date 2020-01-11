#include "adc.h"
#include "cdh_tsat5_system_hw_platform.h"
#include "spi.h"
#include "drivers/mss_gpio/mss_gpio.h"
#define SS_DISABLE_GPIO_STATE 1
#define SS_ENABLE_GPIO_STATE  0

#define SPI_GPIO_SS_ENABLE(pin)   MSS_GPIO_set_output((pin), SS_ENABLE_GPIO_STATE)
#define SPI_GPIO_SS_DISABLE(pin)  MSS_GPIO_set_output((pin), SS_DISABLE_GPIO_STATE)

//SPI_instance_t core;

void initADC() {
	//spi_configure_slave(&core, CORESPI_0_0, SPI_MODE_MASTER, SPI_MODE2, PCLK_DIV_16);

}

uint16_t readADC(CoreSPIInstance_t core,
		mss_gpio_id_t pin,       // The GPIO pin to used for ADC
	    ADC_Input_Line ADCline) {

	uint8_t * line = &ADCline;

	uint8_t MSB;
	uint8_t LSB;
	uint8_t *MSBp = &MSB;
	uint8_t *LSBp = &LSB;



	spi_transaction_block_write_without_toggle(core, SPI_SLAVE_0, pin, &ADCline, 1, NULL, 0);
	spi_transaction_block_read_without_toggle(core, SPI_SLAVE_0, pin, NULL, 0, MSBp, 1);
	spi_transaction_block_read_without_toggle(core, SPI_SLAVE_0, pin, NULL, 0, LSBp, 1);

    uint16_t result = MSB;
	result = result << 8;
	result |= LSB;

	return result;
}

