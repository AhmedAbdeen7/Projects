
#define QUEUE_H

template<typename T>
class Queue {
public:
    Queue();
    ~Queue();
    void enqueue(const T& data);
    void dequeue();
    T front() const;
    bool empty() const;
    int getSize() const;

private:
    T* data;
    int size;
    int capacity;
    int head;
    int tail;
};