// Need G4P library
import g4p_controls.*;
import processing.serial.*;
Serial myPort;
// Klasse erstellt um LED´s mit bestimmter Farbe zu zeichnen. Hier wird in Farbe 
// gezeichnet und dann wieder resetet.
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

int[] PlayerScore = new int[6];


// Anlegen der neuen LED´s 

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
// In der draw werden die angezeigten LED´s beim drücken gezeichnet und die Anderen resetet.
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
  switch(loseControl) {
  case 1:
      loseControl =0;
    lose();

    break;
  default:
    //println("Error Lose Control");
  }
  
    switch(winControl) {
  case 1:
      winControl =0;
    addScore();

    break;
  default:
    //println("Error Win Control");
  }
}
int ledCol=4;
int loseControl =0;
int winControl = 0;
int playerControl =0;

// Kommunikation mit dem Arduino.
void serialEvent(Serial myPort) {

  String recv = myPort.readStringUntil('\n');
  println(recv);
  if (recv != null) {
    
    if (recv.trim().equals("_lose")) {
      loseControl =1;
    }
      if (recv.trim().equals("_win")) {
      winControl =1;
    }

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
void initPlayerMode(int Player) {
  switch(Player) {
  case 1:
  playerControl =5;
    myPort.write('s');
    break;
  case 2:
    myPort.write('s');
    break;
  case 3:
    myPort.write('s');
    break;
  case 4:
    myPort.write('s');
    break;
  default: 
    println("Error");
  }
}
void addScore() {
  PlayerScore[playerControl] = PlayerScore[playerControl] + 1;
  myPort.write('s');
}
void lose() {
  switch(playerControl) {
  case 1:
    playerControl = 2; 
    PlayerControl();
    ;
    break;
  case 2:
    playerControl = 3; 
    PlayerControl();
    break;
  case 3:
    playerControl = 4; 
    PlayerControl();
    break;
  case 4:
    playerControl = 1; 
    PlayerControl();
    break;
   case 5:
    println("Lose case 5 start new");
    myPort.write('s'); 
    break;
  default:
    println("Error PlayerControl");
  }
}
void PlayerControl() {
  switch(playerControl) {
  case 1:
    myPort.write('s'); 
    break;
  case 2:
    myPort.write('s'); 
    break;
  case 3:
    myPort.write('s');
    break;
  case 4:
    myPort.write('s'); 
    break;
  default:
    println("Error PlayerControl");
  }
}






// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}