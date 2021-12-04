//
// Created by Matthew Kwiatkowski on 2021-04-24.
//

#ifndef COMMANDHANDLER_HEAP_H
#define COMMANDHANDLER_HEAP_H
/**
 * A simple min-heap data structure, stored internally using an array
 *
 * Taken from: https://gist.github.com/sudhanshuptl/d86da25da46aa3d060e7be876bbdb343 and modified.
 */
#include<stdio.h>
#include<stdlib.h>
/*
 Array Implementation of MinHeap data Structure
*/

/**
 * Object to be stored in a heap
 */
typedef struct {
    int key;
    void* value; //the actual object stored
} HeapObj;

struct Heap{
    HeapObj *arr;
    int count;
    int capacity;
};
typedef struct Heap Heap;

Heap *CreateHeap(int capacity);
void insert(Heap *h, HeapObj);
void print(Heap *h);
void heapify_bottom_top(Heap *h,int index);
void heapify_top_bottom(Heap *h, int parent_node);
int PopMin(Heap *h);


/**
 * Example usage:
 */
//int main(){
//    int i;
//    Heap *heap = CreateHeap(HEAP_SIZE, 0); //Min Heap
//    if( heap == NULL ){
//        printf("__Memory Issue____\n");
//        return -1;
//    }
//
//    for(i =9;i>0;i--)
//        insert(heap, i);
//
//    print(heap);
//
//    for(i=9;i>=0;i--){
//        printf(" Pop Minima : %d\n", PopMin(heap));
//        print(heap);
//    }
//    return 0;
//}

//void print(Heap *h){
//    int i;
//    printf("____________Print Heap_____________\n");
//    for(i=0;i< h->count;i++){
//        printf("-> %d ",h->arr[i]);
//    }
//    printf("->__/\\__\n");
//}

#endif //COMMANDHANDLER_HEAP_H
