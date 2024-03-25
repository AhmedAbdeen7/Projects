#include <iostream>
#include <string>
#include "Q.h"
#include "mechanic.cpp"
#include "customer.cpp"
using namespace std;

int main() {
    int num1, num2;
    cout << "Enter the number of customers and mechanics: ";
    cin >> num1 >> num2;

    mechanic* mechanics = new mechanic [num2];
    for (int i = 0; i < num2; i++) {
        string name;
        int  age, maxapps;
        string id;
        cout << "Enter mechanic " << i+1 << " name: ";
        cin >> name;
        mechanics[i].setname(name);
        cout << "Enter mechanic " << i+1 << " ID: ";
        cin >> id;
        mechanics[i].setid(id);
        cout << "Enter mechanic " << i+1 << " age: ";
        cin >> age;
        mechanics[i].setage(age);
        cout << "Enter the maximum number of appointments for mechanic " << i+1 << ": ";
        cin >> maxapps;
        mechanics[i].setmax(maxapps);
    }

    customer* customers = new customer[num1];
    for (int i = 0; i < num1; i++) {
        string name;
        int age, hours, mins;
        string id, mechanicID;
        cout << "Enter customer " << i+1 << " name: ";
        cin >> name;
        customers[i].setname(name);
        cout << "Enter customer " << i+1 << " ID: ";
        cin >> id;
        customers[i].setid(id);
        cout << "Enter customer " << i+1 << " age: ";
        cin >> age;
        customers[i].setage(age);
        cout << "Enter mechanic ID for customer " << i+1 << ": ";
        cin >> mechanicID;
        customers[i].setMechanicID(mechanicID);
        cout << "Enter appointment time for customer " << i+1 << " (hh:mm): ";
        cin >> hours >> mins;
        customers[i].setappoint(hours, mins);
    }

    Queue<customer> customerqueue;
    int numAssigned = 0;
    while (numAssigned < num1) {
        bool foundMechanic = false;
        for (int i = 0; i < num2; i++) {
            if (mechanics[i].isAvailable(customers[numAssigned].getappoint())) {
                customers[numAssigned].print();
                cout << "should be assigned to " << mechanics[i].getname() << " at "
                     << customers[numAssigned].getappoint().hours << ":" << customers[numAssigned].getappoint().minutes << endl;
                customers[numAssigned].setMechanicID(mechanics[i].getid());
                customerqueue.enqueue(customers[numAssigned]);
                numAssigned++;
                foundMechanic = true;
                break;
            }
        }
        if (!foundMechanic) {
            cout << "No mechanics available for customer " << customers[numAssigned].getname() << endl;
            numAssigned++;
        }
    }

    // Printing the customers in order of their appointments
    while (!customerqueue.empty()) {
        customer C = customerqueue.front();
        C.print();
        customerqueue.dequeue();
    }

    delete[] mechanics;
    delete[] customers;

    return 0;
}


for (int i = 0; i < numCustomers; i++) {
    bool assigned = false;
    for (int j = 0; j < numMechanics && !assigned; j++) {
        if (mechanics[j].isAvailable(customers[i].getAppointment().hours, customers[i].getAppointment().mins)) {
            mechanics[j].addAppointment(customers[i].getAppointment());
            customers[i].setMechanicID(mechanics[j].getId());
            assigned = true;
        }
    }
    if (!assigned) {
        // If no mechanic is available, assign to the next available mechanic
        for (int j = 0; j < numMechanics; j++) {
            if (mechanics[j].isAvailable(customers[i].getAppointment().hours, customers[i].getAppointment().mins)) {
                mechanics[j].addAppointment(customers[i].getAppointment());
                customers[i].setMechanicID(mechanics[j].getId());
                assigned = true;
                break;
            }
        }
    }
}


