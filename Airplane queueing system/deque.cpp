#include <deque.h>
#include <QString>
Deque ::Deque()
{
    front = MyList.get_head();
    rear = MyList.get_tail();
    dequeLength = 0;
}

Deque ::~Deque()
{

    while (front != rear)
    {
        this->Remove_Front();
        front = front->next;
    }
}

int Deque ::DEQ_Length()
{
    int counter = 0;
    Node *temp;
    temp = MyList.get_head();
    while (temp != NULL)
    {
        ++counter;
        temp = temp->next;
    }
    temp = nullptr;
    delete temp;
    dequeLength = counter;
    return counter;
}

bool Deque ::DEQisEmpty()
{
    if (front == NULL && rear == NULL)
    {
        return true;
    }
    return false;
}

void Deque ::Add_Front(double info)
{
    Node *temp = new Node;
    temp->info = info;
    temp->next = NULL;
    temp->back = NULL;
    if (DEQisEmpty())
    {
        front = temp;
        return;
    }
    else
    {
        front->back = temp;
        temp->next = front;
        front = temp;
        return;
    }
    dequeLength++;
}

void Deque ::Add_Rear(double info)
{
    if (DEQisEmpty())
    {
        Add_Front(info);
        return;
    }

    Node *temp1 = new Node;
    Node *temp2 = front;

    while (temp2->next != NULL)
    {
        temp2 = temp2->next;
    }
    temp2->next = temp1;
    temp1->back = temp2;
    dequeLength++;
}

Node *Deque ::View_Front()
{
    return front;
}

double Deque ::Remove_Front()
{
    if (MyList.get_head() == NULL)
    {
        return -1.0;
    }
    else
    {
        Node *temp2 = MyList.get_head();
        MyList.get_head() = temp2->next;
        (temp2->next)->back = NULL;
        double inf = temp2->info;
        delete temp2;
        temp2 = nullptr;
        dequeLength--;
        return inf;
    }
}
void Deque::Remove(double a)
{
    Node *temp = front;
    while(temp->info!= a && temp!=nullptr)
    {
        temp = temp->next;
    }
    if(temp != nullptr)
    {
        if(temp == front)
        {
            front = temp->next;
        }
        if(temp->next != nullptr)
        {
            temp->next->back = temp->back;
        }
        if(temp->back != nullptr)
        {
            temp->back->next = temp->next;
        }

        delete temp;
    }
}
double Deque ::Remove_Rear()
{
    Node *temp;
    if (rear == nullptr)
        return -1.0;
    temp = rear;
    rear = rear->back;

    if (rear != nullptr)
        rear->next = nullptr;
    else
        front = rear = nullptr;
    double inf = temp->info;
    delete temp;
    dequeLength--;
    return inf;
}

Node *Deque ::View_Rear()
{
    return rear;
}
