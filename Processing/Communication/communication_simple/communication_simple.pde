// Example by Tom Igoe

import processing.serial.*;

// The serial port:
Serial myPort;       

void setup(){
  size(400,200);
      // List all the available serial ports:
      printArray(Serial.list());
      // Open the port you are using at the rate you want:
      myPort = new Serial(this, Serial.list()[0], 9600);
        myPort.bufferUntil('\n');
      // Send a capital A out the serial port:
      //myPort.write(65);
}

void draw(){



}

void serialEvent(Serial myPort){

}

void pressButton(){

    fill(0,0,255);
    ellipse(75,100,30,30);
    fill(255,255,0);
    ellipse(150,100,30,30);
    fill(0,128,0);
    ellipse(225,100,30,30);
    fill(255,0,0);
    ellipse(300,100,30,30);
    fill(255);
}