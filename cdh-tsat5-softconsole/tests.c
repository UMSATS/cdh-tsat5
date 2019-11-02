/* Standard includes. */
#include <stdio.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "watchdog.h"
#include "task.h"

#include "can.h"
#include "leds.h"
#include "rtc_time.h"
#include "spi.h"

/*-----------------------------------------------------------*/
static void vTestSPI(void *pvParameters)
{
    uint8_t test_cmd[] = {0x55, 0x56};
    uint8_t test_wr[] = {0x01, 0x02, 0x03, 0x04, 0x05};
    uint8_t test_rd[4];

    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);

    for (;;)
    {
        if (WAIT_FOR_CORE_MAX_DELAY(CORE_SPI_0))
        {
            // Write a block every second.
            spi_transaction_block_write_with_toggle(
                        CORE_SPI_0,
                        SPI_SLAVE_0,
                        test_cmd,
                        sizeof(test_cmd) / sizeof(test_cmd[0]),
                        test_wr,
                        sizeof(test_wr) / sizeof(test_wr[0])
                    );

            spi_transaction_block_read_with_toggle(
                        CORE_SPI_0,
                        SPI_SLAVE_0,
                        test_cmd,
                        sizeof(test_cmd) / sizeof(test_cmd[0]),
                        test_rd,
                        sizeof(test_rd) / sizeof(test_rd[0])
                    );
            RELEASE_CORE(CORE_SPI_0);
        }
        vTaskDelay(xDelay1000ms);
    }
}

/*-----------------------------------------------------------*/
static void vTestCANTx(void *pvParameters)
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
static void vTestCANRx(void *pvParameters)
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
static void vTestWD(void *pvParameters)
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
static void vTestRTC(void *pvParameters)
{
	// Test code
	Calendar_t buffer = {
			59u, // seconds
			59u, // minutes
			23u, // hours
			28u, // day
			2u, // February
			20u, // year (2020)
			1u, // weekday
			1u, // week (not used), HOWEVER it must be 1 or greater.
	};

	Calendar_t buffer2;

	if (WAIT_FOR_RTC_CORE_MAX_DELAY())
	{
		ds1393_write_time(&buffer);
		if (TIME_SUCCESS != resync_rtc())
		{
			while(1){}
		}
		RELEASE_RTC_CORE();
	}
	else
	{
		while(1){}
	}

    for (;;)
    {
    	if (WAIT_FOR_RTC_CORE_MAX_DELAY())
		{
			ds1393_read_time(&buffer);
			read_rtc(&buffer2);
			RELEASE_RTC_CORE();
		}
        vTaskDelay(pdMS_TO_TICKS(500));
    }
}
