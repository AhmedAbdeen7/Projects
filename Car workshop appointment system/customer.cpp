#include <iostream>
#include <string>
#include "customer.h"
#include "person header.h"
using namespace std;

void customer :: setappoint(int h, int mins)
{
    a.hours= h;
    a.minutes = mins;
}
void customer :: setMechanicID(string id)
{
    MechanicID = id;
}
appointment customer :: getappoint() const
{
    return a;
}
string customer :: getMechanicID() const
{
    return MechanicID;
}
bool customer :: operator ==(const customer& C) 
{
  if (a.hours == C.a.hours && a.minutes == C.a.minutes)
  return true;
  else
  return false;
}

bool customer ::  operator<(const customer &C)
{
    if (a.hours == C.a.hours) 
    {
      return a.minutes < C.a.minutes;
    }
    return a.hours < C.a.hours;
 

}
bool customer ::  operator>(const customer &C)
{
    if (a.hours == C.a.hours) 
    {
      return a.minutes > C.a.minutes;
    }
    return a.hours > C.a.hours;

}
void customer :: print() const
{
  cout << "Mr./Mrs. " << name << " should be assigned to the mechanic whose id is " << MechanicID;
}

