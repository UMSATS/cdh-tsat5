//
// Created by Matthew Kwiatkowski on 2021-03-13.
//
#include <stddef.h>
#include "dummytask.h"
#include "llist.h"

llist *activeTasks;
TaskFunction_t  currTask;

void init(){
    activeTasks = llist_create(NULL);
}

TickType_t pdMS_TO_TICKS(uint16_t ms){
    return ms;
}
void vTaskDelay(TickType_t t){
    //to nothing
}

void xTaskCreate(TaskFunction_t pxTaskCode,
                 const char * const pcName,
                 const uint16_t usStackDepth,
                 void * const pvParameters,
                 uint8_t uxPriority,
                 void * const pxCreatedTask ){
    if(activeTasks == NULL){
        init();
    }
    llist_push(activeTasks, pxTaskCode);
}

/**
 * Puts a TaskFunction back on the active list
 */
void vTaskResume(TaskFunction_t function){
    if(!llist_contains(activeTasks, function)){
        llist_push(activeTasks, function);
    }
}

/**
 * Moves a TaskFunction onto the inactive list
 */
void vTaskSuspend(TaskFunction_t function){
    if(function == NULL){
        if(currTask != NULL){
            llist_remove(activeTasks, currTask);
        }
    }else{
        llist_remove(activeTasks, function);
    }

}

//void tick(){
//    if(activeTasks == NULL){
//        return;
//    }
//    struct node *curr = *activeTasks;
//    while(curr != NULL){
//        if(curr->data != NULL){
//            currTask = (TaskFunction_t)curr->data;
//            (*currTask)(NULL);
//        }
//    }
//    currTask = NULL;
//}

