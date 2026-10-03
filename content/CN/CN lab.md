# Assignment 1

```cpp
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// Draw Graph
void drawGraph(const vector<int>& levels)
{
    cout << "\nWaveform:\n\n";

    // +V
    cout << "+V ";
    for(int x : levels)
    {
        if(x == 1)
            cout << "──── ";
        else
            cout << "     ";
    }
    cout << endl;

    // 0V
    cout << "0V ";
    for(int x : levels)
    {
        if(x == 0)
            cout << "──── ";
        else
            cout << "     ";
    }
    cout << endl;

    // -V
    cout << "-V ";
    for(int x : levels)
    {
        if(x == -1)
            cout << "──── ";
        else
            cout << "     ";
    }
    cout << endl;

    cout << "\nBits ";
    for(int i=0;i<levels.size();i++)
        cout << " " << i+1 << "   ";
    cout << endl;
}

// Polar NRZ-L
void polarNRZL(string bits)
{
    vector<int> level;

    cout << "\nPolar NRZ-L Encoding:\n";

    for(char b : bits)
    {
        if(b=='1')
        {
            cout << "+V ";
            level.push_back(1);
        }
        else
        {
            cout << "-V ";
            level.push_back(-1);
        }
    }

    cout << endl;
    drawGraph(level);
}

// Polar NRZ-I
void polarNRZI(string bits)
{
    vector<int> level;

    cout << "\nPolar NRZ-I Encoding:\n";

    int current = -1;

    for(char b : bits)
    {
        if(b=='1')
            current = -current;

        level.push_back(current);

        if(current==1)
            cout << "+V ";
        else
            cout << "-V ";
    }

    cout << endl;
    drawGraph(level);
}

// Unipolar NRZ
void unipolarNRZ(string bits)
{
    vector<int> level;

    cout << "\nUnipolar NRZ Encoding:\n";

    for(char b : bits)
    {
        if(b=='1')
        {
            cout << "+V ";
            level.push_back(1);
        }
        else
        {
            cout << "0 ";
            level.push_back(0);
        }
    }

    cout << endl;
    drawGraph(level);
}

// Bipolar AMI
void bipolarAMI(string bits)
{
    vector<int> level;

    cout << "\nBipolar (AMI) Encoding:\n";

    int last = -1;

    for(char b : bits)
    {
        if(b=='0')
        {
            cout << "0 ";
            level.push_back(0);
        }
        else
        {
            last = -last;
            level.push_back(last);

            if(last==1)
                cout << "+V ";
            else
                cout << "-V ";
        }
    }

    cout << endl;
    drawGraph(level);
}

// Manchester
void manchester(string bits)
{
    cout << "\nManchester Encoding:\n";

    for(char b : bits)
    {
        if(b=='1')
            cout << "LH ";
        else
            cout << "HL ";
    }

    cout << "\n\n(Note: Manchester uses two signal levels per bit,\n";
    cout << "so this simple graph is not applicable.)\n";
}

// Differential Manchester
void differentialManchester(string bits)
{
    cout << "\nDifferential Manchester Encoding:\n";

    bool high = true;

    for(char b : bits)
    {
        if(b=='0')
            high = !high;

        if(high)
            cout << "HL ";
        else
            cout << "LH ";

        high = !high;
    }

    cout << "\n\n(Note: Differential Manchester also uses two\n";
    cout << "transitions per bit, so this graph is omitted.)\n";
}

int main()
{
    int choice;
    string bits;

    do
    {
        cout << "\n========== Line Encoding Menu ==========\n";
        cout << "1. Unipolar NRZ\n";
        cout << "2. Polar NRZ-L\n";
        cout << "3. Polar NRZ-I\n";
        cout << "4. Bipolar (AMI)\n";
        cout << "5. Manchester\n";
        cout << "6. Differential Manchester\n";
        cout << "7. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        if(choice>=1 && choice<=6)
        {
            cout << "Enter binary data: ";
            cin >> bits;
        }

        switch(choice)
        {
            case 1: unipolarNRZ(bits); break;
            case 2: polarNRZL(bits); break;
            case 3: polarNRZI(bits); break;
            case 4: bipolarAMI(bits); break;
            case 5: manchester(bits); break;
            case 6: differentialManchester(bits); break;
            case 7: cout << "Program Terminated.\n"; break;
            default: cout << "Invalid Choice!\n";
        }

    } while(choice!=7);

    return 0;
}
```

