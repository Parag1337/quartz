---
name: Questions
---

# Easy Level
## 1. To glow 3 LEDS in Running light sequence in loop or with different delay patterns.

| LED   | Arduino Pin | Resistor | Cathode (–) | Anode (+)             |
| ----- | ----------- | -------- | ----------- | --------------------- |
| LED 1 | D2          | 220Ω     | GND         | D2 (through resistor) |
| LED 2 | D3          | 220Ω     | GND         | D3 (through resistor) |
| LED 3 | D4          | 220Ω     | GND         | D4 (through resistor) |
```c
int led1 = 2;
int led2 = 3;
int led3 = 4 ;
void setup(){
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
}
void loop(){
  digitalWrite(led1, HIGH);
  delay(200);
  digitalWrite(led1, LOW);
  
  digitalWrite(led2, HIGH);
  delay(200);
  digitalWrite(led2, LOW);
  
  digitalWrite(led3, HIGH);
  delay(200);
  digitalWrite(led3, LOW);
}
```
## 2. To simulate working of traffic signal for two three way road.
| LED Color | Road A | Arduino Pin | Resistor | Connection Details              |
|-----------|--------|-------------|----------|---------------------------------|
| Red       | A      | D2          | 220Ω     | Anode to D2 (via resistor), Cathode to GND |
| Yellow    | A      | D3          | 220Ω     | Anode to D3 (via resistor), Cathode to GND |
| Green     | A      | D4          | 220Ω     | Anode to D4 (via resistor), Cathode to GND |

```c
// Road A LEDs
int redA = 2;
int yellowA = 3;
int greenA = 4;

// Road B LEDs
int redB = 5;
int yellowB = 6;
int greenB = 7;

void setup() {
  // Set all LEDs as output
  pinMode(redA, OUTPUT);
  pinMode(yellowA, OUTPUT);
  pinMode(greenA, OUTPUT);
  pinMode(redB, OUTPUT);
  pinMode(yellowB, OUTPUT);
  pinMode(greenB, OUTPUT);
}

void loop() {
  // Phase 1: Road A Green, Road B Red
  digitalWrite(greenA, HIGH);
  digitalWrite(redB, HIGH);
  delay(5000); // 5 seconds
  
  // Phase 2: Road A Yellow, Road B Red
  digitalWrite(greenA, LOW);
  digitalWrite(yellowA, HIGH);
  delay(2000); // 2 seconds
  digitalWrite(yellowA, LOW);
  digitalWrite(redA, HIGH);

  // Phase 3: Road A Red, Road B Green
  digitalWrite(redB, LOW);
  digitalWrite(greenB, HIGH);
  delay(5000); // 5 seconds

  // Phase 4: Road A Red, Road B Yellow
  digitalWrite(greenB, LOW);
  digitalWrite(yellowB, HIGH);
  delay(2000); // 2 seconds
  digitalWrite(yellowB, LOW);

  // Reset for next loop
  digitalWrite(redA, LOW);
  digitalWrite(redB, LOW);
}

```
## 3. To implement automated street light ON OFF system depending upon at ambient light intensity. Use at least 3-LEDSs as street Light. (Use LDR sensor)

| LED # | Arduino Pin | Resistor | Connection Details                                |
|-------|-------------|----------|-------------------------------------------------|
| LED 1 | D2          | 220Ω     | **Longer leg (bigger leg)** to D2 (via resistor), **shorter leg (smaller leg)** to GND |
| LED 2 | D3          | 220Ω     | **Longer leg (bigger leg)** to D3 (via resistor), **shorter leg (smaller leg)** to GND |
| LED 3 | D4          | 220Ω     | **Longer leg (bigger leg)** to D4 (via resistor), **shorter leg (smaller leg)** to GND |


