//
// Created by Matthew Kwiatkowski on 2021-04-24.
//
/**
 * A simple min-heap data structure, stored internally using an array
 *
 * Taken from: https://gist.github.com/sudhanshuptl/d86da25da46aa3d060e7be876bbdb343
 */
#include "heap.h"
Heap *CreateHeap(int capacity){
    Heap *h = (Heap * ) malloc(sizeof(Heap)); //one is number of heap

    //check if memory allocation is fails
    if(h == NULL){
        printf("Memory Error!");
        return;
    }
    h->count=0;
    h->capacity = capacity;
    h->arr = (int *) malloc(capacity*sizeof(HeapObj)); //size in bytes

    //check if allocation succeed
    if ( h->arr == NULL){
        printf("Memory Error!");
        return;
    }
    return h;
}

void insert(Heap *h, HeapObj key){
    if( h->count < h->capacity){
        h->arr[h->count] = key;
        heapify_bottom_top(h, h->count);
        h->count++;
    }
}

void heapify_bottom_top(Heap *h,int index){
    int temp;
    int parent_node = (index-1)/2;

    if(h->arr[parent_node].key > h->arr[index].key){
        //swap and recursive call
        temp = h->arr[parent_node].key;
        h->arr[parent_node] = h->arr[index];
        h->arr[index].key = temp;
        heapify_bottom_top(h,parent_node);
    }
}

void heapify_top_bottom(Heap *h, int parent_node){
    int left = parent_node*2+1;
    int right = parent_node*2+2;
    int min;
    int temp;

    if(left >= h->count || left <0)
        left = -1;
    if(right >= h->count || right <0)
        right = -1;

    if(left != -1 && h->arr[left].key < h->arr[parent_node].key)
        min=left;
    else
        min =parent_node;
    if(right != -1 && h->arr[right].key < h->arr[min].key)
        min = right;

    if(min != parent_node){
        temp = h->arr[min].key;
        h->arr[min] = h->arr[parent_node];
        h->arr[parent_node].key = temp;

        // recursive  call
        heapify_top_bottom(h, min);
    }
}

int PopMin(Heap *h){
    int pop;
    if(h->count==0){
        printf("\n__Heap is Empty__\n");
        return -1;
    }
    // replace first node by last and delete last
    pop = h->arr[0].key;
    h->arr[0] = h->arr[h->count-1];
    h->count--;
    heapify_top_bottom(h, 0);
    return pop;
}