```cpp
#include <iostream>
#include <string>
#include <vector>
using namespace std;

void drawGraph(const vector<int>& levels)
{
    cout << "\nWaveform:\n\n";

    cout << "+V ";
    for (int x: levels) cout << (x==1 ? "──── " : "     ");
    cout << "\n";

    cout << "0V ";
    for (int x: levels) cout << (x==0 ? "──── " : "     ");
    cout << "\n";

    cout << "-V ";
    for (int x: levels) cout << (x==-1 ? "──── " : "     ");
    cout << "\n\nBits ";
    for (size_t i=0;i<levels.size();i++) cout << " " << i+1 << "   ";
    cout << "\n";
}

void drawManchester(string bits)
{
    cout << "\nManchester Graph\n\n";
    cout << "+V ";
    for(char b:bits) cout << (b=='0' ? "────      " : "     ──── ");
    cout << "\n";
    cout << "-V ";
    for(char b:bits) cout << (b=='1' ? "────      " : "     ──── ");
    cout << "\n";
}

void drawDifferentialManchester(string bits)
{
    bool high=true;
    vector<int> lvl;
    for(char b:bits){
        if(b=='0') high=!high;
        lvl.push_back(high?1:-1);
        high=!high;
        lvl.push_back(high?1:-1);
    }

    cout<<"\nDifferential Manchester Graph\n\n";
    cout<<"+V ";
    for(int x:lvl) cout<<(x==1?"── ":"   ");
    cout<<"\n";
    cout<<"-V ";
    for(int x:lvl) cout<<(x==-1?"── ":"   ");
    cout<<"\n";
}

void unipolarNRZ(string bits){
    vector<int> l;
    cout<<"\nUnipolar NRZ:\n";
    for(char b:bits){
        if(b=='1'){ cout<<"+V "; l.push_back(1);}
        else { cout<<"0 "; l.push_back(0);}
    }
    cout<<"\n";
    drawGraph(l);
}

void polarNRZL(string bits){
    vector<int> l;
    cout<<"\nPolar NRZ-L:\n";
    for(char b:bits){
        if(b=='1'){ cout<<"+V "; l.push_back(1);}
        else { cout<<"-V "; l.push_back(-1);}
    }
    cout<<"\n";
    drawGraph(l);
}

void polarNRZI(string bits)
{
    vector<int> l;
    int cur = -1;

    cout << "\nPolar NRZ-I:\n";

    for(char b : bits)
    {
        if(b == '1')
        {
            cur = -cur;
        }

        l.push_back(cur);

        if(cur == 1)
        {
            cout << "+V ";
        }
        else
        {
            cout << "-V ";
        }
    }

    cout << "\n";
    drawGraph(l);
}

void bipolarAMI(string bits)
{
    vector<int> level;
    int last = -1;

    cout << "\nBipolar AMI:\n";

    for(char b : bits)
    {
        if(b == '0')
        {
            cout << "0 ";
            level.push_back(0);
        }
        else
        {
            last = -last;
            level.push_back(last);

            if(last == 1)
            {
                cout << "+V ";
            }
            else
            {
                cout << "-V ";
            }
        }
    }

    cout << "\n";
    drawGraph(level);
}

void manchester(string bits)
{
    cout << "\nManchester:\n";

    for(char b : bits)
    {
        if(b == '1')
        {
            cout << "LH ";
        }
        else
        {
            cout << "HL ";
        }
    }

    cout << "\n";

    drawManchester(bits);
}

void differentialManchester(string bits)
{
    cout << "\nDifferential Manchester:\n";

    bool high = true;

    for(char b : bits)
    {
        // For bit 0, change level at the beginning
        if(b == '0')
        {
            high = !high;
        }

        // Print the two halves of the bit
        if(high == true)
        {
            cout << "HL ";
        }
        else
        {
            cout << "LH ";
        }

        // Always change level in the middle
        high = !high;
    }

    cout << "\n";

    drawDifferentialManchester(bits);
}

int main(){
    int ch;
    string bits;
    do{
        cout<<"\n1.Unipolar NRZ\n2.Polar NRZ-L\n3.Polar NRZ-I\n4.Bipolar AMI\n5.Manchester\n6.Differential Manchester\n7.Exit\nChoice: ";
        cin>>ch;
        if(ch>=1 && ch<=6){
            cout<<"Enter binary data: ";
            cin>>bits;
        }
        switch(ch){
            case 1: unipolarNRZ(bits); break;
            case 2: polarNRZL(bits); break;
            case 3: polarNRZI(bits); break;
            case 4: bipolarAMI(bits); break;
            case 5: manchester(bits); break;
            case 6: differentialManchester(bits); break;
            case 7: cout<<"Bye\n"; break;
            default: cout<<"Invalid\n";
        }
    }while(ch!=7);
    return 0;
}
```

# Assignment 2
### switch and router configuartion using cisco packet tracker

```

```


```
interface GigabitEthernet0/0/0
ip address 192.168.5.1 255.255.255.0
no shutdown
exit

interface GigabitEthernet0/0/1
ip address 192.168.6.1 255.255.255.0
no shutdown
exit


write


show ip interface brief

```


# Asssingment 3 

