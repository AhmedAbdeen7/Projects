#include "welcome.h"
#include "ui_welcome.h"
#include "plane.h"

Welcome::Welcome(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Welcome)
{
    ui->setupUi(this);
    QPixmap pix("C:/Users/PowerDesktop/CS2-Project-main/Milestone 2/airplane-takeoff-landing-flight-aircraft-flugzeug-removebg-preview.png");
    ui->label_p->setPixmap(pix);
    int w = ui->label_p->width();
    int h = ui->label_p->height ();
    ui->label_p->setPixmap (pix.scaled (w, h, Qt::KeepAspectRatio));
}

Welcome::~Welcome()
{
    delete ui;
}

void Welcome::on_pushButton_clicked()
{
    this->hide();
    Plane* plane = new Plane();
    plane->show();
}
