/*
 * tests.c
 *
 *  Created on: Dec. 4, 2021
 *      Author: Jonathan Balewicz
 */

/*-----------------------------------------------------------*/

#include "tests.h"

#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"
#include "semphr.h"

void vTestSPI(void *pvParameters)
{
    uint8_t test_cmd[] = {0x55, 0x56};
    uint8_t test_wr[] = {0x01, 0x02, 0x03, 0x04, 0x05};
    uint8_t test_rd[4];

    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);

    for (;;)
    {
        vTaskSuspendAll();
        // Write a block every second.
        spi_transaction_block_write_with_toggle(
                    CORE_SPI_0,
                    SPI_SLAVE_0,
                    test_cmd,
                    sizeof(test_cmd) / sizeof(test_cmd[0]),
                    test_wr,
                    sizeof(test_wr) / sizeof(test_wr[0])
                );
        xTaskResumeAll();

        taskYIELD();
        vTaskSuspendAll();
        spi_transaction_block_read_with_toggle(
                    CORE_SPI_0,
                    SPI_SLAVE_0,
                    test_cmd,
                    sizeof(test_cmd) / sizeof(test_cmd[0]),
                    test_rd,
                    sizeof(test_rd) / sizeof(test_rd[0])
                );
        xTaskResumeAll();
        vTaskDelay(xDelay1000ms);
    }
}

/*-----------------------------------------------------------*/
void vTestCANTx(void *pvParameters)
{
    const TickType_t delay = pdMS_TO_TICKS(100);
    CANMessage_t msg = {
                        0x321,
                        1,
                        8,
                        {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08}
                     };
    for (;;)
    {
        if (CAN_TRANSMIT_READY())
        {
            CAN_transmit_message(&msg);
        }
        vTaskDelay(delay);
    }
}

/*-----------------------------------------------------------*/
void vTestCANRx(void *pvParameters)
{
    int messages_processed = 0;
    CANMessage_t rx_msg;
    for (;;)
    {
        if (xQueueReceive(can_rx_queue, &rx_msg, portMAX_DELAY) == pdTRUE)
        {
            messages_processed++;
        }
    }
}

/*-----------------------------------------------------------*/
void vTestWD(void *pvParameters)
{
    // In the future, this task could be used as a reset service. For instance, tasks could:
    // - Check-in to this task. If a task fails to check-in as expected, the watchdog would be left to reset.
    // - Request a reset.

    // Note that the watchdog is not enabled (by the MSS) for certain situations, such as:
    // - While debugging.
    // - Programming.
    if (timeout_occured_WD())
    {
        clear_timeout_WD();
        // TODO - Log event!
    }
    else
    {
        // TODO - Log event!
    }

    for (;;)
    {
        service_WD();
        vTaskDelay(pdMS_TO_TICKS(WD_TASK_PERIOD_ms));
    }
}

/*-----------------------------------------------------------*/
void vTestRTC(void *pvParameters)
{
    // Test code
    static volatile int error_occurred = 0;

    static Calendar_t buffer = {
            59u, // seconds
            59u, // minutes
            23u, // hours
            28u, // day
            2u, // February
            20u, // year (2020)
            1u, // weekday
            1u, // week (not used), HOWEVER it must be 1 or greater.
    };

    static Calendar_t buffer2;

    vTaskSuspendAll();
    ds1393_write_time(&buffer);
    if (TIME_SUCCESS != resync_rtc())
    {
        error_occurred = 1;
    }
    xTaskResumeAll();

    for (;;)
    {
        vTaskSuspendAll();
        ds1393_read_time(&buffer);
        read_rtc(&buffer2);
        xTaskResumeAll();
        vTaskDelay(pdMS_TO_TICKS(500));
    }
}

/*-----------------------------------------------------------*/
void vTestFlash(void *pvParameters)
{

	FlashDevice_t flash_device;

	FlashStatus_t result = flash_dev_init(&flash_device,CORE_SPI_0, MSS_GPIO_5, 8, ECC_ON);

	MSS_GPIO_config( MSS_GPIO_3, MSS_GPIO_OUTPUT_MODE );

	if(result != FLASH_OK){
		while(1);
	}
	int done =0;
	uint8_t data_rx[2048];
	int i;
	int pageNum = 0;
	int blockNum=0;
	int address=0x0000000;
	int numBadBlock = 0;
	int led = 0;
	int BB[50];
	uint8_t data_tx[2048];

	// Clear the receive buffer and put a repeating sequence of 0-255 into the
	// transmit buffer.
	for(i=0;i<2048;i++){
		data_tx[i] = i%256;
		data_rx[i] = 0;
	}


	// Check if we can read the bad block look up table.
	// There should be one mapping in the table(1 bad block).
	int num_bad_blocks = 0;
	result = flash_read_bb_lut(&flash_device,&flash_device.bb_lut,&num_bad_blocks);

	if(result != FLASH_OK || num_bad_blocks != 1){
		while(1);
	}


	// Erase the block.
	result = flash_erase_blocks(&flash_device,0,1);

	if(result != FLASH_OK){
		while(1);
	}


	result = flash_read(&flash_device,address,2048,data_rx);

	if(result != FLASH_OK){
		while(1);
	}
	int j;
	// Make sure page is erased.
	for(j=0;j<2048;j++){

		if(data_rx[j] != 0xFF){
			while(1);
		}
	}

	// Save the transmit buffer to flash memory.
	result = flash_write_(&flash_device,address,2048,data_tx);
	if(result != FLASH_OK){
		while(1);
	}


	result = flash_read(&flash_device,address,2048,data_rx);

	if(result != FLASH_OK){
		while(1);
	}

	// Make sure the data we read is the same as what was written.

	for(j=0;j<2048;j++){

		if(data_rx[j] != data_tx[j]){
			while(1);
		}
	}


	// Erase the block.
	result = flash_erase_blocks(&flash_device,0,1);

	if(result != FLASH_OK){
		while(1);
	}





    for (;;)
    {}
}

void vTestMRAM(void *pvParameters)
{
    // Test code that writes to all locations of the MRAM, and then reads it back.
    static uint8_t write_buffer[0x100];
    static uint8_t read_buffer1[sizeof(write_buffer)];
    uint8_t status_reg;

    static volatile int error_occurred = 0;

    for (int ix = 0; ix < sizeof(write_buffer); ix++)
    {
        write_buffer[ix] = 0x55;
    }
    for(;;)
    {
        // Loop through all addresses.
        for (int ix = 0; ix < MAX_MRAM_ADDRESS; ix += sizeof(write_buffer))
        {
           for (int ix = 0; ix < sizeof(write_buffer); ix++)
           {
              read_buffer1[ix] = 0xFF;
           }

           vTaskSuspendAll();
           mr2xh40_write(&mram_instances[MRAM_INSTANCE_0], ix, write_buffer, sizeof(write_buffer));
           xTaskResumeAll();

           taskYIELD();

           vTaskSuspendAll();
           mr2xh40_read(&mram_instances[MRAM_INSTANCE_0], ix, read_buffer1, sizeof(read_buffer1));
           xTaskResumeAll();

           for (int iy = 0; iy < sizeof(write_buffer); iy++)
           {
               if (read_buffer1[iy] != write_buffer[iy])
               {
                   error_occurred = 1; // Breakpoint here!
               }
           }

           vTaskDelay(pdMS_TO_TICKS(2000)); // Breakpoint here to make sure you are done!
        }
    }
}

