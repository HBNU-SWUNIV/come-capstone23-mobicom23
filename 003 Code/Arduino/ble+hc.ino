#include <SoftwareSerial.h>
#include <Wire.h>

SoftwareSerial bluetooth(2, 3); // RX, TX
SoftwareSerial gps(11, 12);

const int MPU_addr = 0x68;
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;

double angleAcX, angleAcY, angleAcZ;
const double RADIAN_TO_DEGREE = 180 / 3.14159;

long duration1, distance1;
long duration2, distance2;

int trigPin1 = 6;
int echoPin1 = 7;
int trigPin2 = 9;
int echoPin2 = 10;

char c = "";
String str = "";
String targetStr = "GPRMC";

void setup() {
  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);
  Serial.begin(9600);
  bluetooth.begin(9600); // Set the baud rate of your Bluetooth module here
  gps.begin(9600);

  Serial.println("Hi");

  pinMode(echoPin1, INPUT);
  pinMode(trigPin1, OUTPUT);
  pinMode(echoPin2, INPUT);
  pinMode(trigPin2, OUTPUT);
}

void loop() {
  
  // gpsinfo(); // gps 센서 받기

  distance(); // 초음파 센서 받기
  get6050(); // 가속도 센서 받기

  angleAcX = atan(-AcY / sqrt(pow(AcX, 2) + pow(AcZ, 2)));
  angleAcX *= RADIAN_TO_DEGREE;

  bluetooth.print((String) distance1 + "&");
  bluetooth.print((String) distance2 + "&");
  bluetooth.print((String) angleAcX + "^");

  delay(500);
}

void gpsinfo(){
  if(gps.available()) {
    while(gps.available()){
      c = gps.read();
      // Serial.print(c);
      if(c=='$') {
        if(targetStr.equals(str.substring(0, 5))){
          Serial.println(str);
          int first = str.indexOf(",");
          int two = str.indexOf(",", first + 1);
          int three = str.indexOf(",", two + 1);
          int four = str.indexOf(",", three + 1);
          int five = str.indexOf(",", four + 1);
          int six = str.indexOf(",", five + 1);

          String Lat = str.substring(three + 1, four);
          String Long = str.substring(five + 1, six);

          String Lat1 = Lat.substring(0, 2);
          String Lat2 = Lat.substring(2);

          String Long1 = Long.substring(0, 3);
          String Long2 = Long.substring(3);

          double LatF = Lat1.toDouble() + Lat2.toDouble() / 60;
          float LongF = Long1.toFloat() + Long2.toFloat() / 60;

          Serial.print("Lat:");
          Serial.println(LatF, 15);
          Serial.print("Long:");
          Serial.println(LongF, 15);
        }

        str = "";
      } else {
        str += c;
      }
    }
  }
}

void distance(){
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);

  duration1 = pulseIn(echoPin1, HIGH);
  distance1 = ((float)(340 * duration1) / 1000) / 2;

  digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin2, LOW);

  duration2 = pulseIn(echoPin2, HIGH);
  distance2 = ((float)(340 * duration2) / 1000) / 2;

  Serial.println(distance1);
  Serial.println(distance2);
}

void get6050(){
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_addr,14,true);  // request a total of 14 registers

  AcX=Wire.read()<<8|Wire.read();  // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)    
  AcY=Wire.read()<<8|Wire.read();  // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
  AcZ=Wire.read()<<8|Wire.read();  // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)
  Tmp=Wire.read()<<8|Wire.read();  // 0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L)
  GyX=Wire.read()<<8|Wire.read();  // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
  GyY=Wire.read()<<8|Wire.read();  // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
  GyZ=Wire.read()<<8|Wire.read();  // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)
}