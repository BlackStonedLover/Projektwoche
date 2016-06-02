/**
 * Der Processing Teil, gewinnt kein Schönheitspreis, aber erfüllt seine Aufgabe
 */

// Need G4P library bitte impotieren falls nicht vorhanden.
import g4p_controls.*;
import processing.serial.*;
Serial myPort;



/** Klasse erstellt um LED´s mit bestimmter Farbe zu zeichnen. 
 * und schnellerern Zugriff auf die einzelnen Kreise zu bekommen.
 *  Zwei Klassen eine um den Kreis zu füllen : zecihnen()
 * und eine um ihn wieder weiß zu machen
 */
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

// Variablen für den switch der Methoden 
int ledCol=4;
int loseControl =0;
int winControl = 0;
int playerControl =0;

//Anlegen eines Arrays in dem die Punkt gespeichert werden können für die Anzahl der gewonnenen Spiele
int[] PlayerScore = new int[6];


int led;

//booleans für die Spieleranzahö
boolean twoplayer = false;
boolean threeplayer = false;



// Anlegen der neuen LED´s 
Led ledBlue = new Led(50, 0, 0, 255);
Led ledYellow = new Led (110, 255, 255, 0);
Led ledGreen = new Led (170, 0, 255, 0);
Led ledRed = new Led (240, 255, 0, 0);


/**
* Alle Relevanten dinge werden hier festgelegt
*/
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

/**
* Hier wird der von Arduino gesendete Farbcode gezeichnet.
*/
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
  
  /**
  * Hier wird die Methode aufgerufen wenn ein Spieler verloren hat, da in der Methode serialEvent keine Methoden aufgerufen werden können nur 
  * Werte verändert werden können. ( War bei unseren Tests zumindest so der Fall)
  *
  */
  switch(loseControl) {
  case 1:
    loseControl =0;
    lose();
    break;
  default:
    //println("Error Lose Control");
  }
  /**
  * Das gleiche wie bei loseControl
  */
  switch(winControl) {
  case 1:
    winControl =0;
    addScore();

    break;
  default:
    //println("Error Win Control");
  }
}


/**
* Diese Methode dient dazu den Score zu zeichnen.
*/
void drawScore() {
  background(255);
  println(playerControl);
  label1.setText("Player 1: " + PlayerScore[0]);
  label2.setText("Player 2 : " + PlayerScore[1]);
  label3.setText("Player 3 : " + PlayerScore[2]);
  label4.setText("Player 4 : " + PlayerScore[3]);
}


/**
*Kommunikation mit dem Arduino.
*/
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
    // println("String recived");
  }
}


/**
* Nach drücken eines Button werden hier die Weichen gesetzt um den Programmcode so 
* einzustellen, das er funktioniert.
*
*/

void initPlayerMode(int Player) {
  switch(Player) {
  case 1:
    playerControl =5;      // Einzelspieler wird ausgewählt
    myPort.write('s');    // starten des Spieles
    break;
  case 2:
    twoplayer = true;      // Zwei spieler werden ausgewählt.
    myPort.write('s');
    break;
  case 3:
    threeplayer = true;
    myPort.write('s');
    break;
  case 4:
    myPort.write('s');
    break;
  default: 
    println("Error");    // Sollte niemals eintreffen.
  }
}

void initPvP() {
  myPort.write('p');
}









/**
* Im Falle eines Sieges bekommt der Spieler der aktuell an der Reihe ist einen Punkt und die nächste Runde wird gestartet.
*/

void addScore() {
  PlayerScore[playerControl] = PlayerScore[playerControl] + 1;
  drawScore();
  myPort.write('s');
}


/**
 *      Wenn ein Spieler verloren hat soll der nächste an der Reihe sein.
 *      Hier wird eingestellt das der nächste Spieler an der reihe ist und
 *      es wird der PlayerControler aufgerufen mit PlayerControl() um das nächste
 *      Spiel zu starten
 *
 */

void lose() {
  println("Ich bin in der Lose methode");
  switch(playerControl) {
  case 0:
    playerControl = 1; 
    println( "Player Control" +playerControl);
    PlayerControl();
    break;
  case 1:
    if (twoplayer)
      playerControl =0;
    else
      playerControl = 2; 
    PlayerControl();
    break;
  case 2:
    if (threeplayer)
      playerControl=0;
    else
      playerControl = 3; 
    PlayerControl();
    break;
  case 3:

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

/**
 * Überprüft welcher Spieler als nächstes an der Reihe ist und starten in Arduino das Programm mit ('s') => Startet den Random Teil 
 */
void PlayerControl() {
  switch(playerControl) {
  case 0:
    myPort.write('s');
    break;
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