#include <Wire.h>
#include <SPI.h>
#include <Adafruit_CAP1188.h>
#include <Adafruit_NeoPixel.h>


// Reset Pin is used for I2C or SPI
#define CAP1188_RESET  4

// CS pin is used for software or hardware SPI
#define CAP1188_CS  5

// These are defined for software SPI, for hardware SPI, check your 
// board's SPI pins in the Arduino documentation
#define CAP1188_MOSI  11
#define CAP1188_MISO  12
#define CAP1188_CLK  13

#define PIN1            6
#define PIN2           9
#define NUMPIXELS      19

Adafruit_CAP1188 cap = Adafruit_CAP1188();
Adafruit_NeoPixel SteerPixels = Adafruit_NeoPixel(NUMPIXELS, PIN1, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel DashPixels = Adafruit_NeoPixel(NUMPIXELS, PIN2, NEO_GRB + NEO_KHZ800);

int capArray[8] = {0,0,0,0,0,0,0,0};;
String output;
String inputString ="";
String input = "";
float inputLocation = 0.0;
float nettoLocation = 0.0;
boolean stringComplete = false;

int brightBlue[(NUMPIXELS * 2)];
int brightRed[(NUMPIXELS * 2)];

int blueTarget = 0;
int redTarget = 0;

int blueNetto = 0;
int redNetto = 0;

String systemInput;


void setup() {
  Serial.begin(9600);
  init_cap();
  SteerPixels.begin(); // This initializes the NeoPixel library.
  DashPixels.begin(); // This initializes the NeoPixel library.
  inputString.reserve(200);

}

void loop() {
output = "";

//---------------------------
if (stringComplete) {
     systemInput = inputString;
     char firstChar = inputString[0];
     char checkChar = 'i';
     String red, blue;
     
     if (firstChar == checkChar){ 
      int endchar1 = inputString.indexOf('b');
      int endchar2 = inputString.indexOf('r');
      int endchar3 = inputString.indexOf('e');
      input = inputString.substring(1,endchar1); 
      blue = inputString.substring(endchar1 + 1, endchar2);
      red = inputString.substring(endchar2+1, endchar3);
      inputLocation = input.toFloat();
      blueTarget = blue.toInt();
      redTarget = red.toInt();
     }
     inputString = "";
     stringComplete = false;
}


//---------------------------
run_cap();
communication();
colorSmoother();
locationSmoother();
         float ledlocation = nettoLocation/1.9;
         for(int i=0;i<(NUMPIXELS*2);i++){
               float pixellocation = i * 10;
               float brightb = blueNetto - abs(ledlocation - pixellocation+1)*4;
               float brightr = redNetto - abs(ledlocation - pixellocation+1)*4;
               if(brightb < 0){ brightb = 0;} 
               if(brightr < 0){ brightr = 0;} 
               brightBlue[i]= brightb;
               brightRed[i]= brightr;
         }

         for(int i = 0; i<NUMPIXELS; i++){
            SteerPixels.setPixelColor(i, SteerPixels.Color(brightRed[i],brightBlue[i]/2,brightBlue[i])); // Moderately bright green color.
         }

         for(int i = 0; i <NUMPIXELS; i++){
            DashPixels.setPixelColor(i,SteerPixels.Color(brightRed[i+ NUMPIXELS],brightBlue[i+ NUMPIXELS]/2,brightBlue[i+ NUMPIXELS])); // Moderately bright green color.
         }



       
SteerPixels.show(); 
DashPixels.show(); 
}

void serialEvent() {
   while (Serial.available()) {
     // get the new byte:
     char inChar = (char)Serial.read();
     // add it to the inputString:
     inputString += inChar;
     // if the incoming character is a newline, set a flag
     // so the main loop can do something about it:
     if (inChar == 'e') {
       stringComplete = true;
       //Serial.flush();
     }
   }
}

void colorSmoother(){
  if(blueTarget > blueNetto){blueNetto+=2;}
  if(blueTarget < blueNetto){blueNetto-=2;}
  if(redTarget > redNetto){redNetto+=2;}
  if(redTarget < redNetto){redNetto-=2;}
  }

void locationSmoother(){
  if(inputLocation > nettoLocation){
    nettoLocation += ((inputLocation-nettoLocation)/10);
    }
    if(inputLocation < nettoLocation){
    nettoLocation -= ((nettoLocation-inputLocation)/10);
    }
  
  }





