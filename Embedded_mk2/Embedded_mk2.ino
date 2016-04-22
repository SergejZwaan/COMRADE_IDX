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
float inputLocation;
boolean stringComplete = false;


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
     
     char firstChar = inputString[0];
     char checkChar = 'i';
     if (firstChar == checkChar){ 
      int endchar = inputString.indexOf('e');
      input = inputString.substring(1,endchar); 
      inputLocation = input.toFloat();
     }
     inputString = "";
     stringComplete = false;
}


//---------------------------
run_cap();
communication();
         float ledlocation = inputLocation/1.8;
         for(int i=0;i<NUMPIXELS;i++){
         float pixellocation = i * 10;
         float bright = 255 - abs(ledlocation - pixellocation+1)*4;
         if(bright < 0){ bright = 0;} 
          
          SteerPixels.setPixelColor(i, SteerPixels.Color(0,bright/2,bright)); // Moderately bright green color.
          DashPixels.setPixelColor(i, SteerPixels.Color(0,255/2,255)); // Moderately bright green color.
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
     }
   }
}





