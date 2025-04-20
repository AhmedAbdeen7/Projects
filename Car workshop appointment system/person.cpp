#include <iostream>
#include <string>
#include "person header.h"
using namespace std;

void person :: setname(string n)
{
    name = n;
  
}
void person :: setid(string i)
{
    id = i;
}
void person ::setage(int Age)
{
      age = Age;
}
string person :: getname() const
{
    return name;
}
string person :: getid() const
{
    return id;
}
int person :: getage() const
{
 return age;
}
person :: person()
{
     name = "";
   id = "";
   age = 0;
}
