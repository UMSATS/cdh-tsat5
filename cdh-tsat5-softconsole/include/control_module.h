//
// Created by Matthew Kwiatkowski on 2021-03-13.
//

#ifndef COMMANDHANDLER_CONTROL_MODULE_H
#define COMMANDHANDLER_CONTROL_MODULE_H
#include <stdio.h>


enum controlModuleState{LEOP, Holding, SPAMDeployment, SelfieSat, Payload, LowPowerMode, UltraLowPowerMode};
typedef enum controlModuleState State;

void controlModuleInit();
void logString(char * msg);
/**
 * @return The current state
 */
State getState();



static void vPayload(void *pvParameters);
static void vSelfie(void *pvParameters);
static void vSPAMDeployment(void *pvParameters);
static void vLowPowerMode(void *pvParameters);
static void vHolding(void *pvParameters);
static void vHeartBeat(void *pvParameters);



#endif //COMMANDHANDLER_CONTROL_MODULE_H
