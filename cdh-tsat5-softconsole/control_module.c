#include <stdio.h>
#include <string.h>

#include "control_module.h"
#include "dummytask.h"
#include "command_handler.h"
#include "command_sender.h"


enum controlModuleState state = LEOP;

void handleHoldingMessage(CANMessage_t msg);
void handleSPAMMessage(CANMessage_t msg);
void handleSelfieMessage(CANMessage_t msg);
void handlePayloadMessage(CANMessage_t msg);
void handleLowPowerMessage(CANMessage_t msg);
void handleUltraLowPowerMessage(CANMessage_t msg);



void controlModuleInit() {
    xTaskCreate(vPayload,
                "Payload State Task",
                256,
                NULL,
                1,
                NULL);
    vTaskDelay(1);

    xTaskCreate(vSelfie,
                "Selfie-Sat State Task",
                256,
                NULL,
                1,
                NULL);
    vTaskDelay(1);


    xTaskCreate(vSPAMDeployment,
                "SPAM Deployment State Task",
                256,
                NULL,
                1,
                NULL);
    vTaskDelay(1);

    xTaskCreate(vHolding,
                "Holding State Task",
                256,
                NULL,
                1,
                NULL);
    vTaskDelay(1);

    xTaskCreate(vLowPowerMode,
                "Low Power Mode State Task",
                256,
                NULL,
                1,
                NULL);
    vTaskDelay(1);

    xTaskCreate(vHeartBeat,
                "Heartbeat task",
                256,
                NULL,
                1,
                NULL);

    //vTaskDelay(10000);


    //vTaskSuspend(vHolding);

    add_handler(0xA0, handleHoldingMessage);
    add_handler(0xA1, handleSPAMMessage);
    add_handler(0xA2, handleSelfieMessage);
    add_handler(0xA3, handlePayloadMessage);
    add_handler(0XA4, handleLowPowerMessage);
    add_handler(0XA5, handleUltraLowPowerMessage);

    vTaskResume(vHeartBeat);


}

/**
 * @return The current state
 */
State getState(){
    return state;
}

/**
 * Called when a holding mode message is sent
 */
void handleHoldingMessage(CANMessage_t msg){
    vTaskSuspend(vLowPowerMode);
    state = Holding;
    vTaskResume(vHolding);
}

/**
 * Called when 'change state to SPAMDeployment' msg is sent
 * should be called once the current state is holding
 */
void handleSPAMMessage(CANMessage_t msg){
    vTaskSuspend(vLowPowerMode);
    vTaskSuspend(vHolding);
    if(state == Holding) {
        state = SPAMDeployment;
    }
}

/**
 * Called when 'change state to Selfie' msg is sent by task delay system.
 * should be called once the current state is holding
 */
void handleSelfieMessage(CANMessage_t msg){
    vTaskSuspend(vLowPowerMode);
    vTaskSuspend(vHolding);
    if (state == Holding) {
        state = SelfieSat;
        //send selfie command to ADCS
        /*send_command(ADCS, )*/
        vTaskResume(vSelfie);
        state = Holding;
    }
    vTaskResume(vHolding);
}

/**
 * Called when 'change state to Payload' msg is sent
 * should be called once the current state is holding
 */
void handlePayloadMessage(CANMessage_t msg){
    vTaskSuspend(vLowPowerMode);
    vTaskSuspend(vHolding);
    if (state == Holding) {
        state = Payload;
        vTaskResume(vPayload);
        state = Holding;
    }
    vTaskResume(vHolding);
}

/**
 * Called when 'change state to Low Power' msg is sent
 * should be called once the current state is holding
 */
void handleLowPowerMessage(CANMessage_t msg){
    vTaskSuspend(vHolding);
    state = LowPowerMode;
    vTaskResume(vLowPowerMode);
    vTaskResume(vHeartBeat);
}

/**
 * Called when 'change state to Ultra Low Power' msg is sent
 * Can be called whenever. Suspends all other tasks.
 */
void handleUltraLowPowerMessage(CANMessage_t msg){
    vTaskSuspend(vHolding);
    vTaskSuspend(vSelfie);
    vTaskSuspend(vLowPowerMode);
    vTaskSuspend(vPayload);
    vTaskSuspend(vHeartBeat);
    state = UltraLowPowerMode;
}


void logString(char * msg) {


}

static void vPayload(void *pvParameters)
{
    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);
    for (;;)
    {

        if (state == Payload) {




        }
        vTaskDelay(xDelay1000ms);
        vTaskSuspend(NULL);
    }
}

static void vSelfie(void *pvParameters)
{
    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);
    for (;;)
    {
        if (state == SelfieSat) {


        }
        vTaskDelay(xDelay1000ms);
        vTaskSuspend(NULL);
    }
}

static void vSPAMDeployment(void *pvParameters)
{
    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);
    for (;;)
    {
        if (state == SPAMDeployment) {



        }

        vTaskDelay(xDelay1000ms);
        vTaskSuspend(NULL);
    }
}

static void vLowPowerMode(void *pvParameters)
{
    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);
    for (;;)
    {
        if (state == LowPowerMode) {




        }
        vTaskDelay(xDelay1000ms);
    }
}

static void vHolding(void *pvParameters)
{
    const TickType_t xDelay1000ms = pdMS_TO_TICKS(1000);
    for (;;)
    {

        if (state == Holding) {


        }
        vTaskDelay(xDelay1000ms);

    }
}
/**
 * Less FreeRTos-coupled. ACTUALLY sends the heartbeat. Called by the heartbeat task.
 */
static void doHeartBeat(){
    if (state == UltraLowPowerMode) {
        vTaskSuspend(NULL);
    }else{
        //send heartbeat message
        send_command(VHF, HEARTBEAT, NULL, 0);
    }
}

/**
 * Handles sending out the 'heartbeat' message every 30 seconds
 */
static void vHeartBeat(void *pvParameters){
    const TickType_t xDelay1000ms = pdMS_TO_TICKS(30000);
    for (;;)
    {
        doHeartBeat();
        vTaskDelay(xDelay1000ms);

    }
}


//task for heartbeat every 30s get suspended in ULPM

