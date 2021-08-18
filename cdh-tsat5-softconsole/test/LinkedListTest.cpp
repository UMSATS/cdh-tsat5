//
// Created by Matthew Kwiatkowski on 2021-03-13.
//
/**
 * Unit tests for the llist.h and llist.c
 */
#include "gtest/gtest.h"
extern "C" {
// Get declaration for f(int i, char c, float x)
#include "../llist.h"
}

TEST(LinkedListTest, TestPlainAdd){
    llist* list = llist_create(NULL);
    const char *data = "b";
    llist_push(list, (void *) data);
    ASSERT_EQ(llist_pop(list), data);
}

TEST(LinkedListTest, TestPlainAddNegative){
    llist* list = llist_create(NULL);
    const char *data = "b";
    const char *data2 = "c";
    llist_push(list, (void *) data2);
    ASSERT_NE(llist_pop(list), data);
}

TEST(LinkedListTest, TestRemoveHead){
    llist* list = llist_create(NULL);
    const char *data = "b";
    llist_push(list, (void *) data);
    ASSERT_TRUE(llist_remove(list, (void*)data));
}

TEST(LinkedListTest, TestRemoveMiddle){
    llist* list = llist_create(NULL);

    const char *data1 = "b";
    const char *data2 = "c";
    const char *data3 = "d";
    llist_push(list, (void *) data3);
    llist_push(list, (void *) data1);
    llist_push(list, (void *) data2);
    ASSERT_TRUE(llist_remove(list, (void*)data1));
}

TEST(LinkedListTest, TestRemoveNoContains){
    llist* list = llist_create(NULL);

    const char *data1 = "b";
    const char *data2 = "c";
    const char *data3 = "d";
    llist_push(list, (void *) data1);
    llist_push(list, (void *) data2);
    ASSERT_FALSE(llist_remove(list, (void*)data3));
}