```c
int led1 = 2;
int led2 = 3;
int led3 = 4;
int ldrPin = A0; // LDR analog input
int threshold = 500; // Adjust this based on your room lighting

void setup() {
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  Serial.begin(9600); // for debugging LDR values
}

void loop() {
  int ldrValue = analogRead(ldrPin);
  Serial.println(ldrValue); // View in Serial Monitor to set threshold

  if (ldrValue < threshold) {
    // It's dark: turn ON street lights
    digitalWrite(led1, HIGH);
    digitalWrite(led2, HIGH);
    digitalWrite(led3, HIGH);
  } else {
    // It's bright: turn OFF street lights
    digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    digitalWrite(led3, LOW);
  }
  delay(500);
}
```
## 4. To find distance (in cm) between the sensor and fixed surface like obstacle or wall. (Print distance on serial monitor)
| HC-SR04 Pin | Arduino Pin | Connection Notes                  |
| ----------- | ----------- | --------------------------------- |
| VCC         | 5V          | Power supply                      |
| GND         | GND         | Ground                            |
| TRIG        | D9          | Trigger pin (output from Arduino) |
| ECHO        | D10         | Echo pin (input to Arduino)       |
|             |             |                                   |


```c
const int trigPin = 9;
const int echoPin = 10;
long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600); // Start serial communication
}

void loop() {
  // Send ultrasonic pulse
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the pulse duration
  duration = pulseIn(echoPin, HIGH);

  // Calculate distance in cm
  distance = duration * 0.034 / 2;

  // Print distance
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  delay(500);
}
```
## 5. Write a program to display Hello World! On LCD at desired location.
| LCD Pin | Arduino Pin | Description               |
|---------|-------------|---------------------------|
| GND     | GND         | Ground                    |
| VCC     | 5V          | Power (5 Volts)           |
| SDA     | A4          | I2C Data Line             |
| SCL     | A5          | I2C Clock Line            |

```c
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup() {
  lcd.begin();
  lcd.backlight();  // Turn on backlight
}

void loop() {
  lcd.display();            // Turn on display
  lcd.clear();              // Clear previous content

  lcd.setCursor(0, 0);
  lcd.print("Hello World");

  lcd.setCursor(0, 1);
  lcd.print("by parag");

  delay(5000);

  lcd.noDisplay();          // Turn off display (text still "stored" internally)
  delay(5000);
}


```
## 6. Take temperature readings from the thermistor and display the results on the Serial Monitor.
| Component       | Arduino Pin | Notes                                |
| --------------- | ----------- | ------------------------------------ |
| Thermistor leg1 | +5V         | One leg connected to 5V              |
| Thermistor leg2 | A0          | Other leg connected to analog pin A0 |
| Fixed resistor  | A0 & GND    | Connect 10kΩ resistor from A0 to GND |

```c
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <math.h> // Required for log()

// Initialize LCD: address 0x27, 16 columns, 2 rows
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Thermistor and resistor values
const int thermistorPin = A0;            // Analog pin A0
const float seriesResistor = 10000;      // 10k ohm fixed resistor
const float nominalResistance = 10000;   // Thermistor resistance at 25°C
const float nominalTemperature = 25;     // Nominal temp in Celsius
const float bCoefficient = 3950;         // Beta value of thermistor

void setup() {
  Serial.begin(9600);    // Start Serial Monitor
  lcd.begin();           // Initialize LCD
  lcd.backlight();       // Turn on LCD backlight
}

void loop() {
  int adcValue = analogRead(thermistorPin);

  // Convert ADC to voltage and resistance
  float voltage = adcValue * (5.0 / 1023.0);
  float resistance = (5.0 - voltage) * seriesResistor / voltage;

  // Calculate temperature using Steinhart-Hart Equation
  float steinhart = resistance / nominalResistance;      
  steinhart = log(steinhart);                           
  steinhart /= bCoefficient;                            
  steinhart += 1.0 / (nominalTemperature + 273.15);     
  steinhart = 1.0 / steinhart;                          
  steinhart -= 273.15;                                  

  // Print to Serial
  Serial.print("Temperature: ");
  Serial.print(steinhart);
  Serial.println(" °C");

  // Display on LCD
  lcd.clear();  // Optional: clears LCD before writing new value
  lcd.setCursor(0, 0);
  lcd.print("Temperature:");
  lcd.setCursor(0, 1);
  lcd.print(steinhart, 1); // Print with 1 decimal place
  lcd.print(" C");

  delay(1000); // 1 second delay
}

```
## 7. Write a program to interface IR sensor so as to display sensor values on serial monitor.
| IR Sensor Pin | Arduino Pin | Description               |
|---------------|-------------|---------------------------|
| VCC           | 5V          | Power supply (5 Volts)    |
| GND           | GND         | Ground                   |
| OUT (Analog)  | A0          | Analog output to Arduino A0 |

