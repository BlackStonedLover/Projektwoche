// Variablen deffinition LED 4 Farben + Taster 4x
int LEDblue= 9;
int LEDred=2;
int LEDgreen=4;
int LEDyellow=6;
int Tblue=10;
int Tred=3;
int Tgreen=5;
int Tyellow=8;
int Ton = 1;
int TonHigh=0;
void setup() {
  // put your setup code here, to run once:
  pinMode(LEDblue,OUTPUT);
  pinMode(LEDred, OUTPUT);
  pinMode(LEDgreen, OUTPUT);
  pinMode(LEDyellow, OUTPUT);
  pinMode(Tblue,INPUT);
  pinMode(Tred,INPUT);
  pinMode(Tgreen,INPUT);
  pinMode(Tyellow,INPUT);
  pinMode(Ton, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
testTaster();
    
}
void testTaster(){
    if(digitalRead(Tblue) == HIGH){
      TonHigh = 2093;
      LED(LEDblue);
    }
    else if (digitalRead(Tred)==HIGH){
      TonHigh = 175;
      LED(LEDred);
      }
      else if(digitalRead(Tgreen)==HIGH){
        TonHigh = 4978;
          LED(LEDgreen);
        }
        else if(digitalRead(Tyellow)==HIGH){
          TonHigh = 3520;
          LED(LEDyellow);
          }
  }

void LED(int LedId){
  digitalWrite(LedId,HIGH);
  tone(Ton,TonHigh);
  delay(500);
  noTone(Ton);
  delay(2000);
  digitalWrite(LedId,LOW);
  }
