#ifndef LINKEDLIST_H
#define LINKEDLIST_H

#include "node.h"
#include <QString>
class LinkedList
{
private:
    Node *head, *tail;

public:
    LinkedList();

    Node *&get_head();

    Node *&get_tail();

    Node *append(int info_p);

    Node *insertMid(Node *curr, double info);
    void add(double info_p);
    void pop(double inf);
    ~LinkedList();
};

#endif // LINKEDLIST_H