```c
const int ir = A0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int irValue = analogRead(ir);
  Serial.print("IR Value: ");
  Serial.println(irValue);

  if (irValue < 500) { // adjust threshold as needed
    Serial.println("Object Found");
  } else {
    Serial.println("No Object Found");
  }
  delay(500);
}
```

## 8. Write a program to implement simple decimal and Alphabets counter using a 7 Segment Display.
| TM1637 Pin | Arduino Pin | Notes                      |
|------------|-------------|----------------------------|
| CLK        | D3          | Clock line (digital pin 3) |
| DIO        | D2          | Data line (digital pin 2)  |
| VCC        | 5V          | Power supply (5 Volts)      |
| GND        | GND         | Ground                     |

```c
#include <TM1637Display.h>

#define CLK 3
#define DIO 2

TM1637Display display(CLK, DIO);

// Define the custom segment values for numbers 0–9 and letters A–F
const uint8_t symbols[] = {
  0x3F, // 0
  0x06, // 1
  0x5B, // 2
  0x4F, // 3
  0x66, // 4
  0x6D, // 5
  0x7D, // 6
  0x07, // 7
  0x7F, // 8
  0x6F, // 9
  0x77, // A
  0x7C, // b
  0x39, // C
  0x5E, // d
  0x79, // E
  0x71  // F
};

void setup() {
  display.setBrightness(5); // Medium brightness
}

void loop() {
  for (int i = 0; i < 16; i++) {
    display.setSegments(&symbols[i], 1, 3); // Display at digit 3
    delay(1000);
  }
}

```
##  9. Write a program to control the Servo Motor Rotation by one Degree using Arduino Uno.
```c
#include <Servo.h>
Servo myServo;
void setup(){
  myServo.attach(9);
}

void loop(){
  for (int i = 180; i >= 0 ; i--){
    myServo.write(i);
    delay(50);
  }
  for (int i = 0; i <=  180 ; i++){
    myServo.write(i);
    delay(50);
  }
  delay(200);
}
```


## 10. Demonstrate burglar alarm using LDR sensor.
| Component      | Arduino Pin | Description                          |
|----------------|-------------|------------------------------------|
| LDR (Light Dependent Resistor)                     |
| — Leg 1        | +5V         | Connect one leg of LDR to 5V        |
| — Leg 2        | A0          | Other leg connected to analog pin A0|
| 10kΩ Resistor  | A0 to GND   | Connect a 10k resistor between A0 and GND (forms voltage divider) |

```c
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C led(0x27,16,2);
int ldrpin = A0;
int buzzer = 9;  // Fixed variable name typo: bugger -> buzzer

void setup(){
  Serial.begin(9600);
  led.begin();
  led.backlight();
  pinMode(buzzer, OUTPUT);
  led.clear();
  led.setCursor(0,0);
  led.print("LDR Monitoring");
}

void loop(){
  int ldrvalue = analogRead(ldrpin);
  Serial.println(ldrvalue);
  if (ldrvalue < 350) {
      // Turn buzzer ON for longer so it's audible
      digitalWrite(buzzer, HIGH);
      led.setCursor(0,0);
      led.print("HIGH ALERT     "); // Extra spaces clear leftover text
  } 
  else {
      digitalWrite(buzzer, LOW);
      led.setCursor(0,0);
      led.print("Normal        "); // Show normal message
  }
  delay(200);  // Short delay for responsiveness
}
```

