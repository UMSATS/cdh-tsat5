//
// Created by Matthew Kwiatkowski on 2021-03-13.
//
/**
 * This is a dummy plug&play mirror of the task header.
 * This is for unit testing.
 * NOT for use on the smartfusion
 */

#ifndef COMMANDHANDLER_DUMMYTASK_H
#define COMMANDHANDLER_DUMMYTASK_H

#include <stdint.h>

typedef uint16_t TickType_t;

typedef void (*TaskFunction_t)(void*);

/**
 * Supposed to convert ms to ticks.
 * In this case, it doesn;t realy matter. ticks = ms = anything for testing
 */
TickType_t pdMS_TO_TICKS(uint16_t);

/**
 * Dummy implementation does NO delay :D
 * @param t ticks to delay
 */
void vTaskDelay(TickType_t t);

void xTaskCreate(TaskFunction_t pxTaskCode,
                           const char * const pcName,
                           const uint16_t usStackDepth,
                           void * const pvParameters,
                           uint8_t uxPriority,
                           void * const pxCreatedTask );

/**
 * Puts a TaskFunction back on the active list
 */
void vTaskResume(TaskFunction_t);

/**
 * Moves a TaskFunction onto the inactive list
 */
void vTaskSuspend(TaskFunction_t);

/**
 * Important function.
 * Simulates a 'tick'.
 * Running ALL active TaskFunctions
 */
void tick();




#endif //COMMANDHANDLER_DUMMYTASK_H
