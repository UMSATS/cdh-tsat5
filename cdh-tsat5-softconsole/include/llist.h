//
// Created by Matthew Kwiatkowski on 2021-03-13.
//

#ifndef COMMANDHANDLER_LLIST_H
#define COMMANDHANDLER_LLIST_H

/* llist.h
 * Generic Linked List
 */


struct node {
    void *data;
    struct node *next;
};

typedef struct node * llist;

/* llist_create: Create a linked list */
llist *llist_create(void *data);

/* llist_free: Free a linked list */
void llist_free(llist *list);

/* llist_add_inorder: Add to sorted linked list */
int llist_add_inorder(void *data, llist *list,
                      int (*comp)(void *, void *));

/**
 * Remove an element
 * @param list lit to remove from
 * @param data data to remove
 * @return 1 if data was sucessfully removed, 0 otherwise
 */
int llist_remove(llist *list, void *data);

/* llist_push: Add to head of list */
void llist_push(llist *list, void *data);

/* llist_pop: remove and return head of linked list */
void *llist_pop(llist *list);

int llist_contains(llist *list, void *data);

/* llist_print: print linked list */
void llist_print(llist *list, void (*print)(void *data));

#endif //COMMANDHANDLER_LLIST_H
