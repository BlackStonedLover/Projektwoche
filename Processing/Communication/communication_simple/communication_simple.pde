// Example by Tom Igoe

import processing.serial.*;

class Led {
  int x;
  int y = 50;
  int Radius = 50;
  int r, g, b;

  Led( int x, int r, int g, int b) {
    this.r= r;
    this.g = g;
    this.b = b;
    this.x = x;
  }

  void zeichnen() {
    fill(r, g, b);
    ellipse(x, y, Radius, Radius);
    fill(255);
  }
  void reset() {
    fill(255);
    ellipse(x, y, Radius, Radius);
  }
}

// The serial port:
Serial myPort;       

void setup(){
  size(400,200);
      // List all the available serial ports:
      printArray(Serial.list());
      // Open the port you are using at the rate you want:
      //myPort = new Serial(this, Serial.list()[0], 9600);
        
      // Send a capital A out the serial port:
      //myPort.write(65);
}

void draw(){
    background(255);
    
    ellipse(75,65,30,30);
    ellipse(150,65,30,30);
    ellipse(225,65,30,30);
    ellipse(300,65,30,30);
    


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