Write the program for error detection and correction for 7 or 8 bit ascii code using humming and crc. Demorates the packet captures using wire shark packet analyser tool
```cpp
#include <iostream>
#include <string>
using namespace std;

int main()
{
    string frame, generator;

    cout << "Enter frame: ";
    cin >> frame;

    cout << "Enter generator: ";
    cin >> generator;

    int genLen = generator.length();

    // Append zeros to the frame
    string temp = frame + string(genLen - 1, '0');

    // CRC division
    for (int i = 0; i <= temp.length() - genLen; i++)
    {
        // Only perform XOR if current bit is 1
        if (temp[i] == '1')
        {
            for (int j = 0; j < genLen; j++)
            {
                temp[i + j] =
                    (temp[i + j] == generator[j]) ? '0' : '1';
            }
        }
    }

    // Last (genLen - 1) bits are the remainder
    string remainder = temp.substr(temp.length() - (genLen - 1));

    // Transmitted frame = original frame + remainder
    string transmittedFrame = frame + remainder;

    cout << "\nRemainder: " << remainder << endl;
    cout << "Transmitted frame: " << transmittedFrame << endl;

    return 0;
}
```



```cpp

#include <iostream>
#include <string>
using namespace std;

int main()
{
    string data;

    cout << "Enter 4-bit data: ";
    cin >> data;

    if (data.length() != 4 ||
        data.find_first_not_of("01") != string::npos)
    {
        cout << "Invalid input! Enter exactly 4 binary bits." << endl;
        return 1;
    }

    // Hamming (7,4) code
    // Parity bits at positions 1, 2 and 4
    // Data bits at positions 3, 5, 6 and 7
    string code(7, '0');

    code[2] = data[0];
    code[4] = data[1];
    code[5] = data[2];
    code[6] = data[3];

    // Calculate even parity bits
    code[0] = ((code[2] - '0') ^
               (code[4] - '0') ^
               (code[6] - '0')) + '0';

    code[1] = ((code[2] - '0') ^
               (code[5] - '0') ^
               (code[6] - '0')) + '0';

    code[3] = ((code[4] - '0') ^
               (code[5] - '0') ^
               (code[6] - '0')) + '0';

    cout << "\nGenerated Hamming Code: " << code << endl;

    // Receiver side
    string received;

    cout << "Enter received 7-bit code: ";
    cin >> received;

    if (received.length() != 7 ||
        received.find_first_not_of("01") != string::npos)
    {
        cout << "Invalid input! Enter exactly 7 binary bits." << endl;
        return 1;
    }

    // Calculate syndrome bits
    int s1 = (received[0] - '0') ^
             (received[2] - '0') ^
             (received[4] - '0') ^
             (received[6] - '0');

    int s2 = (received[1] - '0') ^
             (received[2] - '0') ^
             (received[5] - '0') ^
             (received[6] - '0');

    int s4 = (received[3] - '0') ^
             (received[4] - '0') ^
             (received[5] - '0') ^
             (received[6] - '0');

    int errorPosition = s1 + (s2 * 2) + (s4 * 4);

    if (errorPosition == 0)
    {
        cout << "No error detected." << endl;
    }
    else
    {
        cout << "Error detected at position: "
             << errorPosition << endl;

        // Correct the erroneous bit
        received[errorPosition - 1] =
            (received[errorPosition - 1] == '0') ? '1' : '0';

        cout << "Corrected Hamming Code: "
             << received << endl;
    }

    // Extract original 4-bit data
    string correctedData = "";
    correctedData += received[2];
    correctedData += received[4];
    correctedData += received[5];
    correctedData += received[6];

    cout << "Recovered Data: " << correctedData << endl;

    return 0;
}
```
Example 
If the frame is `1101011011`  and generator is `x^4 + x + x` what would be the transmitted framex

# Assingment 4 

![[Screenshot From 2026-08-31 14-48-51.png]]

![[Screenshot From 2026-08-31 14-50-55.png]]

![[Screenshot From 2026-08-31 14-51-15.png]]





# Assingment 4 Wire shark and socket Programming

1bit ARQ
go back n
Selective r

Use time bound operation, use time function in java, the frame has to be transmitted in that time, and if the time has passed the frame is gone - for are

For the rest two - the no of frames / window size should depend the data, do not hardcode it




### For 1 bit

Sequence should be 0,1,0,1


## [[Client-Server Code]]


## [[what is this assingment 4]]




---


# Assingment 5

write the program using tcp socket primitive for wired or wireless network for the following 

1. Say hello to each oother
2. file transfer
3. Arithmentic Calculator
4. Trigometric Calculator


`/home/parag/Documents/CN/Assingment5`

# ![[CN-Assin_5]]

---

# Assingment 6

Write the program using UDP socket to enable text script audio and video file between two machines 
Demostrate the packet capture using wire shark 
