#include <iostream>
#include <string>
using namespace std;

class person
{
protected:
string name;
string id;
int age;
struct appointment
{
        int hours;
        int minutes;
}a;
public:
person();
void setname(string n);
void setid(string i);
void setage(int Age);
string getname() const;
string getid() const;
int getage() const;
virtual void print() const = 0;



};