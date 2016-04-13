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

#define PIN            6
#define NUMPIXELS      19

Adafruit_CAP1188 cap = Adafruit_CAP1188();
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

int capArray[8] = {0,0,0,0,0,0,0,0};;
String output;
String inputString ="";
String input;
boolean stringComplete = false;


void setup() {
  Serial.begin(9600);
  init_cap();
  pixels.begin(); // This initializes the NeoPixel library.
  inputString.reserve(200);

}

void loop() {
output = "";

//---------------------------
if (stringComplete) {
     //Serial.println(inputString);
     // clear the string:
     input = inputString;
     inputString = "";
     stringComplete = false;
   }


//---------------------------
run_cap();
communication();

         for(int i=0;i<NUMPIXELS;i++){
          pixels.setPixelColor(i, pixels.Color(0,0,0)); // Moderately bright green color.
         }

       
pixels.show(); 

}

void serialEvent() {
   while (Serial.available()) {
     // get the new byte:
     char inChar = (char)Serial.read();
     // add it to the inputString:
     inputString += inChar;
     // if the incoming character is a newline, set a flag
     // so the main loop can do something about it:
     if (inChar == '\n') {
       stringComplete = true;
     }
   }
}





