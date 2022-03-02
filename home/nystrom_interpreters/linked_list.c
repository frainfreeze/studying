#include <stdio.h>
#include <stdlib.h>

struct node {
    struct node *prev;
    struct node *next;
    int data;
};

void printList(struct node *head) {
    struct node *ptr = head;
    
    printf("[");

    while (ptr != NULL) {
        printf(" %d ", ptr->data);
        ptr = ptr->next;
    }

    printf("]\n");
}

void insertFront(struct node** head, int data) {
    // create new element
    struct node* new = (struct node*)malloc(sizeof(struct node));
    
    // fill it
    new->data = data;
    new->prev = NULL;
    new->next = (*head);

    // reasign current head to act as second entry
    if ((*head) != NULL)
        (*head)->prev = new;
    (*head) = new;
}

void insertAfter(struct node* prev_node, int data) {
    if (prev_node == NULL) {
        printf("prev_node node cannot be null.");
        return;
    }

    // create new element
    struct node* new = (struct node*)malloc(sizeof(struct node));
    
    // fill it
    new->data = data;
    new->prev = prev_node;    
    new->next = prev_node->next;

    // reassign old one
    prev_node->next = new;

    // set the next elements prev correctly
    if (new->next != NULL)
        new->next->prev = new;
}

void insertEnd(struct node** head, int data) {
    // if the list is empty, create a new list
    if (*head == NULL) {
        struct node* new = (struct node*)malloc(sizeof(struct node));
        new->prev = NULL;
        new->next = NULL;
        new->data = data;
    }

    // else find the end element and insert after it.
    struct node *last = (*head);
    while (1) {
        if (last->next == NULL)
            break;
        last = last->next;
    }
    insertAfter(last, data);
}

void delete(struct node** head, struct node* target) {
    if (*head == NULL || target == NULL)
        return;

    // we have to check if target is head as well
    if (*head == target)
        *head = target->next;

    
    // if target is not last node point the prev of next element to prev element
    if (target->next != NULL)
        target->next->prev = target-> prev;
  
    // if target is not first element, point its prev elements next to targets next
    if (target->prev != NULL)
        target->prev->next = target-> next;
  
    free(target);
}

int main() {
    struct node *head;
    struct node *one = NULL;
    struct node *two = NULL;
    struct node *three = NULL;

    one = malloc(sizeof(struct node));
    two = malloc(sizeof(struct node));
    three = malloc(sizeof(struct node));

    one->data = 1;
    two->data = 2;
    three->data = 3;

    one->next = two;
    one->prev = NULL;

    two->next = three;
    two->prev = one;

    three->next = NULL;
    three->prev = two;

    head = one;

    printList(head);
    
    insertFront(&head, 0);
    insertAfter(two, 0);
    insertEnd(&head, 0);
    printList(head);

    delete(&head, head->next->next->next);
    delete(&head, head->next->next->next->next);
    printList(head);
    return 0;
}