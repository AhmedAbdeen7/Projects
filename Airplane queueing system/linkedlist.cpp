#include "node.h"
#include "LinkedList.h"
Node *&LinkedList ::get_head()
{
    return head;
}

Node *&LinkedList ::get_tail()
{
    return tail;
}

LinkedList ::LinkedList()
{
    head = nullptr;
    tail = nullptr;
}

LinkedList ::~LinkedList()
{
    head = NULL;
    tail = NULL;
}

void LinkedList ::add(double info_p) // this is similar to the append function done in a previous lab.
{
    Node *temp = new Node;
    temp->info = info_p;
    if (head == NULL)
    {
        head = temp;
        tail = head;
    }
    else
    {

        temp->back = tail;
        tail->next = temp;
        temp->next = NULL;
        tail = tail->next;
    }
}

void LinkedList ::pop(double inf)
{
    Node *current = head;
    Node *previous = nullptr;

    while (current != nullptr)
    {
        if (current->info == inf)
        {

            if (previous == nullptr)
            { // deleting the head node
                head = current->next;
            }
            else
            {
                previous->next = current->next;
            }
            if (current->next == nullptr)
            { // deleting the tail node
                tail = previous;
            }
            else
            {
                current->next->back = previous;
            }
            Node *nextNode = current->next;
            delete current;
            current = nextNode;
            while (current != nullptr && current->info == inf)
            {

                Node *nodeToDelete = current;
                current = current->next;
                delete nodeToDelete;
            }
            return;
        }
        previous = current;
        current = current->next;
        return;
    }

}
