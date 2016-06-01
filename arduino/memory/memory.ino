
#include "pitches.h"
#define levelsize 100
int level = 2;
int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};
/*****************
   LED Output
******************/
int LEDblue = 9;
int LEDred = 2;
int LEDgreen = 4;
int LEDyellow = 6;

/****************
   Tasten INPUT
****************/
int Tblue = 10;
int Tred = 3;
int Tgreen = 5;
int Tyellow = 8;

/**
   Speaker Output
*/
int speakerOut = 11;

/**
   Tonhöhe init.
*/
int TonHigh = 0;

/**
   Array und Random Number
*/
long randomNumber;
//int lightsToKlick[levelsize];
int * lightsToKlick = (int*) malloc(sizeof(int) * levelsize);
/*******************************
   Setup
 ******************************/
void setup() {
  // Set serial out if we want debugging
  Serial.begin(9600);

  //In und Output bestimmen
  pinMode(LEDblue, OUTPUT);
  pinMode(LEDred, OUTPUT);
  pinMode(LEDgreen, OUTPUT);
  pinMode(LEDyellow, OUTPUT);
  pinMode(Tblue, INPUT);
  pinMode(Tred, INPUT);
  pinMode(Tgreen, INPUT);
  pinMode(Tyellow, INPUT);
  pinMode(speakerOut, OUTPUT);



}


void loop() {
  if (Serial.available() > 0) {
    char gameStart = Serial.read();
    if (gameStart == 's') {
      Serial.println("Start new Game");
      startGameRnd();
    }

    if (gameStart == 'p') {

      startPvP();
    }
  }
}
/**
   In dieser Methode wird das Array lightsToKlick mit 10 zufälligen Werten befüllt
*/
void startPvP() {
  generateArrayProces();
}

/**
   Es wird in Processing dasArray gefüllt
*/
void generateArrayProces() {
  int i = 0;
  int actA = 0;
  while (i < level) {
    if (Serial.available() > 0) {
      char ledState = Serial.read();
      if (ledState == '0') {
        LED(LEDblue);
        lightsToKlick[i] = 0;
        Serial.println( lightsToKlick[i]);
        i++;
      }
      if (ledState == '1') {
        LED(LEDred);
        lightsToKlick[i] = 1;
        Serial.println( lightsToKlick[i]);
        i++;

      }

      if (ledState == '2') {
        LED(LEDgreen);
        lightsToKlick[i] = 2;
        Serial.println( lightsToKlick[i]);
        i++;

      }
      if (ledState == '3') {
        LED(LEDyellow);
        lightsToKlick[i] = 3;
        Serial.println( lightsToKlick[i]);
        i++;

      }
    }
  }
  userInputArduino();
}
/**
   Der Nutzer muss in Arduino die Eingabe tätigen
*/
void userInputArduino() {
  int Counter = 0;
  boolean lose = false;
  Serial.println("User Input Arduino");

  while (Counter < level) {
    if (digitalRead(Tblue) == HIGH) { // Blau wird überprüft
      TonHigh = 2093;
      //Serial.println("Blau wurde gedrückt.");
      LED(LEDblue);
      Serial.println("_blue");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 0)) {
        lose = true;
        LosePvPGame();

        break;
      }
      else
        Counter++;
    }
    if (digitalRead(Tred) == HIGH) { // Rot wird überprüft
      TonHigh = 175;
      //Serial.println("Rot wurde gedrückt");
      LED(LEDred);
      Serial.println("_red");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 1)) {
        lose = true;
        LosePvPGame();
        break;
      }
      else
        Counter++;
    }
    if (digitalRead(Tgreen) == HIGH) { // Grün wird überprüft
      TonHigh = 4978;
      //Serial.println("Grün wurde gedrückt");
      LED(LEDgreen);
      Serial.println("_green");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 2)) {
        lose = true;
        LosePvPGame();
        break;
      }
      else
        Counter++;
    }

    if (digitalRead(Tyellow) == HIGH) { //Gelb wird überprüft
      TonHigh = 3520;
      //Serial.println("Geld wurde Gedrückt");
      LED(LEDyellow);
      Serial.println("_yellow");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 3)) {
        lose = true;
        LosePvPGame();

        break;
      }
      else
        Counter++;
    }

  }
  if (!lose)
    WinPvPGame();
  generateArrayArduino();
}


