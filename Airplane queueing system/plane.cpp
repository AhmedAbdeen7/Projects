#include "plane.h" // includes the header file that defines the Plane class
#include "ui_plane.h" // includes the header file that defines the user interface for the Plane class
#include <iostream> // includes the input/output stream library
#include <cstdlib> // includes the C standard library
#include <ctime> // includes the library that provides functions to manipulate time

Plane::Plane(QWidget *parent) // the constructor for the Plane class
    : QMainWindow(parent) // initializes the QMainWindow parent object
    , ui(new Ui::Plane) // creates a new Ui_Plane object
{
    ui->setupUi(this); // sets up the user interface for the current object
    ui->label_4->hide(); // hides label_4
    algorithm(); // calls the algorithm function
    QPixmap pix("C:/Users/Power/Desktop/CS2-Project-main/Milestone 2/istockphoto-1286812890-612x612 (1).jpg"); // loads the image located at the specified file path
    ui->label->setPixmap(pix); // sets the image as the pixmap for label
}
void Plane::algorithm() // a function that implements the queueing system simulation
{
    srand(time(0)); // seeds the random number generator with the current time
    QVector <int> ArrT(2); // creates a vector that holds the arrival times of planes
    double Tr = 0; // the time until the next landing
    double WaitTotal = 0; // the total waiting time
    int jobcount = 0; // the number of planes that have landed
    double t = 0; // the current time
    int i = 0; // the index of the next plane to arrive
    double Tarrival; // the arrival time of the next plane

    // Run simulation while there are still jobs in queue or time hasn't reached maximum
    while (t < Q.getTmax() || jobcount != i)
    {
        // Check if a new job arrived
        if ((double)rand() / RAND_MAX < Q.getProbArr())
        {
            // Check if queue is not full
            if (Q.DEQ_Length() < 10)
            {
                Tarrival = t;
                Q.Add_Rear(Tarrival);
                // Display arrival information on UI
                if (jobcount < 10) {
                    ui->label_3->setText(ui->label_3->text() + " Arrival#" + QString::number(i + 1) + " at: " + QString::number(Tarrival) + "\n");
                }
                else {
                    ui->label_2->setText(ui->label_2->text() + " Arrival#" + QString::number(i + 1) + " at: " + QString::number(Tarrival) + "\n");
                }
                ArrT[i] = Tarrival;
                ArrT.resize(ArrT.size() + 1);
                i++;
            }
            else
            {
                ui->label_3->setText(ui->label_3->text() + "Line is full" + "\n");
            }
        }

        // Check if service has started and job is being served
        if (Tr == 0 && !(Q.DEQisEmpty()))
        {
            double Tarrival = Q.View_Front()->info;

            double Tw = t - ArrT[jobcount];
            Q.Remove(Tarrival);
            WaitTotal += Tw;
            jobcount++;
            // Display service information on UI
            if (jobcount < 10) {
                ui->label_3->setText(ui->label_3->text() + "Job#" + QString::number(jobcount) + " Service Started at: " + QString::number(t) + " wait = " + QString::number(Tw) + "\n");
            }
            else {
                ui->label_2->setText(ui->label_2->text() + "Job#" + QString::number(jobcount) + " Service Started at: " + QString::number(t) + " wait = " + QString::number(Tw) + "\n");
            }
            Tr = Q.getLanding();
        }

        // Decrease remaining time until landing
        if (Tr > 0)
        {
            Tr--;
        }

        t++;
    }

    // Calculate and display average waiting time on UI
    double m = Q.AverageWait(WaitTotal, jobcount);
    if (jobcount < 10) {
        ui->label_3->setText(ui->label_3->text() + "Average wait time is " + QString::number(m) + "\n");
    }
    else {
        ui->label_2->setText(ui->label_2->text() + "Average wait time is " + QString::number(m) + "\n");
    }

    return;


}


// destructor
Plane::~Plane()
{
    delete ui;
}


void Plane::on_pushButton_clicked()
{
    // when clicked, label_3, and label_2 will be hidden and label_4 will be shown.
    // Reset button
    ui->label_3->setText("");
    ui->label_3->hide();
    ui->label_2->hide();
    ui->label_4->show();

}





void Plane::on_pushButton_2_clicked()
{
    // when clicked, creates new instance of Plane, and hides the existing one
    // Rerun button
    Plane* plane= new Plane;
    this->hide();
    plane->show();
}


