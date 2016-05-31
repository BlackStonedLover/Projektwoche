// Need G4P library
import g4p_controls.*;
import processing.serial.*;
Serial myPort;
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


Led ledBlue = new Led(50, 0, 0, 255);
Led ledYellow = new Led (110, 255, 255, 0);
Led ledGreen = new Led (170, 0, 255, 0);
Led ledRed = new Led (240, 255, 0, 0);


int led;


public void setup() {
  myPort = new Serial (this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  size(480, 320, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  ledBlue.reset();
  ledYellow.reset();
  ledGreen.reset();
  ledRed.reset();

}

public void draw() {
  switch(ledCol) {
  case 0:
    ledRed.zeichnen();
    //println("zeichnet");
    ledBlue.reset();
    ledYellow.reset();
    ledGreen.reset();

    break;
  case 1:
    ledYellow.zeichnen();
    // println("zeichnet");
    ledBlue.reset();
    ledGreen.reset();
    ledRed.reset();
    break;
  case 2:
    ledGreen.zeichnen();
    //println("zeichnet");
    ledBlue.reset();
    ledYellow.reset();
    ledRed.reset();
    break;
  case 3:
    ledBlue.zeichnen();
    //rintln("zeichnet");
    ledYellow.reset();
    ledGreen.reset();
    ledRed.reset();
    break;

  default :
    //println("error");
  }
}
int ledCol=4;

void serialEvent(Serial myPort) {

  String recv = myPort.readStringUntil('\n');
  println(recv);
  if (recv != null) {

    if (recv.trim().equals("_red")) {
      println("true");
      ledCol = 0;
    }
    if (recv.trim().equals("_yellow")) {
      println("true");
      ledCol = 1;
    }
    if (recv.trim().equals("_green")) {
      println("true");
      ledCol = 2;
    }
    if (recv.trim().equals("_blue")) {
      println("true");
      ledCol = 3;
    }
    println("String recived");
  }
}








// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}