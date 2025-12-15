---
title: Untitled
date: 2025-12-08
tags: 
---
# Rental System Header Documentation

  

## Overview

  

`rental_system.h` is a comprehensive C++ header file that implements a complete car rental and parking management system. It provides both console-based operations and web API functionality through a shared codebase.

  

---

  

## File Structure

  

```

rental_system.h

├── Person (Base Class)

├── Owner (Derived from Person)

├── Customer (Derived from Person)

├── Car (Main Entity Class)

└── RentalSystem (Manager Class)

```

  

---

  

## Class Hierarchy & Inheritance

  

### 1. **Person** (Base Class)

The foundation class demonstrating **polymorphism** through virtual functions.

  

```cpp

class Person {

protected:

    string name;

public:

    void setName(string n);

    string getName();

    virtual void showRole();  // Virtual function for polymorphism

};

```

  

**Purpose**:

- Provides common attributes (name) for all user types

- Demonstrates OOP concept of **inheritance**

- Uses **virtual function** for runtime polymorphism

  

**Key Features**:

- Protected member `name` accessible by derived classes

- Virtual method `showRole()` can be overridden

  

---

  

### 2. **Owner** (Derived Class)

Represents car owners in the system.

  

```cpp

class Owner : public Person {

    int earnings;

public:

    Owner();

    void addEarnings(int amt);

    int getEarnings();

    void showRole() override;

};

```

  

**Attributes**:

- `earnings`: Total money earned from renting cars

  

**Methods**:

- `addEarnings(int amt)`: Adds to owner's earnings

- `getEarnings()`: Returns total earnings

- `showRole()`: Overridden to display owner-specific message

  

**Use Case**: Track individual car owners and their revenue

  

---

  

### 3. **Customer** (Derived Class)

Represents customers who rent cars.

  

```cpp

class Customer : public Person {

    int rentedCars;

public:

    Customer();

    void addRental();

    void showRole() override;

};

```

  

**Attributes**:

- `rentedCars`: Counter for number of cars rented

  

**Methods**:

- `addRental()`: Increments rental count

- `showRole()`: Shows customer-specific message

  

**Use Case**: Track customer rental history

  

---

  

## Core Entity Class

  

### 4. **Car** (Main Business Entity)

The central class representing each car in the system.

  

#### **Private Attributes**

```cpp

string model;          // Car model (e.g., "Toyota Camry")

string regno;          // Registration number (unique identifier)

string ownerName;      // Name of the car owner

int rentPerDay;        // Daily rental rate

int totalEarn;         // Cumulative earnings from this car

bool rented;           // Current rental status

string customerName;   // Current renter's name (if rented)

```

  

#### **Public Methods**

  

##### **1. Constructors & Initialization**

```cpp

Car()  // Default constructor - initializes all values

void setData(string m, string r, string o, int rent)  // Bulk data setter

void input()  // Console input for user entry

```

  

##### **2. Rental Operations**

```cpp

void rent(int days)                              // Rent for console app

void rentWithCustomer(int days, string customer) // Rent for web API

void ret()                                       // Return the car

```

  

**How `rent()` works**:

1. Calculates total rent: `amt = days × rentPerDay`

2. Adds to `totalEarn`

3. Sets `rented = true`

4. Stores customer name

  

**How `ret()` works**:

1. Sets `rented = false`

2. Clears `customerName`

  

##### **3. Display & Output**

```cpp

void show()         // Console table display

string toJSON()     // JSON format for web API

```

  

**JSON Output Example**:

```json

{

  "model": "Toyota Camry",

  "regno": "ABC123",

  "owner": "John Doe",

  "rentPerDay": 50,

  "totalEarn": 150,

  "rented": true,

  "customer": "Alice Smith"

}

```

  

##### **4. Getters**

```cpp

string getReg()         // Get registration number

string getOwner()       // Get owner name

int getEarn()          // Get total earnings

bool isRented()        // Check if rented

int getRentPerDay()    // Get daily rent

string getModel()      // Get car model

string getCustomer()   // Get current customer

```

  

##### **5. Setters (for Data Loading)**

```cpp

void setEarnings(int earn)   // Set earnings when loading from file

void setRented(bool r)       // Set rental status

void setCustomer(string c)   // Set customer name

```

  

---

  

## System Manager Class

  

### 5. **RentalSystem** (Core Business Logic)

Manages the entire collection of cars and all operations.

  

#### **Private Attributes**

```cpp

vector<Car> cars;  // Dynamic array storing all cars

```

  

