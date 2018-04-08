#include <iostream>
#include <string>
/*	double linked list, allows you to
		o make empty list
		o add element on the end
        o remove last element
*/
template <typename T>
struct node {
    T data;
    node<T> *next = nullptr, *prev = nullptr;
};

template <class T>
class list {
public:
    list();
    void push_back(T num);
    void pop_back();
    node<T> *begin();
    node<T> *end(); // last element
    ~list();

private:
    node<T> *head, *tail;
};

template <class T>
list<T>::list()
{
    head = nullptr;
    tail = nullptr;
}

template <class T>
node<T> *list<T>::begin()
{
    return head;
}

template <class T>
node<T> *list<T>::end()
{
    return tail;
}

template <class T>
void list<T>::push_back(T num)
{
    node<T> * tmp;
    tmp = new node<T>;
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

template <class T>
void list<T>::pop_back()
{
    node<T>* tmp;
    tmp = tail->prev;
    if (head->next != nullptr){
        delete tail;
        tmp->next = nullptr;
        tail = tmp;
    } else {
        delete head;
        tail = nullptr;
        head = nullptr;
    }
}

template <class T>
list<T>::~list()
{
    while (tail!=nullptr) {
        pop_back();
    }
}

int main()
{
    // ints test
    list<int> numbers;
    for (int i = 0; i < 10; ++i) {
        numbers.push_back(i+1);
    }

    std::cout << "int     list: ";

    node<int> *temp;
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
    std::cout << std::endl << std::endl;

    // floats test
    list<float> numbersf;
    for (int i = 0; i < 10; ++i) {
        numbersf.push_back(static_cast<float>(i + 1.1));
    }

    for(int i = 0; i<5; ++i)
        numbersf.pop_back();

    std::cout << "float   list: ";

    node<float> *tempf;
    tempf = numbersf.begin();
    while(nullptr != tempf) {
        std::cout << tempf->data << " ";
        tempf = tempf->next;
    }

    std::cout << "\nreverse list: ";
    tempf = numbersf.end();
    while(nullptr != tempf) {
        std::cout << tempf->data << " ";
        tempf = tempf->prev;
    }
    std::cout << std::endl << std::endl;

    // string test
    list<std::string> str;
    for (int i = 0; i < 10; ++i) {
        auto s = std::to_string(i);
        if      (i % 3 == 0 && i % 5 == 0) str.push_back("FizzBuzz");
        else if (i % 3 == 0)               str.push_back("Fizz");
        else if (i % 5 == 0)               str.push_back("Buzz");
        else str.push_back(s);
    }

    std::cout << "string  list: ";

    node<std::string> *temps;
    temps = str.begin();
    while(nullptr != temps) {
        std::cout << temps->data << " ";
        temps = temps->next;
    }

    std::cout << "\nreverse list: ";
    temps = str.end();
    while(nullptr != temps) {
        std::cout << temps->data << " ";
        temps = temps->prev;
    }
    std::cout << std::endl;
    return 0;
}