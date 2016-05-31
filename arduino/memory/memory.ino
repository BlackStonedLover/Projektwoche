
 #include "pitches.h"

int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};
/**
 * LED Output
 */
int LEDblue= 9;
int LEDred=2;
int LEDgreen=4;
int LEDyellow=6;

/**
 * Tasten INPUT
 */
int Tblue=10;
int Tred=3;
int Tgreen=5;
int Tyellow=8;

/**
 * Speaker Output
 */
int speakerOut = 1;

/**
 * Tonhöhe init.
 */ 
int TonHigh=0;

/**
 * Array und Random Number
 */
long randomNumber;
int lightsToKlick[10];


void setup() {
  // Set serial out if we want debugging
  Serial.begin(9600);

  //In und Output bestimmen
  pinMode(LEDblue,OUTPUT);
  pinMode(LEDred, OUTPUT);
  pinMode(LEDgreen, OUTPUT);
  pinMode(LEDyellow, OUTPUT);
  pinMode(Tblue,INPUT);
  pinMode(Tred,INPUT);
  pinMode(Tgreen,INPUT);
  pinMode(Tyellow,INPUT);
  pinMode(speakerOut, OUTPUT);
}

void loop() {

// Das Programm starten
getRndNo();
    
}


/**
 * In dieser Methode wird das Array lightsToKlick mit 10 zufälligen Werten befüllt
 */
void getRndNo(){
  Serial.println("Folgende Folge wurde generiert:");
  for(int i =0; i<10;i++){
    lightsToKlick[i] = random(3);
          Serial.println(lightsToKlick[i]);
    }

    // Gehe im Programm weiter
    displayLights();
  }

/**
 * Zeige die ausgewählten LEDS an.
 * Hierbei bitte bachten:
 * Blau == 0;
 * Rot == 1;
 * Grün ==2;
 * Gelb ==3;
 * Keine der oben genannten => Error
 */
void displayLights(){
  for(int i =0; i < 10; i++){
    switch(lightsToKlick[i]){
        case 0:
        LED(LEDblue);
        break;
        case 1:
        LED(LEDred);
        break;
        case 2:
        LED(LEDgreen);
        break;
        case 3:
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
   * In dieser Methode muss der Nutzer eine Eingabe machen. Solange der Counter noch nicht 
   * alle 10 Farben gezählt hat wird auf die nächste Eingabe gewartet.
   */
  void userInput(){
    // Counter auf 0 init.
    int Counter=0;

    /**
     * While Schleife solange noch Farben offen sind.
     */
        while(Counter <10){
          
                    if(digitalRead(Tblue) == HIGH){ // Blau wird überprüft
                          TonHigh = 2093;
                          Serial.println("Blau wurde gedrückt.");
                          LED(LEDblue);
                              //Ruft Methode auf um die richtigkeit zu überprüfen.
                              if(checkForGameover(Counter,0)){
                                  LoseGame();
                               }
                           Counter++;
                       }
                      if (digitalRead(Tred)==HIGH){ // Rot wird überprüft
                          TonHigh = 175;
                          Serial.println("Rot wurde gedrückt");
                          LED(LEDred);
                              //Ruft Methode auf um die richtigkeit zu überprüfen.
                              if(checkForGameover(Counter,1)){
                                  LoseGame();                    
                                }
                          Counter++;
                        }
                       if(digitalRead(Tgreen)==HIGH){ // Grün wird überprüft
                          TonHigh = 4978;
                          Serial.println("Grün wurde gedrückt");
                            LED(LEDgreen);
                                  //Ruft Methode auf um die richtigkeit zu überprüfen.
                                  if(checkForGameover(Counter,2)){
                                      LoseGame();
                                      }
                            Counter++;
                        }
                  
                       if(digitalRead(Tyellow)==HIGH){ //Gelb wird überprüft
                          TonHigh = 3520;
                          Serial.println("Geld wurde Gedrückt");
                          LED(LEDyellow);
                                //Ruft Methode auf um die richtigkeit zu überprüfen.
                                if(checkForGameover(Counter,3)){
                                    LoseGame();
                                  }
                           Counter++;
                        }
              }
      WinGame();
      
    }
    /**
     * Überprüft ob das Spiel vorbei ist
     * @aktIndex int der aktuelle Index ( Counter)
     * @LED int die gedrückte LED taste
     *  return false => richtig
     *  return true => GameOver
     */
    bool checkForGameover(int aktIndex, int LED){
      if(lightsToKlick[aktIndex] != LED)
      return true;

      return false;
      }

/**
 * Diese Methode lässt eine LED aufleuchten mit einem Ton und  erlöscht diese wieder aufgrund der Übergebenen ID
 */
void LED(int LedId){
  Serial.println("LED mit der ID leuchtet");
    Serial.println(LedId);
  digitalWrite(LedId,HIGH);
  tone(speakerOut,TonHigh);
  delay(100);
  noTone(speakerOut);
  delay(1000);
  digitalWrite(LedId,LOW);
  }

/**
 * Diese Methode wird im Falle einer Niederlage ausgeführt
 */
void LoseGame(){
    Serial.println("Lose Game");
        for(int i =0; i <30; i++){
            digitalWrite(LEDred,HIGH);
            delay(1000);
            digitalWrite(LEDred,LOW);
            delay(1000);
        }
        PlaySoundDaDa();
       // break;
  }
  /**
   * Diese Methode wird im Falle des Gewinns ausgeüfhrt
   */
  void WinGame(){
      Serial.println("Win Game");
   
    for(int i =0; i <30; i++){
       digitalWrite(LEDred,HIGH);
       digitalWrite(LEDgreen ,LOW);
       digitalWrite(LEDyellow,LOW);
       digitalWrite(LEDblue,HIGH);
       tone(speakerOut,100);
           delay(100);
       noTone(speakerOut);
       tone(speakerOut,500);
           delay(100);
       noTone(speakerOut);
           delay(100);
       digitalWrite(LEDred,LOW);
       digitalWrite(LEDgreen ,HIGH);
       digitalWrite(LEDyellow,HIGH);
       digitalWrite(LEDblue,LOW);
            delay(300);
      }
    }


        void PlaySoundDaDa(){
        for (int thisNote = 0; thisNote < 8; thisNote++) {

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
      }
