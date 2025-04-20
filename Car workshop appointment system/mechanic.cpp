#include <iostream>
#include <string>
#include "person header.h"
#include "mechanic.h"
using namespace std;


bool mechanic :: isAvailable(appointment d)
{
  for (int i = 0;i < counter;i++)
  {
    if (d.hours == arra[i].a.hours && d.minutes == arra[i].a.minutes)
    return false;
  }
  return true;
}
void setappoint(int hour, int mins)
{
 a.hours = hour;
 a.minutes = mins;
}
mechanic :: mechanic()
{
    setappoint(0,0);
    setcounter(0);
    arra = new appointment [counter];
}

 mechanic :: ~mechanic() 
 {
    
    delete[] arra;
        
}
  void mechanic :: print() const 
  {
        cout << " The mechanic " << id << ": " << name << ", " << age << " years old." << endl;
  }
   void mechanic :: addAppointment(appointment app) 
   {
     if (counter < max) 
     {
        arra[counter++] = app;
     }
    }
    void mechanic :: setmax(int m)
    {
      max = m;
    }

   int  mechanic :: getmax()
    {
       return max;
    }