---

  

## RentalSystem Methods

  

### **A. Car Management**

  

#### **1. Add Car**

```cpp

void addCar()  // Console input version

void addCarWithData(string model, string regno, string owner, int rent)  // Programmatic version

```

  

**Process**:

- Creates new `Car` object

- Adds to `cars` vector

- No duplicate checking (could be improved)

  

---

  

#### **2. Display Cars**

```cpp

void showCars()

```

  

**Output Format**:

```

Model       RegNo       Owner       Status      Rent/day    Earnings

-----------------------------------------------------------------------

Toyota      ABC123      John Doe    Rented      50          150

Honda       XYZ789      Jane Smith  Available   45          90

```

  

**How it works**:

- Iterates through `cars` vector

- Calls `show()` on each car

- Displays in formatted table

  

---

  

#### **3. Delete Car**

```cpp

void deleteCar()

```

  

**Process**:

1. Prompts for registration number

2. Searches through vector

3. Uses `vector::erase()` to remove car

4. Handles car not found case

  

---

  

### **B. Rental Operations**

  

#### **1. Rent Car (Console Version)**

```cpp

void rentCar()

```

  

**Workflow**:

1. Display all cars

2. User enters registration number

3. System checks availability

4. User enters rental days

5. Calculate total rent

6. Ask for confirmation

7. Update car status

  

**Business Rules**:

- Cannot rent already rented car

- User can cancel before confirmation

  

---

  

#### **2. Rent Car (API Version)**

```cpp

bool rentCarAPI(string regno, int days, string customer)

```

  

**Returns**: `true` if successful, `false` if car unavailable/not found

  

**Usage**: Called by web server for HTTP requests

  

**Difference from console version**:

- No user interaction

- Returns boolean for API response

- Stores customer name

  

---

  

#### **3. Return Car**

```cpp

void returnCar()        // Console version

bool returnCarAPI(string regno)  // API version

```

  

**Process**:

- Finds car by registration

- Calls `ret()` method

- Updates availability status

  

---

  

### **C. Data Persistence (File Handling)**

  

#### **1. Save Data**

```cpp

void saveData()

```

  

**File Format** (`cars.txt`):

```

Toyota Camry|ABC123|John Doe|50|150|1|Alice Smith

Honda Civic|XYZ789|Jane Smith|45|90|0|

```

  

**Structure**: Pipe-delimited (`|`) fields

1. Model

2. Registration Number

3. Owner Name

4. Rent Per Day

5. Total Earnings

6. Rented Status (0 or 1)

7. Customer Name

  

**How it works**:

- Opens `cars.txt` in write mode

- Iterates through all cars

- Writes each car's data as one line

- Closes file

  

---

  

#### **2. Load Data**

```cpp

void loadData()

```

  

**Process**:

1. Opens `cars.txt`

2. Reads line by line

3. Parses using `stringstream` and `getline()` with `|` delimiter

4. Creates `Car` objects

5. Adds to `cars` vector

  

**Parsing Technique**:

```cpp

stringstream ss(line);

getline(ss, model, '|');      // Read until '|'

getline(ss, regno, '|');

getline(ss, owner, '|');

ss >> rent;                    // Read integer

ss.ignore();                   // Skip delimiter

```

  

**Error Handling**:

- If file doesn't exist, silently returns

- Skips empty lines

  

---

  

### **D. Reporting & Analytics**

  

#### **1. Owner Dashboard**

```cpp

void ownerDashboard()

```

  

**Output**:

```

Owner: John Doe

Total Cars: 3

Total Earnings: 450

```

  

**Algorithm**:

1. Prompt for owner name

2. Loop through all cars

3. Count cars matching owner

4. Sum earnings from matching cars

  

---

  

#### **2. System Statistics**

```cpp

void showStats()

```

  

**Displays**:

- Total cars in system

- Currently rented cars

- Total system earnings

  

**Calculation**:

```cpp

for (each car) {

    if (car.isRented()) rented++;

    earnings += car.getEarn();

}

```

  

---

  

### **E. Web API Methods**

  

#### **1. Get All Cars (JSON)**

```cpp

string getAllCarsJSON()

```

  

**Returns**: JSON array of all cars

```json

[

  {"model":"Toyota","regno":"ABC123",...},

  {"model":"Honda","regno":"XYZ789",...}

]

```

  

**Used by**: `/api/cars` endpoint

  

---

  

#### **2. Owner Dashboard (JSON)**