# Medium Level
## 1. To count number of objects passing through. The system should use light source (LED) and detector (LDR). Initially count should be. Zero and with every object passing it should be incremented by '1' Display the count on serial monitor of the serial monitor.
```c
#include <LiquidCrystal_I2C.h>

int ldrpin = A0;
LiquidCrystal_I2C lcd(0x27, 16, 2);
int count = 0;

void setup() {
  Serial.begin(9600);
  lcd.begin();
  lcd.backlight();
}

void loop() {
  int ldrvalue = analogRead(ldrpin);

  if (ldrvalue > 800) {
    count++;
    Serial.print("One Object Found: ");
    Serial.println(count);

    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Object Found");
    lcd.setCursor(0, 1);
    lcd.print("Count: ");
    lcd.print(count);

    delay(500); // Wait half second to avoid multiple counting
  }

  delay(100);
}
```
## 2. Ultrasonic distance range finding and turn on Buzzer on desired distance.
```c
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C led(0x27, 16, 2);

const int trigpin = 9;
const int echopin = 10;
long duration;
int distance;
int buzzer = 12;

void setup() {
  pinMode(trigpin, OUTPUT);
  pinMode(echopin, INPUT);
  Serial.begin(9600);

  led.begin();
  led.backlight();

  pinMode(buzzer, OUTPUT);
}

void loop() {
  // Trigger ultrasonic pulse
  digitalWrite(trigpin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin, LOW);

  // Measure duration and calculate distance
  duration = pulseIn(echopin, HIGH);
  distance = duration * 0.034 / 2;

  // Clear display each cycle
  led.clear();

  // Display distance
  led.setCursor(0, 0);
  led.print("Distance: ");
  led.print(distance);
  led.print("cm");

  // Condition for buzzer and warning
  if (distance > 350) {
    led.setCursor(0, 1);
    led.print("WARNING! TOO FAR");
    digitalWrite(buzzer, HIGH);
    delay(200); // Beep duration
    digitalWrite(buzzer, LOW);
  } else {
    led.setCursor(0, 1);
    led.print("Within Range     ");
    digitalWrite(buzzer, LOW); // Make sure it's off
  }

  // Serial output
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  delay(500);
}

```
##  3. Display distance on LCD using ultrasound (ultrasonic) sensor.

| Component             | Pin Name        | Arduino Pin | Notes             |
| --------------------- | --------------- | ----------- | ----------------- |
| **Ultrasonic Sensor** | VCC (Big leg)   | 5V          | Power supply      |
|                       | GND (Small leg) | GND         | Ground            |
|                       | TRIG            | 9           | Trigger pin       |
|                       | ECHO            | 10          | Echo pin          |
| **Buzzer**            | + (Big leg)     | 8           | Positive to pin 8 |
|                       | – (Small leg)   | GND         | Connect to GND    |
| **I2C LCD Display**   | VCC             | 5V          | Power supply      |
|                       | GND             | GND         | Ground            |
|                       | SDA             | A4          | I2C Data line     |
|                       | SCL             | A5          | I2C Clock line    |

```c
const int trigPin = 9;
const int echoPin = 10;
const int buzzer = 8;

long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzer, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // Clear the trigPin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  // Send 10us pulse to trigger
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the echo time
  duration = pulseIn(echoPin, HIGH);

  // Calculate distance in cm
  distance = duration * 0.034 / 2;

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // Turn on buzzer if object is within 10 cm
  if (distance <= 10) {
    digitalWrite(buzze

```

## 4. Shree Pattern Printing

| Component             | Pin Name     | Arduino Pin | Notes                           |
|----------------------|--------------|-------------|---------------------------------|
| **I2C LCD Display**  | VCC (Big leg)  | 5V          | Power supply                    |
|                      | GND (Small leg)| GND         | Ground                          |
|                      | SDA          | A4          | I2C Data                         |
|                      | SCL          | A5          | I2C Clock                        |


