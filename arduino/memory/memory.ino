

/*
Arrays:
int * bezeichner = (int*)malloc(sizeof(int)*groesse);


*/
// Variablen deffinition LED 4 Farben + Taster 4x
int LEDblue= 9;
int LEDred=2;
int LEDgreen=4;
int LEDyellow=6;
int Tblue=10;
int Tred=3;
int Tgreen=5;
int Tyellow=8;
int speakerOut = 1;
int TonHigh=0;
bool WinMelody = true;
void setup() {
  Serial.begin(9600);
   // Serial.begin(9600); // Set serial out if we want debugging
  // put your setup code here, to run once:
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
  // put your main code here, to run repeatedly:
  //LoseGame();
//WinGame();
testTaster();
    
}
void testTaster(){
    if(digitalRead(Tblue) == HIGH){
      TonHigh = 2093;
      Serial.println("blue");
      LED(LEDblue);
    }
      if (digitalRead(Tred)==HIGH){
      TonHigh = 175;
      Serial.println("red");
      LED(LEDred);
      }
       if(digitalRead(Tgreen)==HIGH){
        TonHigh = 4978;
        Serial.println("green");
          LED(LEDgreen);
        }
         if(digitalRead(Tyellow)==HIGH){
          TonHigh = 3520;
          Serial.println("yellow");
          LED(LEDyellow);
          
          }
  }

void LED(int LedId){
  digitalWrite(LedId,HIGH);
  tone(speakerOut,TonHigh);
  delay(100);
  noTone(speakerOut);
  delay(1000);
  digitalWrite(LedId,LOW);
  }

void LoseGame(){
  digitalWrite(LEDred,HIGH);
  delay(1000);
  digitalWrite(LEDred,LOW);
  delay(1000);
  }
  void WinGame(){
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