```cpp

string getOwnerDashboardJSON(string ownerName)

```

  

**Returns**:

```json

{

  "owner": "John Doe",

  "totalCars": 3,

  "totalEarnings": 450,

  "cars": [...]

}

```

  

**Used by**: `/api/owner/:name` endpoint

  

---

  

#### **3. System Stats (JSON)**

```cpp

string getStatsJSON()

```

  

**Returns**:

```json

{

  "totalCars": 10,

  "rentedCars": 4,

  "availableCars": 6,

  "totalEarnings": 2500

}

```

  

**Used by**: `/api/stats` endpoint

  

---

  

#### **4. Get All Owners**

```cpp

vector<string> getAllOwners()

string getAllOwnersJSON()

```

  

**Process**:

1. Extract all unique owner names

2. Return as JSON array

3. Used for dropdown menus in web UI

  

---

  

## Key C++ Concepts Demonstrated

  

### 1. **Object-Oriented Programming**

- **Encapsulation**: Private data members with public methods

- **Inheritance**: Owner and Customer inherit from Person

- **Polymorphism**: Virtual function `showRole()`

- **Abstraction**: Complex operations hidden behind simple interfaces

  

### 2. **Data Structures**

- **Vector**: Dynamic array (`vector<Car>`)

- **String**: String manipulation and parsing

  

### 3. **File I/O**

- **ofstream**: Writing to files

- **ifstream**: Reading from files

- **Stream manipulation**: `getline()`, `stringstream`

  

### 4. **STL Algorithms**

- **find()**: Searching in vectors

- **erase()**: Removing elements

  

### 5. **String Processing**

- **stringstream**: Building JSON strings

- **Delimiters**: Pipe-separated values

- **Parsing**: Extracting data from text

  

---

  

## Integration Points

  

### **Console Application** (`main.cpp`)

```cpp

#include "rental_system.h"

  

RentalSystem system;

system.loadData();    // Load from file

system.addCar();      // User input

system.rentCar();     // Interactive rental

system.saveData();    // Persist changes

```

  

### **Web Server** (`server_main.cpp`)

```cpp

#include "rental_system.h"

  

RentalSystem system;

system.loadData();              // Load existing data

string json = system.getAllCarsJSON();  // API response

bool success = system.rentCarAPI(...);  // Process request

system.saveData();              // Auto-save

```

  

---

  

## Data Flow

  

```

User Input (Console/Web)

    ↓

RentalSystem Methods

    ↓

Car Object Operations

    ↓

Update Internal State

    ↓

Save to cars.txt

    ↓

Load on Next Startup

```

  

---

  

## Detailed Program Flow (main.cpp)

  

### **Program Initialization**

  

```

1. Program Starts

   ↓

2. Create RentalSystem object

   RentalSystem system;

   ↓

3. Load existing data from file

   system.loadData();

   ├─→ Opens cars.txt

   ├─→ Reads each line

   ├─→ Parses pipe-delimited data

   ├─→ Creates Car objects

   └─→ Adds to cars vector

   ↓

4. Display main menu

```

  

### **Menu-Driven Flow**

  

```

┌─────────────────────────────────────┐

│  Main Menu Loop (do-while ch != 9) │

└─────────────────────────────────────┘

           ↓

    Display Options:

    1. Register Car

    2. Show All Cars

    3. Rent a Car

    4. Return a Car

    5. Delete a Car

    6. Owner Dashboard

    7. Show Stats

    8. Save Data

    9. Exit

           ↓

    User enters choice (ch)

           ↓

    Switch/If-else logic

           ↓

    Execute corresponding method

```

  

---

  

### **Flow 1: Register Car (Option 1)**

  

```

User selects: 1

    ↓

system.addCar() called

    ↓

Car c; (creates new Car object)

    ↓

c.input() called

    ├─→ cin.ignore() - clear input buffer

    ├─→ Prompt: "Enter Owner Name"

    ├─→ getline(cin, ownerName)

    ├─→ Prompt: "Enter Car Model"

    ├─→ getline(cin, model)

    ├─→ Prompt: "Enter Registration Number"

    ├─→ getline(cin, regno)

    ├─→ Prompt: "Enter Rent per Day"

    ├─→ cin >> rentPerDay

    └─→ Display: "Car Registered Successfully"

    ↓

cars.push_back(c) - add to vector

    ↓

Return to main menu

```

  

**Internal State After Registration**:

