#include <iostream>
#include <string>
/*	double linked list (of ints), allows you to
		o make empty list
		o add element on the end
*/

struct node {
    int data;
    node *next, *prev;
};

class list {
public:
    list();
    void push_back(int num);
    node *begin();
    node *end(); // actually last element :p

private:
    node *head, *tail;
};

list::list()
{
    head = nullptr;
    tail = nullptr;
}

void list::push_back(int num)
{
    node * tmp;
    tmp = new node;
    tmp->data = num;
    tmp->next = nullptr;
    tmp->prev = tail;

    if (nullptr == head) {
        head = tmp;
        tail = tmp;
    } else {
        tail->next = tmp;
        tail = tmp;
    }
}

node *list::begin()
{
    return head;
}

node *list::end()
{
    return tail;
}

int main()
{
    list numbers;
    for (int i = 0; i < 10; ++i) {
        numbers.push_back(i+1);
    }

    std::cout << "\t    list: ";

    node *temp;
    temp = numbers.begin();
    while(temp!= nullptr) {
        std::cout << temp->data << " ";
        temp = temp->next;
    }

    std::cout << "\nreverse list: ";
    temp = numbers.end();
    while(temp!=nullptr) {
        std::cout << temp->data << " ";
        temp = temp->prev;
    }

	std::cout << std::endl;
	return 0;
}