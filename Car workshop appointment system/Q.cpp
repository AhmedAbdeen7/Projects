#include "Q.h"

template<typename T>
Queue<T>::Queue() : size(0), capacity(10), head(0), tail(0) {
    data = new T[capacity];
}

template<typename T>
Queue<T>::~Queue() {
    delete[] data;
}

template<typename T>
void Queue<T>::enqueue(const T& data) {
    if (size == capacity) {
        T* newData = new T[capacity * 2];
        for (int i = 0; i < size; i++) {
            newData[i] = this->data[(head + i) % capacity];
        }
        delete[] this->data;
        this->data = newData;
        head = 0;
        tail = size;
        capacity *= 2;
    }
    this->data[tail] = data;
    tail = (tail + 1) % capacity;
    size++;
}

template<typename T>
void Queue<T>::dequeue() {
    if (size == 0) {
        return;
    }
    head = (head + 1) % capacity;
    size--;
}

template<typename T>
T Queue<T>::front() const {
    return data[head];
}

template<typename T>
bool Queue<T>::empty() const {
    return size == 0;
}

template<typename T>
int Queue<T>::getSize() const {
    return size;
}