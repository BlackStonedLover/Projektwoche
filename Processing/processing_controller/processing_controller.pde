// Need G4P library
import g4p_controls.*;
int led;

public void setup(){
  size(480, 320, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
}

public void draw(){
  background(230);
  
}


void sendButton (int LedID){
led = LedID;
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}