```c
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// LCD address may vary (0x27 or 0x3F)
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Custom character data for simplified "श्री" (5x8 pixels)
byte shreeChar[8] = {
  B00111,
  B00101,
  B11111,
  B10101,
  B01101,
  B10101,
  B00101,
  B00101 
};

void setup() {
  lcd.init();
  lcd.backlight();

  lcd.createChar(0, shreeChar);  // Store in location 0
  lcd.setCursor(0, 0);
  lcd.print("Custom Char:");
  lcd.setCursor(0, 1);
  lcd.write(byte(0));  // Display custom char
}

void loop() {
  // Do nothing
}
```



## 5. If switch is pressed 1st time then some xyz pattern if pressed 2nd time then xyz pattern if pressed 3rd time then xyz pattern.(Patterns on LEDs)

| Component       | Pin Name          | Arduino Pin | Notes                              |
| --------------- | ----------------- | ----------- | ---------------------------------- |
| **Push Button** | One leg (Big)     | Pin 2       | Button input (with `INPUT_PULLUP`) |
|                 | Other leg (Small) | GND         | Connect directly to ground         |
| **LED 1**       | Longer leg (Big)  | Pin 8       | First pattern LED                  |
|                 | Shorter leg       | GND         | Through a 220Ω resistor            |
| **LED 2**       | Longer leg        | Pin 9       | Second pattern LED                 |
|                 | Shorter leg       | GND         | Through a 220Ω resistor            |
| **LED 3**       | Longer leg        | Pin 10      | Third pattern LED                  |
|                 | Shorter leg       | GND         | Through a 220Ω resistor            |
```c
const int butpin = 2;
const int led1 = 8;
const int led2 = 9;
const int led3 = 10;

bool lastbtst = HIGH;
bool debounce = false;

int pressCount = 0;

void setup(){
  pinMode(butpin, INPUT_PULLUP);  // Button with pull-up resistor
  Serial.begin(9600);

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);

  // Turn off all LEDs at start
  digitalWrite(led1, LOW);
  digitalWrite(led2, LOW);
  digitalWrite(led3, LOW);
}

void loop(){
  int btst = digitalRead(butpin);

  if (btst == LOW && lastbtst == HIGH && !debounce){
    debounce = true;
	    pressCount++;

    if (pressCount > 3){
      pressCount = 1;
    }

    Serial.print("Button pressed, pattern: ");
    Serial.println(pressCount);

    if (pressCount == 1) {
      digitalWrite(led1, HIGH);
      digitalWrite(led2, LOW);
      digitalWrite(led3, LOW);
    }
    else if (pressCount == 2) {
      digitalWrite(led1, LOW);
      digitalWrite(led2, HIGH);
      digitalWrite(led3, LOW);
    }
    else if (pressCount == 3) {
      digitalWrite(led1, LOW);
      digitalWrite(led2, LOW);
      digitalWrite(led3, HIGH);
    }
  }

  if (btst == HIGH) {
    debounce = false;
  }

  lastbtst = btst;
}

```

## 6. Write a program to control Servo Motor Rotation Control using potentiometer.

| Component       | Pin Name        | Arduino Pin | Notes                                        |
|------------------|------------------|-------------|----------------------------------------------|
| **Potentiometer**| Left Pin         | 5V          | VCC                                           |
|                  | Middle Pin       | A0          | Analog signal input to Arduino               |
|                  | Right Pin        | GND         | Ground                                        |
| **Servo Motor**  | Red Wire         | 5V          | Power                                         |
|                  | Brown/Black Wire | GND         | Ground                                        |
|                  | Orange/Yellow    | Pin 9       | PWM signal from Arduino                      |

