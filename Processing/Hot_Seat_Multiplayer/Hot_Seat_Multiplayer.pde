import java.util.*;

int anzSpieler;
Scanner sc = new Scanner(System.in);




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

void setup() {
  size(400, 500);
  frameRate(4);
}

void draw() {
  background(0);
  stroke(255);
  fill(255);
  ledBlue.zeichnen();
  ledYellow.zeichnen();
  ledGreen.zeichnen();
  ledRed.zeichnen();
  textSize(30);
  text("Anzahl der Spieler", 25, 125);
  rect(25, 150, 50, 50);
  rect(100, 150, 50, 50);
  rect(175, 150, 50, 50);
  rect(250, 150, 50, 50);
  rect(325, 150, 50, 50);
  fill(0);
  textSize(60);
  text("1", 30, 200);
  text("2", 105, 200);
  text("3", 180, 200);
  text("4", 255, 200);
  text("5", 330, 200);
}

void mousePressed() {
  int a;
  int [] anzSpieler;
  int yMouse = 25;

  if ( pmouseX > 25 && pmouseX < 75 && pmouseY >yMouse && pmouseY< yMouse + 50) {
    fill(0, 0, 255);
    ledBlue.zeichnen();
  }

  if ( pmouseX > 125 && pmouseX < 175 && pmouseY >yMouse && pmouseY< yMouse + 50) {

    fill(255, 255, 0);
    ledYellow.zeichnen();
  } 

  if ( pmouseX > 225 && pmouseX < 275 && pmouseY >yMouse && pmouseY< yMouse + 50) {

    fill(0, 255, 0);
    ledGreen.zeichnen();
  }
  if ( pmouseX > 325 && pmouseX < 375 && pmouseY >yMouse && pmouseY< yMouse + 50) {

    fill(255, 0, 0);
    ledRed.zeichnen();
  }

  if ( pmouseX > 25 && pmouseX < 75 && pmouseY > 150 && pmouseY < 200) {

    anzSpieler = new int [1];
    println(anzSpieler);
  }

  if ( pmouseX > 100 && pmouseX < 150 && pmouseY > 150 && pmouseY < 200) {

    anzSpieler = new int [2];
    println(anzSpieler);
  }

  if ( pmouseX > 175 && pmouseX < 225 && pmouseY > 150 && pmouseY < 200) {
    anzSpieler = new int [3];
    println(anzSpieler);
  }

  if ( pmouseX > 250 && pmouseX < 300 && pmouseY > 150 && pmouseY < 200) {

    anzSpieler = new int [4];
    println(anzSpieler);
  }

  if ( pmouseX > 325 && pmouseX < 375 && pmouseY > 150 && pmouseY < 200) {

    anzSpieler = new int [5];
    println(anzSpieler);
  }



  /*
   fill(0,255,0);
   ledGreen.zeichnen();
   fill(255,0,0);
   ledRed.zeichnen();
   */
}