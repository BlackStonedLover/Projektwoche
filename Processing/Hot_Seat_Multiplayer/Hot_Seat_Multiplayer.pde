
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
Led ledYellow = new Led (150, 255, 255, 0);
Led ledGreen = new Led (250, 0, 255, 0);
Led ledRed = new Led (350, 255, 0, 0);

void setup() {
  size(400, 500);
  frameRate(4);
}

void draw() {
  background(0);
  stroke(255);
  fill(255);
  ledBlue.reset();
  ledYellow.reset();
  ledGreen.reset();
  ledRed.reset();
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

int a;
int [] anzSpieler = new int [a];
int aktPlayer;

void mousePressed() {

  int yMouse = 25;

  if ( pmouseX > 25 && pmouseX < 75 && pmouseY >yMouse && pmouseY< yMouse + 50) {

    ledBlue.zeichnen();
  }

  if ( pmouseX > 125 && pmouseX < 175 && pmouseY >yMouse && pmouseY< yMouse + 50) {

    ledYellow.zeichnen();
  } 

  if ( pmouseX > 225 && pmouseX < 275 && pmouseY >yMouse && pmouseY< yMouse + 50) {


    ledGreen.zeichnen();
  }
  if ( pmouseX > 325 && pmouseX < 375 && pmouseY >yMouse && pmouseY< yMouse + 50) {


    ledRed.zeichnen();
  }

  if ( pmouseX > 25 && pmouseX < 75 && pmouseY > 150 && pmouseY < 200) {
    a = 1;
    anzSpieler = new int [a];
    println(anzSpieler);
  }

  if ( pmouseX > 100 && pmouseX < 150 && pmouseY > 150 && pmouseY < 200) {
    a = 2;
      anzSpieler = new int [a];
    println(anzSpieler);
  }

  if ( pmouseX > 175 && pmouseX < 225 && pmouseY > 150 && pmouseY < 200) {
    a = 3;
    anzSpieler = new int [a];
    println(anzSpieler);
  }

  if ( pmouseX > 250 && pmouseX < 300 && pmouseY > 150 && pmouseY < 200) {
    a=4;
    anzSpieler = new int [a];
    println(anzSpieler);
  }

  if ( pmouseX > 325 && pmouseX < 375 && pmouseY > 150 && pmouseY < 200) {
    a = 5;
    anzSpieler = new int [a];
    println(anzSpieler);
  }
}

void lostGame ( boolean lost) {
  if (lost) {
    for (int i = 0; i <= anzSpieler.length; i++)
    aktPlayer = anzSpieler[i];
  }
}


void getLed(int ledId) {

  switch(ledId) {
  case 0: 
    ledBlue.zeichnen();
    break;
  case 1: 
    ledYellow.zeichnen();
    break;
  case 2: 
    ledGreen.zeichnen();
    break;
  case 3: 
    ledRed.zeichnen();
    break;
  default: 
    println("Error: 1337!");
  }
}
long randomNumber;
int [] lightsToKlick = new int [10];


  void getRndNo(){
   println("Folgende Folge wurde generiert:");
   for (int i = 0; i < 10; i++){
     lightsToKlick[i] = int(random(3));
     
   }
  }



/*
   fill(0,255,0);
 ledGreen.zeichnen();
 fill(255,0,0);
 ledRed.zeichnen();
 */