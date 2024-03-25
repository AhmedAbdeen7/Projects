#include "airplanewaitingqueue.h"
#include "deque.h"
#include "deque.cpp"
#include <QString>

AirplaneWaitingQueue::AirplaneWaitingQueue() : Tmax(15),avTime(4)
{
    probArr = 1 / avTime;
    tLanding = 3;


}

double AirplaneWaitingQueue::AverageWait(double WaitTotal, int jobcount)
{
    if (jobcount == 0)
    {
        return 0;
    }
    else
    {
        return(WaitTotal/jobcount);
    }
}

AirplaneWaitingQueue ::~AirplaneWaitingQueue()
{
}



// Getter for probArr
double AirplaneWaitingQueue::getProbArr()  {
    return probArr;
}

double AirplaneWaitingQueue::getavTime()  {
    return avTime;
}

double AirplaneWaitingQueue::getTmax()  {
    return Tmax;
}


// Setter for probArr
void AirplaneWaitingQueue::setProbArr(double probArro) {
    probArr = probArro;
}





void AirplaneWaitingQueue::setLanding(double landing){
    tLanding = landing;
}

double AirplaneWaitingQueue::getLanding()
{
    return tLanding;
}
