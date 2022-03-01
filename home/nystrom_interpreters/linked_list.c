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

void insertFront(struct node** head, int data);
void insertAfter(struct node** prev_node, int data);
void insertEnd(struct node** head, int data);
void delete(struct node** head, struct node** target);

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
    return 0;
}