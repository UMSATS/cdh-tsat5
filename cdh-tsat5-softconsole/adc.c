#include "adc.h"
#include "cdh_tsat5_system_hw_platform.h"
#include "spi.h"
#include "drivers/mss_gpio/mss_gpio.h"
#include "drivers/CoreSPI/core_spi.h"
#define SS_DISABLE_GPIO_STATE 1
#define SS_ENABLE_GPIO_STATE  0

#define SPI_GPIO_SS_ENABLE(pin)   MSS_GPIO_set_output((pin), SS_ENABLE_GPIO_STATE)
#define SPI_GPIO_SS_DISABLE(pin)  MSS_GPIO_set_output((pin), SS_DISABLE_GPIO_STATE)

//CoreSPIInstance_t core;

void initADC() {
	//spi_configure_slave(core, CORESPI_0_0, SPI_MODE_MASTER, SPI_MODE2, PCLK_DIV_16);
	//init_spi();
}

uint16_t readADC(CoreSPIInstance_t core,
		mss_gpio_id_t pin,       // The GPIO pin to used for ADC
	    ADC_Input_Line ADCLine) {

	uint8_t * line = &ADCLine;

	uint8_t MSB;
	uint8_t LSB;
	uint8_t *MSBp = &MSB;
	uint8_t *LSBp = &LSB;

	uint8_t result[2] = {0, 0};
	uint8_t cmd[3] = {1, 0, 0};
	uint8_t res[1] = {0};
	uint16_t data = 500;




	//SPI_write_byte(&core, &ADCLine);
	//spi_transaction_block_write_without_toggle(core, SPI_SLAVE_0, pin, &ADCline, 1, NULL, 0);
	spi_transaction_block_transfer_without_toggle(core, SPI_SLAVE_0, pin, 1, &ADCLine, &res, &result[1], 2);
	//spi_transaction_block_transfer_without_toggle(core, SPI_SLAVE_0, pin, 3, &cmd[1], &result[1], 3);
	//spi_transaction_block_transfer_without_toggle(core, SPI_SLAVE_0, pin, 3, &cmd[2], &result[2], 3);
	//spi_transaction_block_read_without_toggle(core, SPI_SLAVE_0, pin, &ADCline, 1, MSBp, 1);
	//spi_transaction_block_read_without_toggle(core, SPI_SLAVE_0, pin, NULL, 0, LSBp, 1);

    //uint16_t result = MSB;
	//result = result << 8;
	//result |= LSB;

	return MSB;
}