```

cars vector: [Car1, Car2, ..., NewCar]

NewCar {

    model: "User entered model"

    regno: "User entered regno"

    ownerName: "User entered owner"

    rentPerDay: User entered value

    totalEarn: 0

    rented: false

    customerName: ""

}

```

  

---

  

### **Flow 2: Show All Cars (Option 2)**

  

```

User selects: 2

    ↓

system.showCars() called

    ↓

Check if cars.size() == 0

    YES → Display: "No cars found"

    NO  → Continue

    ↓

Display header:

"Model    RegNo    Owner    Status    Rent/day    Earnings"

"----------------------------------------------------------"

    ↓

Loop: for (i = 0; i < cars.size(); i++)

    ↓

    cars[i].show() for each car

        ↓

        Display: model | regno | owner | status | rentPerDay | totalEarn

    ↓

Return to main menu

```

  

**Example Output**:

```

Model           RegNo       Owner         Status      Rent/day    Earnings

------------------------------------------------------------------------

Toyota Camry    ABC123      John Doe      Available   50          0

Honda Civic     XYZ789      Jane Smith    Rented      45          135

```

  

---

  

### **Flow 3: Rent a Car (Option 3)**

  

```

User selects: 3

    ↓

system.rentCar() called

    ↓

Step 1: showCars() - display all available cars

    ↓

Step 2: Prompt "Enter Registration Number to rent"

    ↓

Step 3: cin >> r (registration number)

    ↓

Step 4: Search loop through cars vector

    for (i = 0; i < cars.size(); i++)

        if (cars[i].getReg() == r)

            ↓

            Found car! Check availability

            ↓

            if (cars[i].isRented() == true)

                ↓

                Display: "Sorry, this car is already rented"

                Return to menu

            else

                ↓

                Car is available, proceed to rental

                ↓

Step 5: Prompt "Enter number of days"

    ↓

Step 6: cin >> days

    ↓

Step 7: Calculate total rent

    totalRent = days × cars[i].getRentPerDay()

    ↓

Step 8: Display total rent

    "Total Rent = " + totalRent

    ↓

Step 9: Prompt "Do you want to confirm? (y/n)"

    ↓

Step 10: cin >> confirm

    ↓

    if (confirm == 'y' || confirm == 'Y')

        ↓

        cars[i].rent(days) called

            ↓

            Inside rent() method:

            ├─→ amt = days × rentPerDay

            ├─→ totalEarn += amt

            ├─→ rented = true

            └─→ Display: "Car rented successfully"

    else

        ↓

        Display: "Rental cancelled"

    ↓

Return to main menu

```

  

**State Changes During Rental**:

```

BEFORE:

Car {

    regno: "ABC123"

    rented: false

    totalEarn: 0

    customerName: ""

}

  

AFTER (3 days @ $50/day):

Car {

    regno: "ABC123"

    rented: true

    totalEarn: 150

    customerName: "" (not stored in console version)

}

```

  

---

  

### **Flow 4: Return a Car (Option 4)**

  

```

User selects: 4

    ↓

system.returnCar() called

    ↓

Step 1: Prompt "Enter Registration Number to return"

    ↓

Step 2: cin >> r

    ↓

Step 3: Search loop

    for (i = 0; i < cars.size(); i++)

        if (cars[i].getReg() == r)

            ↓

            Found car!

            ↓

            cars[i].ret() called

                ↓

                Inside ret() method:

                ├─→ rented = false

                ├─→ customerName = ""

                └─→ Display: "Car returned successfully"

            ↓

            Return to menu

    ↓

If not found: Display "Car not found"

    ↓

Return to main menu

```

  

**State Changes During Return**:

```

BEFORE:

Car {

    regno: "ABC123"

    rented: true

    totalEarn: 150

}

  

AFTER:

Car {

    regno: "ABC123"

    rented: false

    totalEarn: 150  (earnings preserved!)

}

```

  

---

  

### **Flow 5: Delete a Car (Option 5)**

  

```

User selects: 5

    ↓

system.deleteCar() called

    ↓

Step 1: Prompt "Enter Registration Number to delete"

    ↓

Step 2: cin >> r

    ↓

Step 3: Search loop

    for (i = 0; i < cars.size(); i++)

        if (cars[i].getReg() == r)

            ↓

            Found car!

            ↓

            cars.erase(cars.begin() + i)

                ↓

                Vector resizes automatically

                ↓

                All elements after index i shift left

            ↓

            Display: "Car deleted successfully"

            Return

    ↓

If not found: Display "Car not found"

    ↓

Return to main menu

```

  

