#include <iostream>
#include <string>
#include "person header.h"
using namespace std;


class customer : public person
{
private:
string MechanicID;
appointment a;
public:
void setappoint(int h, int mins);
void setMechanicID(string id);
a getappoint();
string getMechanicID() const;
bool operator ==(const customer& C);
bool operator >(const customer& C);
bool operator <(const customer& C);
void print() const;
};