```c
#include <Servo.h>
Servo myservo;           // Corrected: Capital S
const int potPin = A0;   // Potentiometer pin
int potValue = 0;        // To store potentiometer reading
int angle = 0;           // Servo angle (0–180)

void setup() {
  Serial.begin(9600);    
  myservo.attach(9);     // Attach servo to pin 9 (PWM pin)
}
void loop() {
  potValue = analogRead(potPin);   // 0–1023
  Serial.print("Potentiometer Value: ");
  Serial.println(potValue);
  angle = map(potValue, 0, 1023, 0, 180); // Map to servo angle
  myservo.write(angle);                  // Rotate servo
  delay(200);

}
```

## 7. Use 4 switch in seven segment display: a) When S1 press display 1 b)When S2 press display 2 c) When S3 press display 3 d) When S4 press display 4

| Component              | Pin Name       | Arduino Pin | Notes                                      |
|------------------------|----------------|-------------|--------------------------------------------|
| **TM1637 Display**     | CLK            | Pin 3       | Clock line                                 |
|                        | DIO            | Pin 2       | Data line                                  |
|                        | VCC            | 5V          | Power supply                               |
|                        | GND            | GND         | Ground                                     |
| **Switch 1 (S1)**      | One side       | Pin 4       | Use with `INPUT_PULLUP`                    |
|                        | Other side     | GND         | Connect to ground                          |
| **Switch 2 (S2)**      | One side       | Pin 5       | Use with `INPUT_PULLUP`                    |
|                        | Other side     | GND         | Connect to ground                          |
| **Switch 3 (S3)**      | One side       | Pin 6       | Use with `INPUT_PULLUP`                    |
|                        | Other side     | GND         | Connect to ground                          |
| **Switch 4 (S4)**      | One side       | Pin 7       | Use with `INPUT_PULLUP`                    |
|                        | Other side     | GND         | Connect to ground                          |

```c
#include <TM1637Display.h>

#define CLK 3
#define DIO 2

#define S1 4
#define S2 5
#define S3 6
#define S4 7

TM1637Display display(CLK, DIO);

void setup() {
  display.setBrightness(5); // Set brightness (0-7)

  pinMode(S1, INPUT_PULLUP);
  pinMode(S2, INPUT_PULLUP);
  pinMode(S3, INPUT_PULLUP);
  pinMode(S4, INPUT_PULLUP);
}

void loop() {
  if (digitalRead(S1) == LOW) {
    display.showNumberDec(1);
  } else if (digitalRead(S2) == LOW) {
    display.showNumberDec(2);
  } else if (digitalRead(S3) == LOW) {
    display.showNumberDec(3);
  } else if (digitalRead(S4) == LOW) {
    display.showNumberDec(4);
  }
}

```

# Hard Question 💀

| Component   | Pin Name | Arduino Pin      | Notes                            |
| ----------- | -------- | ---------------- | -------------------------------- |
| **I2C LCD** | SDA      | A4 (on UNO/Nano) | Data line for I2C communication  |
|             | SCL      | A5 (on UNO/Nano) | Clock line for I2C communication |
|             | VCC      | 5V               | Power supply                     |
|             | GND      | GND              | Ground                           |
## 1. Write a program to scroll custom message on Right or Left direction on LCD.
```c
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,16,2);
String message  = "Welcome To VIT Pune";
String message2 = "VIT Pune mai aapka Swagat Hai"
int delayT = 300;

void setup(){
  lcd.begin();
  lcd.backlight();
  lcd.print("Scrolling Demo");
  delay(1000);
}

void loop(){
  // Scroll left from right edge
  lcd.clear();
  lcd.setCursor(16,0);
  lcd.print(message);
  for (int i = 0; i < message.length() + 16; i++){
    lcd.scrollDisplayLeft();
    delay(delayT);
  }
  delay(4000);  // Wait after left scroll
		


  // Scroll right from off-screen (prepended spaces)
  lcd.clear();
  lcd.setCursor(0, 0);
  String paddedMessage = String("                ") + message; // 16 spaces + message
  lcd.print(paddedMessage);
  for (int i = 0; i < message.length() + 16; i++) {
    lcd.scrollDisplayRight();
    delay(delayT);
  }
  delay(4000);  // Wait after right scroll
}

```
```c
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);
String message = " Welcome to VIT Pune! ";  // Message to scroll
int scrollDelay = 300;

void setup() {
  lcd.begin();
  lcd.backlight();
}

void loop() {
  for (int i = 0; i <= message.length() - 1; i++) {
    // Take 16 characters starting at position i
    String displayPart = message.substring(i, i + 16);

    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(displayPart);

    delay(scrollDelay);
    
    // If we're at the end, start over
    if (i + 16 >= message.length()) {
      delay(1000);  // Pause at end before restarting
      i = -1;       // Reset for the next loop iteration
    }
  }
}

```

