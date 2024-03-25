#ifndef NODE_H
#define NODE_H
#include<QString>
struct Node
{
    Node *next;
    Node *back;

    double info;
    Node()
    {
        next = nullptr;
        back = nullptr;
    }
};

#endif // NODE_H
