#ifndef AIRPLANEWAITINGQUEUE_H
#define AIRPLANEWAITINGQUEUE_H
#include "deque.h"
#include <QLabel>
//#include "plane.h"

class AirplaneWaitingQueue : public Deque
{
private:
    const double Tmax; // maximum time allowed
    double tLanding; // the time that a plane stays on the runway.
    const double avTime; // average time
    double probArr; // probability of arrival (to be compared with random value)

    // one sec
public:

    AirplaneWaitingQueue();
    ~AirplaneWaitingQueue();
//setters and getters

    double getProbArr();

    double getTmax();

    double getavTime();

    void setProbArr(double probArro);

    void setLanding(double landing);

    double getLanding();

    double AverageWait(double WaitTotal, int jobcount);


};

#endif // AIRPLANEWAITINGQUEUE_H