## 5. Rotate servo motor 180 in steps of 10 degrees and display steps and degrees on serial monitor
| Component    | Arduino Pin | Description                         |
| ------------ | ----------- | ----------------------------------- |
| Servo Signal | D9          | PWM signal to control angle         |
| Servo VCC    | 5V          | Power supply to servo motor         |
| Servo GND    | GND         | Ground connection                   |
| USB          | —           | To upload code & use Serial Monitor |

```c
#include <Servo.h>

Servo myServo;

void setup() {
  myServo.attach(9);         // Connect servo to pin 9
  Serial.begin(9600);        // Start serial communication
  Serial.println("Starting Servo Sweep...");
}

void loop() {
  int step = 1;              // Initialize step counter

  for (int angle = 0; angle <= 180; angle += 10) {
    myServo.write(angle);   // Move servo to desired angle

    Serial.print("Step ");
    Serial.print(step);
    Serial.print(": Angle = ");
    Serial.print(angle);
    Serial.println(" degrees");

    delay(500);              // Wait for servo to reach position
    step++;
  }

  delay(2000);               // Pause before repeating
}

```
---
---

#### example code for button and led 
```c
const int ledPin = 9;
const int buttonPin = 2;

bool ledState = false;
int lastButtonState = HIGH;
bool debounce = false;

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
  digitalWrite(ledPin, LOW);
  Serial.begin(9600);
}

void loop() {
  bool currentButtonState = digitalRead(buttonPin);

  if (currentButtonState == LOW && lastButtonState == HIGH && !debounce) {
    ledState = !ledState;
    digitalWrite(ledPin, ledState);
    debounce = true;
  }

  if (currentButtonState == HIGH) {
    debounce = false;
  }

  lastButtonState = currentButtonState;
}

```
#### Run DC Motor using button
```c
const int buttonPin = 2;    // push‑button input
const int relayPin  = 7;    // relay coil negative
void setup() {
  pinMode(buttonPin, INPUT_PULLUP);  // enable internal pull‑up
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, LOW);       // start with motor OFF
  Serial.begin(9600);
}
void loop() {
  int btst = digitalRead(relayPin);
  // button reads LOW when pressed
  if (btst == LOW) {
    digitalWrite(relayPin, HIGH);  // energize coil → motor ON
  } else {
    digitalWrite(relayPin, LOW);   // de‑energize → motor OFF
  }
  Serial.println(btst);
  delay(200);
}
```

#### Basic Program Of Servo

```c
#include <Servo.h>

Servo myServo; // Create a Servo object

void setup() {
  myServo.attach(9); // Attach servo signal pin to D9
}

void loop() {
  // Move from 0 to 180 degrees
  for (int angle = 0; angle <= 180; angle++) {
    myServo.write(angle);    // Rotate to current angle
    delay(15);               // Wait for servo to move
  }

  delay(500); // Wait before going back

  // Move from 180 to 0 degrees
  for (int angle = 180; angle >= 0; angle--) {
		    myServo.write(angle);
    delay(15);
  }

  delay(500); // Pause again
}

```






	

| tm1637 | pins |
| ------ | ---- |
| VCC    | 5V   |
| Gnd    | gnd  |
| dio    | d2   |
| clk    | d3   |