/**
   An Arduino wird der Array mit Werten gefüllt
*/
void generateArrayArduino() {
  int i = 0;
  int actA = 0;
  while (i < level) {

    if (digitalRead(Tblue) == HIGH) {
      LED(LEDblue);
      Serial.println("_blue");
      lightsToKlick[i] = 0;
      // Serial.println( lightsToKlick[i]);
      i++;
    }
    if (digitalRead(Tred) == HIGH) {
      LED(LEDred);
      Serial.println("_red");
      lightsToKlick[i] = 1;
      // Serial.println( lightsToKlick[i]);
      i++;

    }

    if (digitalRead(Tgreen) == HIGH)  {
      LED(LEDgreen);
      Serial.println("_green");
      lightsToKlick[i] = 2;
      //Serial.println( lightsToKlick[i]);
      i++;

    }
    if (digitalRead(Tyellow) == HIGH) {
      LED(LEDyellow);
      Serial.println("_yellow");
      lightsToKlick[i] = 3;
      //   Serial.println( lightsToKlick[i]);
      i++;

    }

  }

  userInputProcess();
}
/**
   DEr Benutzer muss in Processing eine Eingabe tätigen
*/
void userInputProcess() {
  int Counter = 0;
  boolean lose = false;
  Serial.println("User Input Arduino");

  while (Counter < level) {
    if (Serial.available() > 0) {
      char ledState = Serial.read();
      if (ledState == '1') {
        LED(LEDred);
        if (checkForGameover(Counter, 1)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
      if (ledState == '0') {
        LED(LEDblue);
        if (checkForGameover(Counter, 0)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
      if (ledState == '2') {
        LED(LEDgreen);
        if (checkForGameover(Counter, 2)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
      if (ledState == '3') {
        LED(LEDyellow);
        if (checkForGameover(Counter, 3)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
    }
  }
  if (!lose)
    WinPvPGame();

  generateArrayProces();
}













void startGameRnd() {
  getRndNo();
}
void getRndNo() {
  Serial.println("Folgende Folge wurde generiert:");
  for (int i = 0; i < level; i++) {
    lightsToKlick[i] = random(0, 4);
    Serial.println(lightsToKlick[i]);
  }

  // Gehe im Programm weiter
  displayLights();
}

/**
   Zeige die ausgewählten LEDS an.
   Hierbei bitte bachten:
   Blau == 0;
   Rot == 1;
   Grün ==2;
   Gelb ==3;
   Keine der oben genannten => Error
*/
void displayLights() {
  for (int i = 0; i < level; i++) {
    switch (lightsToKlick[i]) {
      case 0:
        Serial.println("_blue");
        Serial.println("1");
        LED(LEDblue);
        break;
      case 1:
        Serial.println("_red");
        LED(LEDred);

        break;
      case 2:
        Serial.println("_green");
        LED(LEDgreen);

        break;
      case 3:

        Serial.println("_yellow");
        LED(LEDyellow);
        break;
      default:
        Serial.println("Error");
    }

  }
  //Weiter mit der Usereingabe
  userInput();
}

/**
   In dieser Methode muss der Nutzer eine Eingabe machen. Solange der Counter noch nicht
   alle 10 Farben gezählt hat wird auf die nächste Eingabe gewartet.
*/
void userInput() {
  // Counter auf 0 init.
  int Counter = 0;
  boolean lose = false;
  /**
     While Schleife solange noch Farben offen sind.
  */
  while (Counter < level) {
    if (Serial.available() > 0) {
      char ledState = Serial.read();
      if (ledState == '1') {
        LED(LEDred);
        if (checkForGameover(Counter, 1)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
      if (ledState == '0') {
        LED(LEDblue);
        if (checkForGameover(Counter, 0)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
      if (ledState == '2') {
        LED(LEDgreen);
        if (checkForGameover(Counter, 2)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
      if (ledState == '3') {
        LED(LEDyellow);
        if (checkForGameover(Counter, 3)) {
          LoseGame();
          lose = true;
          break;
        }
        else
          Counter++;
      }
    }


    if (digitalRead(Tblue) == HIGH) { // Blau wird überprüft
      TonHigh = 2093;
      //Serial.println("Blau wurde gedrückt.");
      LED(LEDblue);
      Serial.println("_blue");
      Serial.println("2");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 0)) {
        LoseGame();
        lose = true;
        break;
      }
      else
        Counter++;
    }
    if (digitalRead(Tred) == HIGH) { // Rot wird überprüft
      TonHigh = 175;
      //Serial.println("Rot wurde gedrückt");
      LED(LEDred);
      Serial.println("_red");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 1)) {
        LoseGame();
        lose = true;
        break;
      }
      else
        Counter++;
    }
    if (digitalRead(Tgreen) == HIGH) { // Grün wird überprüft
      TonHigh = 4978;
      //Serial.println("Grün wurde gedrückt");
      LED(LEDgreen);
      Serial.println("_green");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 2)) {
        LoseGame();
        lose = true;
        break;
      }
      else
        Counter++;
    }

    if (digitalRead(Tyellow) == HIGH) { //Gelb wird überprüft
      TonHigh = 3520;
      //Serial.println("Geld wurde Gedrückt");
      LED(LEDyellow);
      Serial.println("_yellow");
      //Ruft Methode auf um die richtigkeit zu überprüfen.
      if (checkForGameover(Counter, 3)) {
        LoseGame();
        lose = true;
        break;
      }
      else
        Counter++;
    }

  }
  if (!lose)
    WinGame();

}
/**
   Überprüft ob das Spiel vorbei ist
   @aktIndex int der aktuelle Index ( Counter)
   @LED int die gedrückte LED taste
    return false => richtig
    return true => GameOver
*/
bool winGame(int aktIndex) {
  if (sizeof(lightsToKlick) > aktIndex) {
    Serial.println("Win");
    return true;
  }
  return false;
}
bool checkForGameover(int aktIndex, int LED) {
  if (lightsToKlick[aktIndex] != LED)
    return true;

  return false;
}


/**
   Diese Methode lässt eine LED aufleuchten mit einem Ton und  erlöscht diese wieder aufgrund der Übergebenen ID
*/
void LED(int LedId) {

  //Serial.println("LED mit der ID leuchtet");
  //Serial.println(LedId);
  digitalWrite(LedId, HIGH);
  tone(speakerOut, TonHigh);
  delay(100);
  noTone(speakerOut);
  delay(1000);
  digitalWrite(LedId, LOW);
}

/**
   Diese Methode wird im Falle einer Niederlage ausgeführt
*/
void LoseGame() {

  PlaySoundDaDa();

  Serial.println("_lose");

  // break;
}

void LosePvPGame() {

  PlaySoundDaDa();
  level = 2;
  Serial.println("_losePvP");

  // break;
}
/**


  /**
   Diese Methode wird im Falle des Gewinns ausgeüfhrt
*/
void WinGame() {


  PlayWinSound();
  Serial.println("_win");
}

void WinPvPGame() {
  level += 1;
  PlayWinSound();
  Serial.println("_winPvP");
}


void PlayWinSound() {

  for (int i = 0; i < 3; i++) {
    digitalWrite(LEDred, HIGH);
    digitalWrite(LEDgreen , LOW);
    digitalWrite(LEDyellow, LOW);
    digitalWrite(LEDblue, HIGH);
    tone(speakerOut, 100);
    delay(100);
    noTone(speakerOut);
    tone(speakerOut, 500);
    delay(100);
    noTone(speakerOut);
    delay(100);
    digitalWrite(LEDred, LOW);
    digitalWrite(LEDgreen , HIGH);
    digitalWrite(LEDyellow, HIGH);
    digitalWrite(LEDblue, LOW);
    delay(300);
  }
  digitalWrite(LEDgreen , LOW);
  digitalWrite(LEDyellow, LOW);
}
void PlaySoundDaDa() {

  for (int thisNote = 0; thisNote < 8; thisNote++) {

    if (0 == thisNote % 2) {
      digitalWrite(LEDblue, LOW);
      digitalWrite(LEDred, HIGH);
    }
    else  {
      digitalWrite(LEDblue, HIGH);
      digitalWrite(LEDred, LOW);

    }
    // to calculate the note duration, take one second
    // divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1000 / noteDurations[thisNote];
    tone(speakerOut, melody[thisNote], noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(speakerOut);

  }
  digitalWrite(LEDred, LOW);
  digitalWrite(LEDblue, LOW);
}
