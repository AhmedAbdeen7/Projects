#include "fruit.h"
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <random>
fruit::fruit() {
    value = 100;
}

int fruit::countEaten = 0; //this is to count the total number of fruits eaten, we will use it to calculate the value

int fruit::getValue() {
    return value*countEaten; //each time you eat a fruit the next fruit has 100 more points!
}

void fruit::increaseCount(){
    countEaten++;
}


//setting the Qpixmap image, dimensions, set the pixmap to the QgraphicsItem.
void fruit::setRandSprite()
{
    //we set the image to be a random fruit image from the four images
    std::srand(std::time(0));


    // To generate a random integer within a specific range, you can use modulo
    int randomInRange = std::rand() % 100; // Generates a random number between 0 and 99


    if(randomInRange == 0){
        sprite.load("C:/Users/Power/Desktop/Project/Assets/cherry.png");
    }else if(randomInRange == 1){
        sprite.load("C:/Users/Power/Desktop/Project/Assets/orange.png");
    }else if(randomInRange == 2){
        sprite.load("C:/Users/Power/Desktop/Project/Assets/apple.png");
    }else {
        sprite.load("C:/Users/Power/Desktop/Project/Assets/strawberry.png");
    }


    sprite = sprite.scaledToWidth(blockDim);
    sprite = sprite.scaledToHeight(blockDim);

    setPixmap(sprite);
}


//this function is called to reset the number of fruit eaten when the player starts a new game
void fruit::resetCount()
{
    countEaten = 0;
}