**Vector Changes**:

```

BEFORE: [Car0, Car1, Car2, Car3]

DELETE: Car1 (index 1)

AFTER:  [Car0, Car2, Car3]

         (Car2 moves to index 1, Car3 moves to index 2)

```

  

---

  

### **Flow 6: Owner Dashboard (Option 6)**

  

```

User selects: 6

    ↓

system.ownerDashboard() called

    ↓

Step 1: cin.ignore() - clear input buffer

    ↓

Step 2: Prompt "Enter Owner Name"

    ↓

Step 3: getline(cin, name)

    ↓

Step 4: Initialize counters

    count = 0

    earn = 0

    ↓

Step 5: Loop through all cars

    for (i = 0; i < cars.size(); i++)

        if (cars[i].getOwner() == name)

            ↓

            Match found!

            ├─→ count++

            └─→ earn += cars[i].getEarn()

    ↓

Step 6: Display results

    "Owner: " + name

    "Total Cars: " + count

    "Total Earnings: " + earn

    ↓

Return to main menu

```

  

**Example Calculation**:

```

Owner "John Doe" has 3 cars:

Car1: totalEarn = 150

Car2: totalEarn = 200

Car3: totalEarn = 100

  

Result:

Total Cars: 3

Total Earnings: 450

```

  

---

  

### **Flow 7: Show Stats (Option 7)**

  

```

User selects: 7

    ↓

system.showStats() called

    ↓

Step 1: Get total = cars.size()

    ↓

Step 2: Initialize counters

    rented = 0

    earnings = 0

    ↓

Step 3: Loop through all cars

    for (i = 0; i < cars.size(); i++)

        ├─→ if (cars[i].isRented())

        │       rented++

        └─→ earnings += cars[i].getEarn()

    ↓

Step 4: Display statistics

    "Total Cars in System: " + total

    "Currently Rented Cars: " + rented

    "Total System Earnings: " + earnings

    ↓

Return to main menu

```

  

**Calculation Logic**:

```

System has 5 cars:

Car1: rented=false, earn=100

Car2: rented=true,  earn=150

Car3: rented=false, earn=0

Car4: rented=true,  earn=200

Car5: rented=false, earn=50

  

Result:

Total Cars: 5

Rented Cars: 2

Total Earnings: 500

```

  

---

  

### **Flow 8: Save Data (Option 8)**

  

```

User selects: 8

    ↓

system.saveData() called

    ↓

Step 1: Open file

    ofstream f("cars.txt")

    ↓

Step 2: Loop through all cars

    for (i = 0; i < cars.size(); i++)

        ↓

        Write to file:

        f << cars[i].getModel() << "|"

          << cars[i].getReg() << "|"

          << cars[i].getOwner() << "|"

          << cars[i].getRentPerDay() << "|"

          << cars[i].getEarn() << "|"

          << cars[i].isRented() << "|"

          << cars[i].getCustomer() << "\n"

    ↓

Step 3: Close file

    f.close()

    ↓

Step 4: Display "Data saved successfully"

    ↓

Return to main menu

```

  

**File Output Example** (`cars.txt`):

```

Toyota Camry|ABC123|John Doe|50|150|1|Alice

Honda Civic|XYZ789|Jane Smith|45|0|0|

BMW X5|BMW555|Mike Johnson|120|360|1|Bob

```

  

---

  

### **Flow 9: Exit (Option 9)**

  

```

User selects: 9

    ↓

Before exit:

    system.saveData() - automatically save all data

        ↓

        (Same process as Flow 8)

    ↓

Display: "Exiting..."

    ↓

Loop condition (ch != 9) becomes false

    ↓

Program exits

    return 0;

```

  

---

  

## Complete Program Execution Timeline

  

```

TIME 0: Program Start

    ├─→ Create RentalSystem object

    ├─→ Call loadData()

    │   ├─→ Read cars.txt

    │   └─→ Load 6 cars into memory

    └─→ Display menu

  

TIME 1: User enters "1" (Register Car)

    ├─→ Call addCar()

    ├─→ User inputs car details

    └─→ New car added to vector (now 7 cars)

  

TIME 2: User enters "2" (Show All Cars)

    ├─→ Call showCars()

    └─→ Display all 7 cars

  

TIME 3: User enters "3" (Rent Car)

    ├─→ Call rentCar()

    ├─→ User selects "ABC123" for 3 days

    ├─→ Rental confirmed

    └─→ Car ABC123: rented=true, earnings+=150

  

TIME 4: User enters "7" (Show Stats)

    ├─→ Call showStats()

    └─→ Display: Total=7, Rented=1, Earnings=150

  

TIME 5: User enters "8" (Save Data)

    ├─→ Call saveData()

    └─→ All 7 cars written to cars.txt

  

TIME 6: User enters "9" (Exit)

    ├─→ Call saveData() (auto-save)

    ├─→ Display "Exiting..."

    └─→ Program terminates

```

  

