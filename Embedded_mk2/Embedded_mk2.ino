#include <Wire.h>
#include <SPI.h>
#include <Adafruit_CAP1188.h>

// Reset Pin is used for I2C or SPI
#define CAP1188_RESET  4

// CS pin is used for software or hardware SPI
#define CAP1188_CS  5

// These are defined for software SPI, for hardware SPI, check your 
// board's SPI pins in the Arduino documentation
#define CAP1188_MOSI  11
#define CAP1188_MISO  12
#define CAP1188_CLK  13

Adafruit_CAP1188 cap = Adafruit_CAP1188();

int capArray[8] = {0,0,0,0,0,0,0,0};;
String output;

void setup() {
  Serial.begin(9600);
  init_cap();

}

void loop() {
output = "";
run_cap();
communication();



}





