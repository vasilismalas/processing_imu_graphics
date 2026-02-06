import processing.serial.*;

Serial serialPort;

float pitchAxisVal;
float rollAxisVal;
float yawAxisVal;

boolean portDeviceFlag = false;

// color setup
color inFill = color(255, 123, 0);
color vertex = color(255, 177, 108);
color background = color(21, 27, 25);

boolean checkAvailableSerialPort() {
  if (Serial.list().length > 0) {
    printArray(Serial.list());
    portDeviceFlag = true;
    return true;
  } else {
    return false;
  }
}

boolean checkAvailableSerialData() {
  if (serialPort.available() > 0) {
    return true;
  } else {
    return false;
  }
}

void setup() {
  size(1400, 800, P3D);

  //  CHECK IF THERE ARE DEVICES CONNECTED TO THE SERIAL PORT
  if (checkAvailableSerialPort()) {

    // SET UP COM POPT TO PULL ARDUINO SERIAL DATA
    String comPort = Serial.list()[0];
    serialPort = new Serial(this, comPort, 115200);
  }
}

// DRAW SUPERLOOP
void draw() {
  background(background);
  if (portDeviceFlag) {
    if (!checkAvailableSerialData()) {
      textSize(24);
      fill(inFill);
      text("NO SERIAL DATA FOUND", 30, 100 );
      return;
    }
  } else {
    print("ERROR: NO DEVICE DETECTED ON SERIAL PORT");
    exit();
  }


  // text for mouse
  textSize(10);
  text("MOUSE HORIZONTAL POSITION: ", width/10, 50 );
  text(mouseX, width/10, 70 );
  text("MOUSE VERTICAL POSITION: ", width/10, 100 );
  text(mouseY, width/10, 120 );


  // serial data print
  textSize(18);
  text("ROLL AXIS:", width/4, 100 );
  text(rollAxisVal, width/4, 120 );
  text("PITCH AXIS: ", width/4, 150 );
  text(pitchAxisVal, width/4, 170 );
  text("YAW AXIS: ", width/4, 200 );
  text(yawAxisVal, width/4, 220 );

  // configure lights
  pushMatrix();
  translate(width/2, 50, 0);
  directionalLight(255, 255, 255, 0, 1, 0);
  ambientLight(255, 255, 255);
  popMatrix();

  // set box
  pushMatrix();
  translate(width/2, height/2);
  // rotateX(radians(mouseY));
  // rotateY(radians(mouseX));

  rotateX(radians(pitchAxisVal));
  rotateY(radians(yawAxisVal));
  rotateZ(radians(rollAxisVal));

  fill(inFill);
  stroke(vertex);

  box(150, 75, 250);
  popMatrix();
}
