// Importing the serial library to communicate with the Arduino 
import processing.serial.*;    
import controlP5.*; //library

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;   

PImage bg, c3, r2;
PImage img1, img2, img3, img4, img5;
PImage r1img, r2img, r3img, r4img, r5img;
int y;

PFont displayFont;

int minPotValue = 0;
int maxPotValue = 4095; 

String [] data;

int switchValue = 1;
int potValue = 0;
int lastSwitchValue = 0;
boolean buttonBool = false;

// Change to appropriate index in the serial list — YOURS MIGHT BE DIFFERENT
int serialIndex = 7;


int stateChange;
int state = 1;
int C3POstate = 1;
int R2D2state = 2;



ControlP5 cp5; //create ControlP5 object
PFont font; //do not change


void setup() {
  size(1000, 689);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 640 x 360 pixels.
  bg = loadImage("C3PO_R2D2.jpg");
  c3 = loadImage("C3PO.jpg");
  r2 = loadImage("R2.jpg");
  
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  //-- use your port name
  myPort  =  new Serial (this, "/dev/cu.SLAB_USBtoUART",  115200); 
  

  frameRate(5);
  
  img1 = loadImage("C3langs-01.png");
  img2 = loadImage("C3langs-02.png");
  img3 = loadImage("C3langs-03.png");
  img4 = loadImage("C3langs-04.png");
  img5 = loadImage("C3langs-05.png");
  
  r1img = loadImage("HanHolo.png");
  r2img = loadImage("LeiaHolo.png");
  r3img = loadImage("LukeHolo.png");
  r4img = loadImage("YodaHolo.png");
  r5img = loadImage("ScottHolo.png");
  
  
  if (switchValue == 1){
    buttonBool = true;
    switchValue = 1;
    lastSwitchValue = 0;
  }
  cp5 = new ControlP5(this); //do not change
  font = createFont("Aurebesh", 20);
  
     cp5.addButton("on") //name of button
    .setPosition(50, 600) //x and y upper left corner of button
    .setSize(120, 70) //(width, height)
    .setFont(font) //font
    .setColorBackground(color(0, 255, 0)) //background r,g,b
    .setColorForeground(color(255, 255, 255)) //mouse over color r,g,b
    .setColorLabel(color(0, 0, 0)) //text color r,g,b
    ;
  
      cp5.addButton("off")
    .setPosition(830, 600)
    .setSize(120, 70)
    .setFont(font)
    .setColorBackground(color(255, 0, 0))
    .setColorForeground(color(255, 255, 255))
    .setColorLabel(color(0, 0, 0))
    ;
    
}

void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    print(inBuffer);
    
    // This removes the end-of-line from the string 
    inBuffer = (trim(inBuffer));
    
    // This function will make an array of TWO items, 1st item = switch value, 2nd item = potValue
    data = split(inBuffer, ',');
   
   // we have THREE items — ERROR-CHECK HERE
   if( data.length >= 3 ) {
      switchValue = int(data[0]);
      potValue = int(data[1]);  // second index = pot value
      
      
      if (lastSwitchValue == 0 && switchValue == 1){
          R2D2state();
      }
      lastSwitchValue = switchValue;
   }
  }
} 

void draw() {
  //background(bg);
  checkSerial();



  if (state == C3POstate){
    C3POstate();
  }
  
  else if (state == R2D2state){
    R2D2state();
  }
  
}

void on() {
  myPort.write(1);
}

void off() {
  myPort.write(2);
}

void turnPotC3(){
  if (potValue >= 3300){
      image(img1, 0, 70, img1.width/8, img1.height/8);
  }
  
  else if (potValue >= 2500 && potValue <= 3300){
      image(img2, 0, 70, img2.width/8, img2.height/8);
  }
  
  else if (potValue >= 1700 && potValue <= 2500){
      image(img3, 0, 70, img3.width/8, img3.height/8 );
  }
  
  else if (potValue >= 800 && potValue <= 1700){
      image(img5, 0, 70, img5.width/8, img5.height/8 );

  }
  
  else if (potValue >= 100 && potValue <= 800){
      image(img4, 0, 70, img4.width/8, img4.height/8 );

  }
  
}

void turnPotR2(){
  if (potValue >= 3300){
      image(r1img, 530, 220, r1img.width/10, r1img.height/10);
  }
  
  else if (potValue >= 2500 && potValue <= 3300){
      image(r2img, 535, 230, r2img.width/3, r2img.height/3);
  }
  
  else if (potValue >= 1700 && potValue <= 2500){
      image(r3img, 535, 205, r3img.width/3, r3img.height/3 );
  }
  
  else if (potValue >= 800 && potValue <= 1700){
      image(r4img, 534, 225, r4img.width/3, r4img.height/3 );

  }
  
  else if (potValue >= 100 && potValue <= 800){
      image(r5img, 535, 225, r5img.width/3, r5img.height/3 );

  }
  
}


void C3POstate(){
  //put code here
  
  background(c3);
  
  turnPotC3();
  
}

void R2D2state(){
  //put code here
  
  background(r2);
  
  turnPotR2();
  
}

void keyPressed(){
  
  if (key == '1'){
    state = C3POstate;
  }
  
  else if (key == '2'){
    state = R2D2state;
  }
}