---

  

## Memory Management Flow

  

### **Vector Operations**

  

```

Initial State (after loadData):

cars vector capacity: 6

cars[0] = Car("Toyota Camry", ...)

cars[1] = Car("Honda Civic", ...)

...

cars[5] = Car("Audi A4", ...)

  

After addCar():

cars vector capacity: auto-increased (usually doubles)

cars[6] = Car(new car data)

  

After deleteCar("ABC123"):

cars vector capacity: same, but size decreases

Elements shift to fill gap

```

  

### **Object Lifecycle**

  

```

1. Car Construction

   ↓

   Car() constructor called

   ├─→ rentPerDay = 0

   ├─→ totalEarn = 0

   ├─→ rented = false

   └─→ customerName = ""

  

2. Data Population

   ↓

   setData() or input() called

   └─→ All fields populated

  

3. During Use

   ↓

   rent() / ret() modify state

   └─→ Fields updated

  

4. Destruction

   ↓

   When vector is cleared or program exits

   └─→ Automatic cleanup (no manual memory management needed)

```

  

---

  

## Error Handling Flow

  

### **Car Not Found Scenario**

  

```

User tries to rent car "XYZ999"

    ↓

rentCar() called

    ↓

Search loop runs through entire vector

    ↓

    for (i = 0; i < cars.size(); i++)

        if (cars[i].getReg() == "XYZ999")  // Never matches

    ↓

Loop completes without finding match

    ↓

Display: "Car not found"

    ↓

Return to menu (no crash, graceful handling)

```

  

### **Already Rented Scenario**

  

```

User tries to rent already rented car

    ↓

rentCar() finds the car

    ↓

Check: if (cars[i].isRented())

    ↓

    TRUE → Display "Sorry, this car is already rented"

    ↓

    Return early (prevents double booking)

    ↓

Back to menu

```

  

### **File Not Found Scenario**

  

```

Program starts, cars.txt doesn't exist

    ↓

loadData() called

    ↓

ifstream f("cars.txt")

    ↓

if (!f) → File doesn't exist

    ↓

    Return silently (no error message)

    ↓

cars vector remains empty

    ↓

Program continues normally

    ↓

User can still add cars manually

```

  

---

  

## Design Patterns Used

  

1. **Manager Pattern**: RentalSystem manages collection of Cars

2. **Data Transfer Object**: Car class acts as DTO

3. **Repository Pattern**: RentalSystem handles data persistence

4. **Template Method**: Common operations with different implementations (console vs API)

  

---

  

## Advantages of This Design

  

1. **Code Reusability**: Same header for console and web

2. **Maintainability**: Changes in one place affect both applications

3. **Separation of Concerns**: Each class has single responsibility

4. **Data Persistence**: File handling preserves state

5. **Scalability**: Easy to add new features

6. **Type Safety**: Strong typing prevents errors

  

---

  

## Usage Examples

  

### **Example 1: Console App**

```cpp

RentalSystem sys;

sys.loadData();

sys.addCar();      // User registers a car

sys.showCars();    // Display all

sys.rentCar();     // Rent interactively

sys.saveData();    // Save before exit

```

  

### **Example 2: Web API**

```cpp

RentalSystem sys;

sys.loadData();

string carsJSON = sys.getAllCarsJSON();  // GET /api/cars

bool ok = sys.rentCarAPI("ABC123", 3, "John");  // POST /api/rent

sys.saveData();

```

  

---

  

## Future Enhancements

  

1. **Database Integration**: Replace file I/O with SQL

2. **Validation**: Check duplicate registration numbers

3. **Authentication**: Add user login system

4. **Payment Gateway**: Integrate online payments

5. **Date Tracking**: Store rental start/end dates

6. **Search & Filter**: Advanced car search

7. **Notifications**: Email/SMS for rentals

8. **Ratings**: Car and owner rating system

  

---

  

## Conclusion

  

`rental_system.h` is a well-structured, reusable header file that demonstrates solid OOP principles and provides both console and web functionality. It serves as an excellent foundation for a complete car rental management system.