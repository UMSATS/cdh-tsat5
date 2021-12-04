//
// Created by Matthew Kwiatkowski on 2021-03-13.
//
/**
 * Unit tests for the llist.h and llist.c
 */
#include "gtest/gtest.h"
extern "C" {
// Get declaration for f(int i, char c, float x)
#include "../heap.h"
}

TEST(HeapTest, TestPlainAdd){
    Heap *heap = CreateHeap(HEAP_SIZE, 0)
    insert(heap)
}

TEST(HeapTest, TestAdd2InOrder){
    llist* list = llist_create(NULL);
    const char *data = "b";
    const char *data2 = "c";
    llist_push(list, (void *) data2);
    ASSERT_NE(llist_pop(list), data);
}

TEST(HeapTest,  TestAdd2Reverse){
    llist* list = llist_create(NULL);
    const char *data = "b";
    llist_push(list, (void *) data);
    ASSERT_TRUE(llist_remove(list, (void*)data));
}

