#ifndef PLANE_H
#define PLANE_H

#include <QMainWindow>
#include <QString>
#include <QVector>

#include "airplanewaitingqueue.h"
#include "deque.h"
#include"node.h"
#include <QLabel>

// Define the namespace for the Qt library
QT_BEGIN_NAMESPACE
namespace Ui { class Plane; }
QT_END_NAMESPACE

// Declare the Plane class, which is a subclass of QMainWindow
class Plane : public QMainWindow
{
    Q_OBJECT

public:
    // Constructor for the Plane class
    Plane(QWidget *parent = nullptr);

    // Destructor for the Plane class
    ~Plane();

private slots:
    // Private slot that is called when a button is clicked
    void on_pushButton_clicked();

    // Private slot that is called when a button is clicked
    void on_pushButton_2_clicked();

private:
    // Private member function used for algorithmic of the queue simulation
    void algorithm();

    // Instance of the AirplaneWaitingQueue class
    AirplaneWaitingQueue Q;

    // Pointer to the user interface object created by Qt Designer
    Ui::Plane *ui;
};

// End of header guard
#endif // PLANE_H

