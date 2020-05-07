/*
  SensorsToSerial
  by Scott Kildall

  Designed for ESP32 but will also work for Arudino
  Sends data to Processing
  * 0 or 1 for button pressed
  * 0-4095 for potentiometer (ESP32 has 10-bit analog input)
  * data for LDR (not yet implemented)
  
  Also illustrates use of the Serial Monitor
  
  We use the built-in LED, but you can hook an external LED with
  a 250 Ohm (or thereabouts) resistor.  
 */


int ledPin = 15;
int buttonPin = 12;
int potInputPin = A2;
int ldrInputPin = A1;

//-- analog values, track for formatting to serial
int switchValue = 0;
int potValue = 0;
int ldrValue = 0;

//-- time between LED flashes, for startup
const int ledFlashDelay = 150;

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize pins and input and output
  pinMode(ledPin, OUTPUT);    
  
  pinMode(buttonPin, INPUT);
  pinMode(potInputPin, INPUT);    // technically not needed, but good form
  pinMode(ldrInputPin,INPUT);
  
  Serial.begin(115200);
 // Serial.println( "ButtonLED: Starting" ); 

}

// the loop function runs over and over again forever
void loop() {
  // gets switch Value AND changed LED
//  getSwitchValue();
  getPotValue();
  getLDRValue();
  sendSerialData();
 
  // delay so as to not overload serial buffer
  delay(100);

  
  if(Serial.available()){ //id data available
  
    int val = Serial.read();
    
    if(val == 1){ //if 1 received
      digitalWrite(ledPin, HIGH); //turn on
    }
    if(val == 2){ //if 2 received
      digitalWrite(ledPin, LOW); //turn off
    }
  
  }
}



//-- look at the momentary switch (button) and show on/off
//-- display in the serial monitor a well
//void getSwitchValue() {
//  switchValue = digitalRead(buttonPin);
//  
//}

void getPotValue() {
  potValue = analogRead(potInputPin); 
}

void getLDRValue() {
  ldrValue = analogRead(ldrInputPin); 
}


//-- this could be done as a formatted string, using Serial.printf(), but
//-- we are doing it in a simpler way for the purposes of teaching
void sendSerialData() {
  // Add switch on or off
//  if( switchValue ) {
//    Serial.print(1);
//  }
//  else {
//    Serial.print(0);
//  }

   Serial.print(",");
   Serial.print(potValue);

   Serial.print(",");
   Serial.print(ldrValue);
   
  // end with newline
  Serial.println();
}
