#ifndef DEQUE_H
#define DEQUE_H

#include "node.h"
#include "linkedlist.h"
class Deque
{
private:
    Node *front, *rear;
    int dequeLength, deqmax;
    LinkedList MyList;

public:
    Deque();
    ~Deque();
    int DEQ_Length();
    bool DEQisEmpty();
    void Add_Front(double info);
    void Add_Rear(double info);
    void Remove(double a);
    double Remove_Front();
    double Remove_Rear();
    Node *View_Front();
    Node *View_Rear();
};

#endif // DEQUE_H
