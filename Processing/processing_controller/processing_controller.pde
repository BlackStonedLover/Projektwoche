


// Need G4P library
import g4p_controls.*;
int led;
class Led {
  int x;
  int y = 50;
  int Radius = 50;

  Led( int x) {
    this.x = x;
  }

  void zeichnen() {
    ellipse(x, y, Radius, Radius);
  }
}


Led ledBlue = new Led(50);
Led ledYellow = new Led (150);
Led ledGreen = new Led (250);
Led ledRed = new Led (350);

public void setup(){
  size(480, 320, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
}

public void draw(){
  background(0);
  stroke(255);
  fill(255);
  ledBlue.zeichnen();
  ledYellow.zeichnen();
  ledGreen.zeichnen();
  ledRed.zeichnen();
  
}


void sendButton (int LedID){
led = LedID;
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}