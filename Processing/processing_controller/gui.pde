/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.
 
 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
 // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */
// Bei Button Klick schreibe dem Arduino über myPort 'dieInfo' und zeichne dementsprechend die LED und resete die anderen 
public void b_blue_click(GButton source, GEvent event) { //_CODE_:b_blue:614671:
  println("b_blue - GButton >> GEvent." + event + " @ " + millis());
  myPort.write('0');
  ledCol =5;
  ledBlue.zeichnen();
  ledYellow.reset();
  ledGreen.reset();
  ledRed.reset();
} //_CODE_:b_blue:614671:

public void b_red_click(GButton source, GEvent event) { //_CODE_:b_red:564421:
  println("b_red - GButton >> GEvent." + event + " @ " + millis());
  myPort.write('1');
  ledCol =5;
  ledBlue.reset();
  ledYellow.reset();
  ledGreen.reset();
  ledRed.zeichnen();
} //_CODE_:b_red:564421:

public void button3_click1(GButton source, GEvent event) { //_CODE_:b_green:399496:
  println("b_green - GButton >> GEvent." + event + " @ " + millis());
  myPort.write('2');
  ledCol =5;
  ledGreen.zeichnen();
  ledBlue.reset();
  ledYellow.reset();
  ledRed.reset();
} //_CODE_:b_green:399496:

public void b_yellow_click(GButton source, GEvent event) { //_CODE_:b_yellow:964908:
  println("b_yellow - GButton >> GEvent." + event + " @ " + millis());
  myPort.write('3');
  ledBlue.reset();
  ledGreen.reset();
  ledRed.reset();
  ledCol =5;
  ledYellow.zeichnen();
} //_CODE_:b_yellow:964908:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  b_blue = new GButton(this, 300, 65, 80, 30);
  b_blue.setText("Blue LED");
  b_blue.addEventHandler(this, "b_blue_click");
  b_red = new GButton(this, 300, 99, 80, 30);
  b_red.setText("Red LED");
  b_red.setLocalColorScheme(GCScheme.RED_SCHEME);
  b_red.addEventHandler(this, "b_red_click");
  b_green = new GButton(this, 300, 135, 80, 30);
  b_green.setText("Green LED");
  b_green.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  b_green.addEventHandler(this, "button3_click1");
  b_yellow = new GButton(this, 300, 170, 80, 30);
  b_yellow.setText("Yellow LED");
  b_yellow.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  b_yellow.addEventHandler(this, "b_yellow_click");
}

// Variable declarations 
// autogenerated do not edit
GButton b_blue; 
GButton b_red; 
GButton b_green; 
GButton b_yellow; 