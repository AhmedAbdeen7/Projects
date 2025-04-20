#include <iostream>
#include <string>
#include "person header.h"
#include "customer.h"
using namespace std;

class mechanic : public person
{
private:
int counter;
appointment *arra;
int max;
public:
bool isAvailable(appointment d);
void setappoint(const customer& C);
int getcounter() const;
void setcounter(int num);
~mechanic();
mechanic(); 
void addAppointment(appointment app); 
void setmax(int m);
int getmax();
void print();

};