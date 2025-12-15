---
title: Untitled
date: 2025-11-29
tags: 
---
# 1. Implement basic string operations such as length calculation, copy, reverse, and concatenation using character single dimensional arrays without using built-in string library functions.**
```cpp
#include <iostream>
using namespace std;

// Function to calculate length of string
int stringLength(char str[]) {
    int length = 0;
    while (str[length] != '\0') {
        length++;
    }
    return length;
}

// Function to copy one string to another
void stringCopy(char dest[], char src[]) {
    int i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0'; // Null terminate
}

// Function to reverse a string
void stringReverse(char str[]) {
    int len = stringLength(str);
    int start = 0, end = len - 1;

    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        start++;
        end--;
    }
}

// Function to concatenate two strings
void stringConcat(char str1[], char str2[]) {
    int i = stringLength(str1);
    int j = 0;

    while (str2[j] != '\0') {
        str1[i] = str2[j];
        i++;
        j++;
    }
    str1[i] = '\0'; // Null terminate
}

int main() {
    char str1[100], str2[100], copied[100];

    cout << "Enter first string: ";
    cin >> str1;

    cout << "Enter second string: ";
    cin >> str2;

    cout << "\nLength of first string: " << stringLength(str1);

    stringCopy(copied, str1);
    cout << "\nCopied string: " << copied;

    stringReverse(str1);
    cout << "\nReversed first string: " << str1;

    stringConcat(copied, str2);
    cout << "\nConcatenated string: " << copied;

    return 0;
}

```

# 2. Write a program to construct and verify a magic square of order 'n' (for both even & odd) such that all rows, columns, and diagonals sum to the same value.
```cpp
#include <iostream>
#include <vector>
using namespace std;

// -----------------------------------------------------
// Verify if magic square is correct
bool verifyMagicSquare(vector<vector<int>>& m, int n) {
    int sum = 0;

    // Reference sum = sum of first row
    for (int j = 0; j < n; j++)
        sum += m[0][j];

    // Check rows
    for (int i = 0; i < n; i++) {
        int rsum = 0;
        for (int j = 0; j < n; j++)
            rsum += m[i][j];
        if (rsum != sum) return false;
    }

    // Check columns
    for (int j = 0; j < n; j++) {
        int csum = 0;
        for (int i = 0; i < n; i++)
            csum += m[i][j];
        if (csum != sum) return false;
    }

    // Check diagonals
    int d1 = 0, d2 = 0;
    for (int i = 0; i < n; i++) {
        d1 += m[i][i];
        d2 += m[i][n - i - 1];
    }
    return (d1 == sum && d2 == sum);
}

// -----------------------------------------------------
// Odd-order magic square (Siamese method)
vector<vector<int>> oddMagic(int n) {
    vector<vector<int>> m(n, vector<int>(n, 0));

    int i = 0, j = n / 2;

    for (int num = 1; num <= n * n; num++) {
        m[i][j] = num;

        int ni = (i - 1 + n) % n;
        int nj = (j + 1) % n;

        if (m[ni][nj] != 0)
            i = (i + 1) % n;
        else {
            i = ni;
            j = nj;
        }
    }
    return m;
}

// -----------------------------------------------------
// Doubly even magic square (n % 4 == 0)
vector<vector<int>> doublyEvenMagic(int n) {
    vector<vector<int>> m(n, vector<int>(n, 0));
    int x = 1, y = n * n;

    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if ((i % 4 == j % 4) || ((i % 4) + (j % 4) == 3))
                m[i][j] = y--;
            else
                m[i][j] = x++;

    return m;
}

// -----------------------------------------------------
// Singly even magic square (Strachey method)
vector<vector<int>> singlyEvenMagic(int n) {
    int h = n / 2;
    int sub = h * h;

    vector<vector<int>> m(n, vector<int>(n));
    vector<vector<int>> small = oddMagic(h);

    // Fill 4 sub-squares
    for (int i = 0; i < h; i++) {
        for (int j = 0; j < h; j++) {
            m[i][j] = small[i][j];
            m[i][j + h] = small[i][j] + 2 * sub;
            m[i + h][j] = small[i][j] + 3 * sub;
            m[i + h][j + h] = small[i][j] + sub;
        }
    }

    // Swap required columns
    int k = (n - 2) / 4;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < k; j++)
            swap(m[i][j], m[i + h][j]);

        for (int j = n - k + 1; j < n; j++)
            swap(m[i][j], m[i + h][j]);
    }

    // Special middle swap
    swap(m[k][0], m[k + h][0]);

    return m;
}

// -----------------------------------------------------
int main() {
    int n;
    cout << "Enter order of Magic Square (n): ";
    cin >> n;

    if (n < 3) {
        cout << "Magic square not possible for n < 3";
        return 0;
    }

    vector<vector<int>> magic;

    if (n % 2 == 1)
        magic = oddMagic(n);
    else if (n % 4 == 0)
        magic = doublyEvenMagic(n);
    else
        magic = singlyEvenMagic(n);

    // Print Magic Square
    cout << "\nMagic Square (" << n << "x" << n << "):\n";
    for (auto &row : magic) {
        for (auto val : row)
            cout << val << "\t";
        cout << endl;
    }

    // Verification
    cout << "\nVerification: ";
    if (verifyMagicSquare(magic, n))
        cout << "Magic Square is CORRECT!";
    else
        cout << "Magic Square is INCORRECT!";

    return 0;
}

```
# 3. Develop a program to identify and efficiently store a sparse matrix using compact representation and perform basic operations like display and simple transpose.
```cpp
#include<iostream>
using namespace std;
int main(){
    int rows, cols;
    cout << "Enter the no of rows and cols : ";
    cin >> rows >> cols;
    int a[20][20];
    for(int i = 0; i < rows ; i++){
        for(int j = 0; j < cols ; j++){
            cin >> a[i][j];
        }
    }
    for(int i = 0; i < rows ; i++){
        for(int j = 0; j < cols ; j++){
            cout << a[i][j] << " ";
            }
            cout << endl;
    }
    int k = 1;
    int sparse[20][3];
    sparse[0][0] = rows;
    sparse[0][1] = cols;
    for(int i = 0 ; i < rows; i++){
        for(int j = 0 ; j < cols; j++){
            if(a[i][j]){
                sparse[k][0] = i;
                sparse[k][1] = j;
                sparse[k][2] = a[i][j];
                k++;
            }
        }
    }

    sparse[0][2] = k-1;
    cout << "sparse matrix is " << endl;
    for(int i = 0 ; i <= sparse[0][2] ; i++){
        cout << sparse[i][0] << " " <<  sparse[i][1] << " "<<  sparse[i][2] ;
        cout << endl;
    }
    cout << "--------------------------------------------------" << endl;
    cout << "Transpase of this matrix is " << endl;
    for(int i = 0 ; i <= sparse[0][2]; i++){
        int temp = sparse[i][0];
        sparse[i][0] = sparse[i][1];
        sparse[i][1] = temp;
    }
    for(int i = 0 ; i <= sparse[0][2] ; i++){
        cout << sparse[i][0] << " " <<  sparse[i][1] << " "<<  sparse[i][2] ;
        cout << endl;
    }
}
```

# 4. Develop a program to compute the fast transpose of a sparse matrix using its compact (triplet) representation efficiently.
```cpp
#include <iostream>
using namespace std;

int main() {
    int rows, cols;

    cout << "Enter number of rows and columns: ";
    cin >> rows >> cols;

    int a[20][20];
    cout << "Enter matrix:\n";
    for(int i = 0; i < rows; i++)
        for(int j = 0; j < cols; j++)
            cin >> a[i][j];

    // ---------- Build Sparse Matrix (Triplet Form) ----------
    int sparse[400][3];
    int k = 1;   // index for sparse matrix

    sparse[0][0] = rows;
    sparse[0][1] = cols;

    for(int i = 0 ; i < rows ; i++){
        for(int j = 0 ; j < cols ; j++){
            if(a[i][j] != 0){
                sparse[k][0] = i;       // row
                sparse[k][1] = j;       // col
                sparse[k][2] = a[i][j]; // value
                k++;
            }
        }
    }
    sparse[0][2] = k - 1;    // number of non-zero elements

    cout << "\nSparse Matrix (Triplet Representation):\n";
    for(int i = 0; i < k; i++)
        cout << sparse[i][0] << "  "
             << sparse[i][1] << "  "
             << sparse[i][2] << endl;

    // ---------- FAST TRANSPOSE ----------
    int t[400][3];
    int n = sparse[0][2];   // number of non-zero elements
    int r = sparse[0][0];
    int c = sparse[0][1];

    t[0][0] = c;
    t[0][1] = r;
    t[0][2] = n;

    // count number of elements in each column
    int count[50] = {0};
    for(int i = 1; i <= n; i++)
        count[sparse[i][1]]++;

    // starting position of each column in transposed sparse matrix
    int index[50];
    index[0] = 1;

    for(int i = 1; i < c; i++)
        index[i] = index[i - 1] + count[i - 1];

    // place the elements in transposed matrix using fast method
    for(int i = 1; i <= n; i++){
        int col = sparse[i][1];
        int pos = index[col];

        t[pos][0] = sparse[i][1];
        t[pos][1] = sparse[i][0];
        t[pos][2] = sparse[i][2];

        index[col]++;
    }

    // ---------- Print Transposed Matrix ----------
    cout << "\nFast Transpose of Sparse Matrix:\n";
    for(int i = 0; i <= n; i++)
        cout << t[i][0] << "  "
             << t[i][1] << "  "
             << t[i][2] << endl;

    return 0;
}

```

#  5. Identify a student of S.Y. div (X) whose name is “XYZ” and roll no. is “17” using an appropriate searching method.
```cpp
#include<iostream>
using namespace std;

struct student {
    int rollno;
    char name[50];
};

int main() {
    student s[50];
    int n;

    cout << "Enter the no students you wanted to enter : ";
    cin >> n;

    for(int i = 0; i < n ; i++) {
        cout << "Enter the details for " << i+1 << " student (rollno name): ";
        cin >> s[i].rollno >> s[i].name;
    }

    cout << "\nStudent List:\n";
    for(int i = 0; i < n ; i++) {
        cout << s[i].rollno << " " << s[i].name << endl;
    }

    int start = 0, end = n - 1;
    int target;
    cout << "Enter target : ";
    cin >> target;
    bool found = false;

    while(start <= end) {
        int mid = (start + end) / 2;

        if(target == s[mid].rollno) {
            cout << "\nStudent found!\n";
            cout << "Roll No: " << s[mid].rollno << endl;
            cout << "Name: " << s[mid].name << endl;
            found = true;
            break;
        }
        else if(target > s[mid].rollno) {
            start = mid + 1;
        }
        else {
            end = mid - 1;
        }
    }

    if(!found)
        cout << "\nStudent NOT found.";

    return 0;
}

```

# 6. Write a program to input marks of n students Sort the marks in ascending order using the Quick Sort algorithm without using built-in library functions and analyse the sorting algorithm pass by pass. Find the minimum and maximum marks using Divide and Conquer (recursively).
```cpp
#include <iostream>
using namespace std;

// ---------- Utility to print array ----------
void printArray(int a[], int n) {
    for (int i = 0; i < n; i++)
        cout << a[i] << " ";
    cout << endl;
}

// ---------- Quick Sort (with pass-by-pass analysis) ----------
int passNo = 1;  // global pass counter

int partitionArr(int a[], int low, int high, int n) {
    int pivot = a[high];           // choose last element as pivot
    int i = low - 1;               // index of smaller element

    for (int j = low; j < high; j++) {
        if (a[j] <= pivot) {
            i++;
            // swap a[i] and a[j]
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
    }

    // place pivot at correct position
    int temp = a[i + 1];
    a[i + 1] = a[high];
    a[high] = temp;

    // Print array after this partition = one pass
    cout << "After Pass " << passNo++ << ": ";
    printArray(a, n);

    return (i + 1);  // pivot index
}

void quickSort(int a[], int low, int high, int n) {
    if (low < high) {
        int pi = partitionArr(a, low, high, n);

        // Recursively sort left and right parts
        quickSort(a, low, pi - 1, n);
        quickSort(a, pi + 1, high, n);
    }
}

// ---------- Divide and Conquer Min & Max ----------
void findMinMax(int a[], int low, int high, int &minVal, int &maxVal) {
    // If only one element
    if (low == high) {
        minVal = maxVal = a[low];
        return;
    }

    // If two elements
    if (high == low + 1) {
        if (a[low] < a[high]) {
            minVal = a[low];
            maxVal = a[high];
        } else {
            minVal = a[high];
            maxVal = a[low];
        }
        return;
    }

    // More than two elements: divide
    int mid = (low + high) / 2;

    int min1, max1;
    int min2, max2;

    // Left half
    findMinMax(a, low, mid, min1, max1);
    // Right half
    findMinMax(a, mid + 1, high, min2, max2);

    // Combine results
    minVal = (min1 < min2) ? min1 : min2;
    maxVal = (max1 > max2) ? max1 : max2;
}

// ---------- main ----------
int main() {
    int n;
    cout << "Enter number of students: ";
    cin >> n;

    int marks[100];

    cout << "Enter marks of " << n << " students:\n";
    for (int i = 0; i < n; i++) {
        cin >> marks[i];
    }

    cout << "\nOriginal Marks: ";
    printArray(marks, n);

    // Quick Sort with pass-by-pass display
    cout << "\n--- Quick Sort Passes ---\n";
    quickSort(marks, 0, n - 1, n);

    cout << "\nSorted Marks (Ascending): ";
    printArray(marks, n);

    // Find min and max using Divide & Conquer
    int minMarks, maxMarks;
    findMinMax(marks, 0, n - 1, minMarks, maxMarks);

    cout << "\nMinimum Marks (Divide & Conquer): " << minMarks << endl;
    cout << "Maximum Marks (Divide & Conquer): " << maxMarks << endl;

    return 0;
}

```

# 7. Write a program using Bubble and Selection sort algorithm, assign the roll nos. to the students of your class as per their previous years result. i.e. topper will be roll no. 1 and analyse the sorting algorithm pass by pass.
```cpp
#include <iostream>
using namespace std;

// Utility to print array
void printArray(int a[], int n) {
    for (int i = 0; i < n; i++)
        cout << a[i] << " ";
    cout << endl;
}

// ---------------- BUBBLE SORT (Descending, with passes) ----------------
void bubbleSort(int a[], int n) {
    cout << "\n--- Bubble Sort Pass by Pass (Descending) ---\n";
    for (int pass = 1; pass < n; pass++) {
        bool swapped = false;
        for (int j = 0; j < n - pass; j++) {
            if (a[j] < a[j + 1]) {   // for descending
                int temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
                swapped = true;
            }
        }
        cout << "After Pass " << pass << ": ";
        printArray(a, n);

        if (!swapped) break; // optimization: stop if already sorted
    }
}

// ---------------- SELECTION SORT (Descending, with passes) ----------------
void selectionSort(int a[], int n) {
    cout << "\n--- Selection Sort Pass by Pass (Descending) ---\n";
    for (int i = 0; i < n - 1; i++) {
        int maxIndex = i;
        for (int j = i + 1; j < n; j++) {
            if (a[j] > a[maxIndex]) {
                maxIndex = j;
            }
        }
        // Swap max element with a[i]
        int temp = a[i];
        a[i] = a[maxIndex];
        a[maxIndex] = temp;

        cout << "After Pass " << (i

```

# 8. Write a program to arrange the list of employees as per the average of their height and weight by using Merge sorting method. Analyse their time complexities and conclude which algorithm will take less time to sort the list.
```cpp
#include <iostream>
using namespace std;

struct Employee {
    string name;
    float height, weight;
    float avg;      // (height + weight) / 2
};

// Merge two halves
void merge(Employee arr[], int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;

    Employee L[n1], R[n2];

    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];

    for (int i = 0; i < n2; i++)
        R[i] = arr[mid + 1 + i];

    int i = 0, j = 0, k = left;

    while (i < n1 && j < n2) {
        if (L[i].avg <= R[j].avg)
            arr[k++] = L[i++];
        else
            arr[k++] = R[j++];
    }

    while (i < n1)
        arr[k++] = L[i++];

    while (j < n2)
        arr[k++] = R[j++];
}

// Merge Sort
void mergeSort(Employee arr[], int left, int right) {
    if (left >= right) return;

    int mid = (left + right) / 2;
    mergeSort(arr, left, mid);
    mergeSort(arr, mid + 1, right);

    merge(arr, left, mid, right);
}

int main() {
    int n;
    cout << "Enter number of employees: ";
    cin >> n;

    Employee emp[n];

    for (int i = 0; i < n; i++) {
        cout << "\nEnter Name: ";
        cin >> emp[i].name;
        cout << "Enter Height: ";
        cin >> emp[i].height;
        cout << "Enter Weight: ";
        cin >> emp[i].weight;

        emp[i].avg = (emp[i].height + emp[i].weight) / 2.0;
    }

    mergeSort(emp, 0, n - 1);

    cout << "\nEmployees sorted by average of height & weight:\n";
    for (int i = 0; i < n; i++) {
        cout << emp[i].name << "  Avg: " << emp[i].avg
             << "  (H=" << emp[i].height << ", W=" << emp[i].weight << ")\n";
    }

    return 0;
}

```
# 9. Implement a Singly Linked List to manage ‘Vertex Club’ membership (add/delete including president/secretary, count, display, concatenate lists).
```cpp
#include <iostream>
#include <string>
using namespace std;

class Node{
public:
    string name;
    Node* next;

    Node(string n){
        name = n;
        next = nullptr;
    }
};

// Insert PRESIDENT at HEAD
void addPresident(Node* &head, string name){
    Node* temp = new Node(name);
    temp->next = head;
    head = temp;
    cout << "President added.\n";
}

// Insert SECRETARY at TAIL
void addSecretary(Node* &head, string name){
    Node* temp = new Node(name);

    if(head == nullptr){
        head = temp;
        cout << "Secretary added.\n";
        return;
    }

    Node* t = head;
    while(t->next != nullptr){
        t = t->next;
    }

    t->next = temp;
    cout << "Secretary added.\n";
}

// Insert MEMBER in BETWEEN at given position
// position starts from 2, because 1 = president
void addMember(Node* &head, string name, int pos){
    if(pos == 1){
        cout << "Position 1 is President. Use addPresident().\n";
        return;
    }

    Node* temp = new Node(name);

    Node* t = head;
    int count = 1;

    while(t != nullptr && count < pos-1){
        t = t->next;
        count++;
    }

    if(t == nullptr){
        cout << "Invalid position!\n";
        delete temp;
        return;
    }

    temp->next = t->next;
    t->next = temp;

    cout << "Member added at position " << pos << ".\n";
}

// Display list
void display(Node* head){
    if(head == nullptr){
        cout << "List is empty.\n";
        return;
    }

    int pos = 1;
    cout << "\n--- Vertex Club Members ---\n";

    while(head != nullptr){
        if(pos == 1) cout << pos << ". " << head->name << " (President)\n";
        else if(head->next == nullptr) cout << pos << ". " << head->name << " (Secretary)\n";
        else cout << pos << ". " << head->name << " (Member)\n";

        head = head->next;
        pos++;
    }
}

// Count members
int countMembers(Node* head){
    int cnt = 0;
    while(head){
        cnt++;
        head = head->next;
    }
    return cnt;
}

int main(){
    Node* head = nullptr;
    int choice;

    while(true){
        cout << "\n--- Vertex Club Menu ---\n";
        cout << "1. Add President (Head)\n";
        cout << "2. Add Member (Between)\n";
        cout << "3. Add Secretary (Tail)\n";
        cout << "4. Display Members\n";
        cout << "5. Count Members\n";
        cout << "0. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        if(choice == 0) break;

        string name;
        int pos;

        switch(choice){
            case 1:
                cout << "Enter name: ";
                cin >> ws;
                getline(cin, name);
                addPresident(head, name);
                break;

            case 2:
                cout << "Enter name: ";
                cin >> ws;
                getline(cin, name);
                cout << "Enter position: ";
                cin >> pos;
                addMember(head, name, pos);
                break;

            case 3:
                cout << "Enter name: ";
                cin >> ws;
                getline(cin, name);
                addSecretary(head, name);
                break;

            case 4:
                display(head);
                break;

            case 5:
                cout << "Total members: " << countMembers(head) << endl;
                break;

            default:
                cout << "Invalid choice!\n";
        }
    }

    return 0;
}

```

# 10. Implement ticket reservation for Galaxy Multiplex using a doubly circular linked list (8×8 seats). Display availability, book seats, cancel seats.
```cpp
#include<iostream>
using namespace std;

class Node {
public:
    bool booked;
    int seatNo;
    Node* next;
    Node* prev;

    Node(int num) {
        seatNo = num;         // FIXED
        booked = false;
        next = prev = nullptr;
    }
};

class GalaxyMultiplex {
public:
    Node* head;

    GalaxyMultiplex() {
        head = nullptr;
        createSeats();
    }

    void createSeats() {
        Node* last = nullptr;

        for (int i = 1; i <= 64; i++) {      // FIXED
            Node* temp = new Node(i);

            if (head == nullptr) {
                head = temp;
                head->next = head;
                head->prev = head;
                last = head;
            }
            else {
                temp->prev = last;
                temp->next = head;
                last->next = temp;
                head->prev = temp;
                last = temp;                // FIXED
            }
        }
    }

    void displayseats() {
        cout << "\n---- Seating Arrangement ----\n";
        Node* temp = head;

        for (int i = 1; i <= 64; i++) {     // FIXED
            if (temp->booked) {
                cout << "[X]\t";
            } else {
                cout << "[" << temp->seatNo << "]\t";   // FIXED
            }

            if (i % 8 == 0) cout << "\n\n";

            temp = temp->next;
        }
    }

    void bookseatno(int num) {
        Node* temp = head;

        for (int i = 1; i <= 64; i++) {    // FIXED
            if (temp->seatNo == num) {
                if (temp->booked) {
                    cout << "Seat already booked!\n";
                    return;
                } else {
                    temp->booked = true;
                    cout << "Seat " << num << " booked successfully!\n";
                    return;
                }
            }
            temp = temp->next;
        }
        cout << "Invalid seat number!\n";
    }

    void cancelseatno(int num) {
        Node* temp = head;

        for (int i = 1; i <= 64; i++) {    // FIXED
            if (temp->seatNo == num) {
                if (!temp->booked) {
                    cout << "Seat " << num << " is not booked!\n";
                    return;
                } else {
                    temp->booked = false;
                    cout << "Seat " << num << " cancel successful!\n";
                    return;
                }
            }
            temp = temp->next;
        }
        cout << "Invalid seat number!\n";
    }
};

int main() {
    GalaxyMultiplex g;
    int seatno, choice;

    while (true) {
        cout << "\n--- Galaxy Multiplex Menu ---\n";
        cout << "1. Display Seat Availability\n";
        cout << "2. Book a Seat\n";
        cout << "3. Cancel a Seat\n";
        cout << "0. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            g.displayseats();
            break;
        case 2:
            cout << "Enter seat No: ";
            cin >> seatno;
            g.bookseatno(seatno);
            break;
        case 3:
            cout << "Enter seat No: ";
            cin >> seatno;
            g.cancelseatno(seatno);
            break;
        case 0:
            cout << "Exiting...\n";
            return 0;
        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 11. Manage appointment schedule for a single day using linked list. Display free slots, book appointment, cancel appointment, sort appointments.

```cpp
#include <iostream>
#include <string>
using namespace std;

class Node {
public:
    int slotNo;             // 1 to 8
    string patientName;
    Node* next;

    Node(int s, string p) {
        slotNo = s;
        patientName = p;
        next = nullptr;
    }
};

class AppointmentSchedule {
public:
    Node* head;

    AppointmentSchedule() {
        head = nullptr;
    }

    // Check if slot is free
    bool isBooked(int slot) {
        Node* temp = head;
        while (temp) {
            if (temp->slotNo == slot)
                return true;
            temp = temp->next;
        }
        return false;
    }

    // Book Appointment
    void bookAppointment(int slot, string name) {
        if (isBooked(slot)) {
            cout << "Slot " << slot << " is already booked!\n";
            return;
        }

        Node* temp = new Node(slot, name);

        // Insert in sorted order by time
        if (head == nullptr || slot < head->slotNo) {
            temp->next = head;
            head = temp;
        } else {
            Node* cur = head;
            while (cur->next && cur->next->slotNo < slot)
                cur = cur->next;

            temp->next = cur->next;
            cur->next = temp;
        }
        cout << "Appointment booked successfully!\n";
    }

    // Cancel Appointment
    void cancelAppointment(int slot) {
        if (head == nullptr) {
            cout << "No appointments to cancel!\n";
            return;
        }

        // cancel head
        if (head->slotNo == slot) {
            Node* del = head;
            head = head->next;
            delete del;
            cout << "Appointment for slot " << slot << " canceled!\n";
            return;
        }

        Node* cur = head;
        while (cur->next && cur->next->slotNo != slot)
            cur = cur->next;

        if (cur->next == nullptr) {
            cout << "Slot not found!\n";
            return;
        }

        Node* del = cur->next;
        cur->next = del->next;
        delete del;

        cout << "Appointment for slot " << slot << " canceled!\n";
    }

    // Display booked appointments
    void displayAppointments() {
        if (!head) {
            cout << "No appointments booked!\n";
            return;
        }

        cout << "\n--- Booked Appointments ---\n";
        Node* temp = head;

        while (temp) {
            cout << "Slot " << temp->slotNo
                 << " → " << temp->patientName << endl;
            temp = temp->next;
        }
    }

    // Display Free Slots
    void displayFreeSlots() {
        cout << "\n--- Free Slots ---\n";
        bool freeFound = false;

        for (int i = 1; i <= 8; i++) {
            if (!isBooked(i)) {
                cout << "Slot " << i << " is free.\n";
                freeFound = true;
            }
        }

        if (!freeFound)
            cout << "No free slots!\n";
    }
};

int main() {
    AppointmentSchedule app;
    int choice, slot;
    string name;

    while (true) {
        cout << "\n--- Appointment Menu ---\n";
        cout << "1. Display Free Slots\n";
        cout << "2. Book Appointment\n";
        cout << "3. Cancel Appointment\n";
        cout << "4. Display Booked Appointments\n";
        cout << "0. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            app.displayFreeSlots();
            break;

        case 2:
            cout << "Enter slot (1–8): ";
            cin >> slot;
            cout << "Enter Patient Name: ";
            cin >> ws;
            getline(cin, name);
            app.bookAppointment(slot, name);
            break;

        case 3:
            cout << "Enter slot to cancel: ";
            cin >> slot;
            app.cancelAppointment(slot);
            break;

        case 4:
            app.displayAppointments();
            break;

        case 0:
            cout << "Exiting...\n";
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 12. In the Second Year Computer Engineering class, there are two groups of students based on their favorite sports: ● Set A includes students who like Cricket. ● Set B includes students who like Football. Write a C++ program to represent these two sets using linked lists and perform the following operations: a) Find and display the set of students who like both Cricket and Football. b) Find and display the set of students who like either Cricket or Football, but not both. c) Display the number of students who like neither Cricket nor Football in cpp.

```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;
    Node(int x) {
        data = x;
        next = NULL;
    }
};

// Insert at end of linked list
void insert(Node*& head, int x) {
    Node* temp = new Node(x);
    if (head == NULL) {
        head = temp;
        return;
    }
    Node* p = head;
    while (p->next != NULL)
        p = p->next;
    p->next = temp;
}

// Search element in linked list
bool search(Node* head, int x) {
    Node* p = head;
    while (p != NULL) {
        if (p->data == x)
            return true;
        p = p->next;
    }
    return false;
}

// Display linked list
void display(Node* head) {
    Node* p = head;
    while (p != NULL) {
        cout << p->data << " ";
        p = p->next;
    }
    cout << endl;
}

int main() {
    Node* setA = NULL;  // Cricket
    Node* setB = NULL;  // Football
    Node* both = NULL;  // A ∩ B
    Node* eitherNotBoth = NULL; // A ⊕ B

    int nA, nB;
    int totalStudents;

    cout << "Enter total number of students in class: ";
    cin >> totalStudents;

    cout << "\nEnter number of students who like Cricket: ";
    cin >> nA;

    cout << "Enter roll numbers of students who like Cricket:\n";
    for (int i = 0; i < nA; i++) {
        int x;
        cin >> x;
        insert(setA, x);
    }

    cout << "\nEnter number of students who like Football: ";
    cin >> nB;

    cout << "Enter roll numbers of students who like Football:\n";
    for (int i = 0; i < nB; i++) {
        int x;
        cin >> x;
        insert(setB, x);
    }

    // -------------------- (a) INTERSECTION A ∩ B --------------------
    Node* p = setA;
    while (p != NULL) {
        if (search(setB, p->data))
            insert(both, p->data);
        p = p->next;
    }

    cout << "\n(a) Students who like BOTH Cricket and Football: ";
    display(both);

    // -------------------- (b) SYMMETRIC DIFFERENCE A ⊕ B --------------------
    // Elements in A but not in B
    p = setA;
    while (p != NULL) {
        if (!search(setB, p->data))
            insert(eitherNotBoth, p->data);
        p = p->next;
    }

    // Elements in B but not in A
    p = setB;
    while (p != NULL) {
        if (!search(setA, p->data))
            insert(eitherNotBoth, p->data);
        p = p->next;
    }

    cout << "\n(b) Students who like EITHER Cricket or Football BUT NOT BOTH: ";
    display(eitherNotBoth);

    // -------------------- (c) STUDENTS WHO LIKE NEITHER --------------------
    int countBoth = 0, countEither = 0;
    
    // count in intersection
    p = both;
    while (p != NULL) {
        countBoth++;
        p = p->next;
    }

    // count in symmetric difference
    p = eitherNotBoth;
    while (p != NULL) {
        countEither++;
        p = p->next;
    }

    int neither = totalStudents - (countBoth + countEither);

    cout << "\n(c) Number of students who like NEITHER: " << neither << endl;

    return 0;
}

```
# 13. Store a binary number using a doubly linked list and calculate 1’s and 2’s complement in cpp.

```cpp
#include<iostream>
using namespace std;

class Node{
public:
    bool bit;
    Node* next;
    Node* prev;

    Node(int b){
        bit = b;
        next = prev = nullptr;
    }
};

class BinaryDLL{
public:
    Node* head ;
    Node* tail;

    BinaryDLL(){
        head = tail = nullptr;
    }

    void insertBit(int b){
        Node* newb = new Node(b);

        if (head == nullptr) {
            head = tail = newb;
        }
        else {
            tail->next = newb;
            newb->prev = tail;
            tail = newb;
        }
    }

    void display(){
        Node* temp = head;
        while (temp) {
            cout << temp->bit;
            temp = temp->next;
        }
        cout << endl;
    }

    void onecomplement(){
        Node* mover = head;

        while(mover != nullptr){
            if (mover->bit == 1)
                mover->bit = 0;
            else
                mover->bit = 1;

            mover = mover->next;
        }
    }

    void twocomplement(){
        // Step 1: 1's complement
        onecomplement();

        // Step 2: Add 1 from LSB
        Node* mover = tail;
        int carry = 1;

        while(mover != nullptr && carry == 1){
            if(mover->bit == 0){
                mover->bit = 1;
                carry = 0;
            }
            else {
                mover->bit = 0; // 1+1 = 0 carry 1
                carry = 1;
            }
            mover = mover->prev;
        }

        // Step 3: If carry still left → new MSB
        if (carry == 1){
            Node* newNode = new Node(1);
            newNode->next = head;
            head->prev = newNode;
            head = newNode;
        }
    }

};

int main(){
    BinaryDLL b;
    int n,bit;

    cout << "Enter the number of bits: ";
    cin >> n;

    cout << "Enter bits: ";
    for(int i = 0 ; i < n; i++){
        cin >> bit;
        b.insertBit(bit);
    }

    cout << "Original: ";
    b.display();

    cout << "1's complement: ";
    b.onecomplement();
    b.display();

    // Recreate original before 2's complement OR call onecomplement again
    cout << "2's complement: ";
    b.twocomplement();
    b.display();

    return 0;
}

```

# 14. WAP to perform addition of two polynomials using singly linked list
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int coeff, pow;
    Node* next;

    Node(int c, int p) {
        coeff = c;
        pow = p;
        next = NULL;
    }
};

// Insert at end
void insert(Node*& head, int c, int p) {
    Node* temp = new Node(c, p);
    if (!head) {
        head = temp;
        return;
    }
    Node* t = head;
    while (t->next)
        t = t->next;
    t->next = temp;
}

// Display polynomial
void display(Node* head) {
    Node* t = head;
    while (t) {
        cout << t->coeff << "x^" << t->pow;
        if (t->next) cout << " + ";
        t = t->next;
    }
    cout << endl;
}

// Polynomial Addition
Node* addPoly(Node* p1, Node* p2) {
    Node* result = NULL;

    while (p1 && p2) {
        if (p1->pow == p2->pow) {
            insert(result, p1->coeff + p2->coeff, p1->pow);
            p1 = p1->next;
            p2 = p2->next;
        }
        else if (p1->pow > p2->pow) {
            insert(result, p1->coeff, p1->pow);
            p1 = p1->next;
        }
        else {
            insert(result, p2->coeff, p2->pow);
            p2 = p2->next;
        }
    }

    // Remaining terms
    while (p1) {
        insert(result, p1->coeff, p1->pow);
        p1 = p1->next;
    }
    while (p2) {
        insert(result, p2->coeff, p2->pow);
        p2 = p2->next;
    }

    return result;
}

int main() {
    Node* poly1 = NULL;
    Node* poly2 = NULL;
    Node* sum = NULL;

    int n1, n2;

    cout << "Enter number of terms in 1st polynomial: ";
    cin >> n1;

    cout << "Enter coeff & power for 1st polynomial:\n";
    for (int i = 0; i < n1; i++) {
        int c, p;
        cin >> c >> p;
        insert(poly1, c, p);
    }

    cout << "Enter number of terms in 2nd polynomial: ";
    cin >> n2;

    cout << "Enter coeff & power for 2nd polynomial:\n";
    for (int i = 0; i < n2; i++) {
        int c, p;
        cin >> c >> p;
        insert(poly2, c, p);
    }

    cout << "\nPolynomial 1: ";
    display(poly1);

    cout << "Polynomial 2: ";
    display(poly2);

    // Add both polynomials
    sum = addPoly(poly1, poly2);

    cout << "\nSum = ";
    display(sum);

    return 0;
}

```

# 15. Implement Bubble sort using Doubly Linked List
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;
    Node* prev;

    Node(int x) {
        data = x;
        next = prev = NULL;
    }
};

// Insert at end of doubly linked list
void insertEnd(Node*& head, int x) {
    Node* temp = new Node(x);

    if (head == NULL) {
        head = temp;
        return;
    }

    Node* p = head;
    while (p->next != NULL)
        p = p->next;

    p->next = temp;
    temp->prev = p;
}

// Print DLL
void printList(Node* head) {
    Node* p = head;
    while (p != NULL) {
        cout << p->data << " ";
        p = p->next;
    }
    cout << endl;
}

// Bubble Sort on Doubly Linked List (swap DATA)
void bubbleSort(Node* head) {
    if (head == NULL)
        return;

    bool swapped;

    do {
        swapped = false;
        Node* p = head;

        while (p->next != NULL) {
            if (p->data > p->next->data) {

                // swap values
                int temp = p->data;
                p->data = p->next->data;
                p->next->data = temp;

                swapped = true;
            }
            p = p->next;
        }

    } while (swapped);
}

int main() {
    Node* head = NULL;
    int n, x;

    cout << "Enter number of elements: ";
    cin >> n;

    cout << "Enter elements:\n";
    for (int i = 0; i < n; i++) {
        cin >> x;
        insertEnd(head, x);
    }

    cout << "\nOriginal List: ";
    printList(head);

    bubbleSort(head);

    cout << "Sorted List (Bubble Sort): ";
    printList(head);

    return 0;
}

```

# 16. WAP to create a doubly linked list and perform following operations on it. A) Insert (all cases) 2. Delete (all cases).
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;
    Node* prev;

    Node(int x) {
        data = x;
        next = prev = NULL;
    }
};

Node* head = NULL;

// ------------------------------- INSERTIONS ----------------------------------

// Insert at beginning
void insertBegin(int x) {
    Node* temp = new Node(x);
    if (head == NULL) {
        head = temp;
        return;
    }
    temp->next = head;
    head->prev = temp;
    head = temp;
}

// Insert at end
void insertEnd(int x) {
    Node* temp = new Node(x);
    if (head == NULL) {
        head = temp;
        return;
    }
    Node* t = head;
    while (t->next != NULL)
        t = t->next;

    t->next = temp;
    temp->prev = t;
}

// Insert at given position (1-based index)
void insertPos(int pos, int x) {
    if (pos == 1) {
        insertBegin(x);
        return;
    }

    Node* t = head;
    for (int i = 1; i < pos - 1 && t != NULL; i++)
        t = t->next;

    if (t == NULL) {
        cout << "Position out of range!\n";
        return;
    }

    Node* temp = new Node(x);
    temp->next = t->next;
    temp->prev = t;

    if (t->next)
        t->next->prev = temp;

    t->next = temp;
}

// ------------------------------- DELETIONS ----------------------------------

// Delete from beginning
void deleteBegin() {
    if (head == NULL) {
        cout << "List is empty!\n";
        return;
    }
    Node* temp = head;
    head = head->next;

    if (head)
        head->prev = NULL;

    delete temp;
}

// Delete from end
void deleteEnd() {
    if (head == NULL) {
        cout << "List is empty!\n";
        return;
    }

    if (head->next == NULL) {
        delete head;
        head = NULL;
        return;
    }

    Node* t = head;
    while (t->next != NULL)
        t = t->next;

    t->prev->next = NULL;
    delete t;
}

// Delete at given position
void deletePos(int pos) {
    if (head == NULL) {
        cout << "List is empty!\n";
        return;
    }

    if (pos == 1) {
        deleteBegin();
        return;
    }

    Node* t = head;
    for (int i = 1; i < pos && t != NULL; i++)
        t = t->next;

    if (t == NULL) {
        cout << "Position out of range!\n";
        return;
    }

    t->prev->next = t->next;
    if (t->next)
        t->next->prev = t->prev;

    delete t;
}

// ------------------------------- DISPLAY ----------------------------------
void display() {
    Node* t = head;
    cout << "List: ";
    while (t != NULL) {
        cout << t->data << " ";
        t = t->next;
    }
    cout << endl;
}

// ------------------------------- MAIN ----------------------------------
int main() {
    int choice, val, pos;

    while (1) {
        cout << "\n--- DOUBLY LINKED LIST MENU ---\n";
        cout << "1. Insert at Beginning\n";
        cout << "2. Insert at End\n";
        cout << "3. Insert at Position\n";
        cout << "4. Delete from Beginning\n";
        cout << "5. Delete from End\n";
        cout << "6. Delete from Position\n";
        cout << "7. Display\n";
        cout << "8. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter value: ";
            cin >> val;
            insertBegin(val);
            break;

        case 2:
            cout << "Enter value: ";
            cin >> val;
            insertEnd(val);
            break;

        case 3:
            cout << "Enter position: ";
            cin >> pos;
            cout << "Enter value: ";
            cin >> val;
            insertPos(pos, val);
            break;

        case 4:
            deleteBegin();
            break;

        case 5:
            deleteEnd();
            break;

        case 6:
            cout << "Enter position: ";
            cin >> pos;
            deletePos(pos);
            break;

        case 7:
            display();
            break;

        case 8:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 17. WAP to build a simple stock price tracker that keeps a history of daily stock prices
```cpp
#include <iostream>
using namespace std;

// ---------------- NODE STRUCTURE ----------------
class Node {
public:
    int price;
    Node* next;

    Node(int p) {
        price = p;
        next = NULL;
    }
};

// Stack implemented using singly linked list
class StockStack {
    Node* top;

public:
    StockStack() {
        top = NULL;
    }

    // --- 1. record(price) : Push operation ---
    void record(int price) {
        Node* temp = new Node(price);
        temp->next = top;
        top = temp;
        cout << "Recorded price: " << price << endl;
    }

    // --- 2. remove() : Pop operation ---
    int remove() {
        if (isEmpty()) {
            cout << "No prices to remove!" << endl;
            return -1;
        }
        int removedPrice = top->price;
        Node* temp = top;
        top = top->next;
        delete temp;

        cout << "Removed the latest price: " << removedPrice << endl;
        return removedPrice;
    }

    // --- 3. latest() : Peek operation ---
    int latest() {
        if (isEmpty()) {
            cout << "No prices recorded yet!" << endl;
            return -1;
        }
        return top->price;
    }

    // --- 4. isEmpty() ---
    bool isEmpty() {
        return top == NULL;
    }

    // Utility: Display all prices (stack format)
    void display() {
        if (isEmpty()) {
            cout << "No price history!" << endl;
            return;
        }

        cout << "Price History (Top to Bottom): ";
        Node* t = top;
        while (t != NULL) {
            cout << t->price << " ";
            t = t->next;
        }
        cout << endl;
    }
};

// ---------------- MAIN MENU ----------------
int main() {
    StockStack tracker;
    int choice, price;

    while (true) {
        cout << "\n--- STOCK PRICE TRACKER MENU ---\n";
        cout << "1. Record a new price\n";
        cout << "2. Remove the latest price\n";
        cout << "3. View the latest price\n";
        cout << "4. Check if history is empty\n";
        cout << "5. Display full price history\n";
        cout << "6. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter price to record: ";
            cin >> price;
            tracker.record(price);
            break;

        case 2:
            tracker.remove();
            break;

        case 3:
            price = tracker.latest();
            if (price != -1)
                cout << "Latest price = " << price << endl;
            break;

        case 4:
            cout << (tracker.isEmpty() ? "History is empty." : "History is NOT empty.") << endl;
            break;

        case 5:
            tracker.display();
            break;

        case 6:
            return 0;

        default:
            cout << "Invalid choice!" << endl;
        }
    }
}

```

# 18. Convert given infix expression Eg. `a-b*c-d/e+f` into postfix form using stack and show the operations step by step.

```cpp
#include <iostream>
using namespace std;

char stackArr[50];
int top = -1;

// Stack operations
void push(char x) {
    stackArr[++top] = x;
}

char pop() {
    if (top == -1) return '\0';
    return stackArr[top--];
}

char peek() {
    if (top == -1) return '\0';
    return stackArr[top];
}

bool isEmpty() {
    return top == -1;
}

// Precedence function
int precedence(char c) {
    if (c == '*' || c == '/') return 2;
    if (c == '+' || c == '-') return 1;
    return 0;
}

// Print stack
void printStack() {
    cout << "Stack: [ ";
    for (int i = 0; i <= top; i++) {
        cout << stackArr[i] << " ";
    }
    cout << "]";
}

// Print postfix till current index
void printPostfix(char postfix[], int pIndex) {
    cout << "  Postfix: ";
    for (int i = 0; i < pIndex; i++) {
        cout << postfix[i];
    }
    cout << endl;
}

int main() {
    char infix[50] = "a-b*c-d/e+f";   // you can also take input from user
    char postfix[50];
    int pIndex = 0;

    cout << "Infix Expression: " << infix << "\n\n";
    cout << "Step-by-step operations:\n\n";

    for (int i = 0; infix[i] != '\0'; i++) {
        char ch = infix[i];
        cout << "Read: " << ch << "  -->  ";

        // If operand → go directly to postfix
        if ((ch >= 'a' && ch <= 'z') ||
            (ch >= 'A' && ch <= 'Z') ||
            (ch >= '0' && ch <= '9')) {
            postfix[pIndex++] = ch;
            cout << "Operand, add to postfix\n";
            printStack();
            printPostfix(postfix, pIndex);
        }
        // If operator
        else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
            cout << "Operator, compare precedence and manage stack\n";
            // Pop from stack while top has higher or equal precedence
            while (!isEmpty() && precedence(peek()) >= precedence(ch)) {
                postfix[pIndex++] = pop();
            }
            push(ch);
            printStack();
            printPostfix(postfix, pIndex);
        }
        // If opening parenthesis
        else if (ch == '(') {
            cout << "Opening parenthesis, push to stack\n";
            push(ch);
            printStack();
            printPostfix(postfix, pIndex);
        }
        // If closing parenthesis
        else if (ch == ')') {
            cout << "Closing parenthesis, pop till '('\n";
            while (!isEmpty() && peek() != '(') {
                postfix[pIndex++] = pop();
            }
            pop(); // remove '('
            printStack();
            printPostfix(postfix, pIndex);
        }
    }

    // After scanning entire infix, pop remaining operators
    cout << "\nEnd of expression, pop remaining operators from stack\n";
    while (!isEmpty()) {
        postfix[pIndex++] = pop();
        printStack();
        printPostfix(postfix, pIndex);
    }

    postfix[pIndex] = '\0';

    cout << "\nFinal Postfix Expression: " << postfix << endl;

    return 0;
}

```

# 19. Write a program to implement multiple stack i.e more than two stack using array and perform following operations on it. A. Push B. Pop C. Stack Overflow D. Stack Underflow E. Display

```cpp
#include <iostream>
using namespace std;

#define MAX 100

int arr[MAX];   // main array
int top[10];    // tops of all stacks
int start[10];  // start index of each stack
int endd[10];   // end index of each stack

// Create k stacks inside array of size n
void createStacks(int n, int k) {
    int size = n / k;

    for (int i = 0; i < k; i++) {
        start[i] = i * size;       // starting index
        endd[i] = start[i] + size - 1;  // ending index
        top[i] = start[i] - 1;     // initialize top as empty
    }
}

// PUSH operation
void push(int s, int value) {
    s--; // converting stack number (1-based) to index (0-based)

    if (top[s] == endd[s]) {
        cout << "Stack " << s+1 << " Overflow!\n";
        return;
    }

    top[s]++;
    arr[top[s]] = value;
    cout << "Pushed " << value << " to Stack " << s+1 << endl;
}

// POP operation
void pop(int s) {
    s--;

    if (top[s] < start[s]) {
        cout << "Stack " << s+1 << " Underflow!\n";
        return;
    }

    cout << "Popped " << arr[top[s]] << " from Stack " << s+1 << endl;
    top[s]--;
}

// DISPLAY a stack
void display(int s) {
    s--;

    if (top[s] < start[s]) {
        cout << "Stack " << s+1 << " is Empty!\n";
        return;
    }

    cout << "Stack " << s+1 << ": ";
    for (int i = start[s]; i <= top[s]; i++)
        cout << arr[i] << " ";
    cout << endl;
}

// ------------------------ MAIN ------------------------
int main() {
    int n, k;

    cout << "Enter total array size: ";
    cin >> n;

    cout << "Enter number of stacks: ";
    cin >> k;

    createStacks(n, k);

    int choice, stackNo, value;

    while (true) {
        cout << "\n---- MULTIPLE STACK MENU ----\n";
        cout << "1. Push\n2. Pop\n3. Display\n4. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter stack number (1-" << k << "): ";
            cin >> stackNo;
            cout << "Enter value: ";
            cin >> value;
            push(stackNo, value);
            break;

        case 2:
            cout << "Enter stack number (1-" << k << "): ";
            cin >> stackNo;
            pop(stackNo);
            break;

        case 3:
            cout << "Enter stack number (1-" << k << "): ";
            cin >> stackNo;
            display(stackNo);
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 20. You are given a string containing only parentheses characters: '(', ')', '{', '}', '[', and ']'. Your task is to check whether the parentheses are balanced or not. A string is considered balanced if: 1. Every opening bracket has a corresponding closing bracket of the same type 2. Brackets are closed in the correct order.

```cpp
#include <iostream>
using namespace std;

bool isBalanced(string s) {

    // Local stack inside the same function
    char st[100];
    int top = -1;

    for (char ch : s) {

        // Push for opening brackets
        if (ch == '(' || ch == '{' || ch == '[') {
            st[++top] = ch;
        }

        // Closing brackets
        else if (ch == ')' || ch == '}' || ch == ']') {

            // Stack empty → unbalanced
            if (top == -1) return false;

            char open = st[top--]; // pop

            // Check matching
            if (!((open == '(' && ch == ')') ||
                  (open == '{' && ch == '}') ||
                  (open == '[' && ch == ']')))
                return false;
        }
    }

    // At end, stack must be empty
    return (top == -1);
}

int main() {
    string s;
    cout << "Enter parentheses string: ";
    cin >> s;

    if (isBalanced(s))
        cout << "Balanced";
    else
        cout << "Not Balanced";

    return 0;
}

```

# 21. You are given a postfix expression (also known as Reverse Polish Notation) consisting of single-digit operands and binary operators `(+, -, *, /)`. Your task is to evaluate the expression using stack and return its result.
```cpp
#include <iostream>
using namespace std;

int evaluatePostfix(string exp) {

    int st[50];
    int top = -1;

    for (char ch : exp) {

        // If operand → push (convert char to int)
        if (ch >= '0' && ch <= '9') {
            st[++top] = ch - '0';
        }
        // If operator → pop two operands
        else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {

            int b = st[top--];   // second operand
            int a = st[top--];   // first operand
            int result = 0;

            switch (ch) {
                case '+': result = a + b; break;
                case '-': result = a - b; break;
                case '*': result = a * b; break;
                case '/': result = a / b; break;
            }

            // Push result back
            st[++top] = result;
        }
    }

    // Final answer
    return st[top];
}

int main() {
    string postfix;
    cout << "Enter postfix expression: ";
    cin >> postfix;

    cout << "Result = " << evaluatePostfix(postfix);
    return 0;
}

```

# 22. Write a program to keep track of patients as they checked into a medical clinic, assigning patients to doctors on a first-come, first-served basis.
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    string name;
    Node* next;

    Node(string n) {
        name = n;
        next = NULL;
    }
};

class PatientQueue {
    Node* front;
    Node* rear;

public:
    PatientQueue() {
        front = rear = NULL;
    }

    // Add patient to queue (enqueue)
    void checkIn(string name) {
        Node* temp = new Node(name);

        if (rear == NULL) {
            front = rear = temp;
            cout << name << " checked in.\n";
            return;
        }
        rear->next = temp;
        rear = temp;
        cout << name << " checked in.\n";
    }

    // Remove patient (dequeue)
    void assignDoctor() {
        if (isEmpty()) {
            cout << "No patients waiting!\n";
            return;
        }

        Node* temp = front;
        cout << "Doctor is seeing: " << front->name << endl;

        front = front->next;

        if (front == NULL)
            rear = NULL;

        delete temp;
    }

    // Check if queue is empty
    bool isEmpty() {
        return (front == NULL);
    }

    // Display waiting list
    void display() {
        if (isEmpty()) {
            cout << "No patients in waiting list.\n";
            return;
        }

        cout << "Patients waiting: ";
        Node* temp = front;
        while (temp != NULL) {
            cout << temp->name << " ";
            temp = temp->next;
        }
        cout << endl;
    }
};

int main() {
    PatientQueue pq;
    int choice;
    string name;

    while (true) {
        cout << "\n--- MEDICAL CLINIC PATIENT QUEUE ---\n";
        cout << "1. Check-in patient\n";
        cout << "2. Assign patient to doctor\n";
        cout << "3. Display waiting list\n";
        cout << "4. Check if queue is empty\n";
        cout << "5. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter patient name: ";
            cin >> name;
            pq.checkIn(name);
            break;

        case 2:
            pq.assignDoctor();
            break;

        case 3:
            pq.display();
            break;

        case 4:
            cout << (pq.isEmpty() ? "Queue is empty." : "Patients are waiting.") << endl;
            break;

        case 5:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 23. Pizza parlour accepting maximum n orders. Orders are served on an FCFS basis. Order once placed can’t be cancelled. Write C++ program to simulate the system using circular QUEUE.
```cpp
#include <iostream>
using namespace std;

class CircularQueue {
    int front, rear, size;
    int arr[50];   // max size fixed for simplicity

public:
    CircularQueue(int n) {
        front = rear = -1;
        size = n;
    }

    // Check if full
    bool isFull() {
        return (front == 0 && rear == size - 1) || (front == rear + 1);
    }

    // Check if empty
    bool isEmpty() {
        return (front == -1);
    }

    // Place order
    void placeOrder(int orderNo) {
        if (isFull()) {
            cout << "Cannot place order! Pizza parlour is full.\n";
            return;
        }

        if (front == -1) {  // first order
            front = rear = 0;
        } else {
            rear = (rear + 1) % size;  // circular increment
        }

        arr[rear] = orderNo;
        cout << "Order " << orderNo << " placed successfully.\n";
    }

    // Serve order
    void serveOrder() {
        if (isEmpty()) {
            cout << "No orders to serve!\n";
            return;
        }

        int served = arr[front];
        cout << "Serving Order: " << served << endl;

        if (front == rear) {
            // Only one order present
            front = rear = -1;
        } else {
            front = (front + 1) % size; // circular increment
        }
    }

    // Display pending orders
    void display() {
        if (isEmpty()) {
            cout << "No pending orders.\n";
            return;
        }

        cout << "Pending Orders: ";
        int i = front;

        while (true) {
            cout << arr[i] << " ";
            if (i == rear)
                break;
            i = (i + 1) % size;
        }
        cout << endl;
    }
};

// --------------------------- MAIN ---------------------------

int main() {
    int n;
    cout << "Enter maximum number of orders the pizza parlour can accept: ";
    cin >> n;

    CircularQueue cq(n);

    int choice, orderNo;

    while (true) {
        cout << "\n---- PIZZA PARLOUR MENU ----\n";
        cout << "1. Place Order\n";
        cout << "2. Serve Order\n";
        cout << "3. Display Pending Orders\n";
        cout << "4. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter Order Number: ";
            cin >> orderNo;
            cq.placeOrder(orderNo);
            break;

        case 2:
            cq.serveOrder();
            break;

        case 3:
            cq.display();
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 24. Write a program that maintains a queue of passengers waiting to see a ticket agent. The program user should be able to insert a new passenger at the rear of the queue, Display the passenger at the front of the Queue, or remove the passenger at the front of the queue. The program will display the number of passengers left in the queue just before it terminates.
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    string name;
    Node* next;

    Node(string n) {
        name = n;
        next = NULL;
    }
};

class PassengerQueue {
    Node* front;
    Node* rear;

public:
    PassengerQueue() {
        front = rear = NULL;
    }

    // Insert passenger at rear (enqueue)
    void insertPassenger(string name) {
        Node* temp = new Node(name);

        if (rear == NULL) {
            front = rear = temp;
        } else {
            rear->next = temp;
            rear = temp;
        }

        cout << name << " has joined the queue.\n";
    }

    // Display passenger at the front
    void showFront() {
        if (front == NULL) {
            cout << "No passengers in queue.\n";
        } else {
            cout << "Passenger at front: " << front->name << endl;
        }
    }

    // Remove front passenger (dequeue)
    void removePassenger() {
        if (front == NULL) {
            cout << "No passengers to remove.\n";
            return;
        }

        Node* temp = front;
        cout << "Removing passenger: " << temp->name << endl;

        front = front->next;

        if (front == NULL)
            rear = NULL;  // queue becomes empty

        delete temp;
    }

    // Count remaining passengers
    int countPassengers() {
        int count = 0;
        Node* temp = front;
        while (temp != NULL) {
            count++;
            temp = temp->next;
        }
        return count;
    }
};

// ------------------- MAIN PROGRAM -------------------

int main() {
    PassengerQueue pq;
    int choice;
    string name;

    while (true) {
        cout << "\n--- PASSENGER QUEUE MENU ---\n";
        cout << "1. Add Passenger to Queue\n";
        cout << "2. Show Passenger at Front\n";
        cout << "3. Remove Passenger at Front\n";
        cout << "4. Exit Program\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter passenger name: ";
            cin >> name;
            pq.insertPassenger(name);
            break;

        case 2:
            pq.showFront();
            break;

        case 3:
            pq.removePassenger();
            break;

        case 4:
            cout << "\nPassengers left in queue: " << pq.countPassengers() << endl;
            return 0;

        default:
            cout << "Invalid choice! Try again.\n";
        }
    }
}

```

# 25. Write a program to implement multiple queues i.e. two queues using array and perform following operations on it. A. Add Queue, B. Delete from Queue, C. Display Queue


``
```cpp
#include <iostream>
using namespace std;

#define MAX 20

class TwoQueues {
    int arr[MAX];
    int front1, rear1;
    int front2, rear2;
    int mid;

public:
    TwoQueues() {
        mid = MAX / 2;

        // Queue 1 indices
        front1 = rear1 = -1;

        // Queue 2 indices
        front2 = rear2 = mid;
    }

    // ---------------- INSERTIONS ----------------
    void addQueue(int qNo, int value) {
        if (qNo == 1) {
            if (rear1 == mid - 1) {
                cout << "Queue 1 Overflow!\n";
                return;
            }

            if (front1 == -1)
                front1 = 0;

            arr[++rear1] = value;
            cout << "Inserted " << value << " into Queue 1\n";
        }

        else if (qNo == 2) {
            if (rear2 == MAX - 1) {
                cout << "Queue 2 Overflow!\n";
                return;
            }

            if (front2 == mid)
                front2 = mid + 1;

            arr[++rear2] = value;
            cout << "Inserted " << value << " into Queue 2\n";
        }

        else {
            cout << "Invalid Queue Number!\n";
        }
    }

    // ---------------- DELETIONS ----------------
    void deleteQueue(int qNo) {
        if (qNo == 1) {
            if (front1 == -1 || front1 > rear1) {
                cout << "Queue 1 Underflow!\n";
                return;
            }

            cout << "Deleted " << arr[front1++] << " from Queue 1\n";

            if (front1 > rear1)
                front1 = rear1 = -1;
        }

        else if (qNo == 2) {
            if (front2 == mid || front2 > rear2) {
                cout << "Queue 2 Underflow!\n";
                return;
            }

            cout << "Deleted " << arr[front2++] << " from Queue 2\n";

            if (front2 > rear2)
                front2 = rear2 = mid;
        }

        else {
            cout << "Invalid Queue Number!\n";
        }
    }

    // ---------------- DISPLAY ----------------
    void displayQueue(int qNo) {
        if (qNo == 1) {
            if (front1 == -1) {
                cout << "Queue 1 is Empty!\n";
                return;
            }

            cout << "Queue 1: ";
            for (int i = front1; i <= rear1; i++)
                cout << arr[i] << " ";
            cout << endl;
        }

        else if (qNo == 2) {
            if (front2 == mid) {
                cout << "Queue 2 is Empty!\n";
                return;
            }

            cout << "Queue 2: ";
            for (int i = front2; i <= rear2; i++)
                cout << arr[i] << " ";
            cout << endl;
        }

        else {
            cout << "Invalid Queue Number!\n";
        }
    }
};

// --------------------- MAIN ------------------------
int main() {
    TwoQueues q;
    int choice, qNo, value;

    while (true) {
        cout << "\n---- TWO QUEUES MENU ----\n";
        cout << "1. Add to Queue\n";
        cout << "2. Delete from Queue\n";
        cout << "3. Display Queue\n";
        cout << "4. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter Queue Number (1 or 2): ";
            cin >> qNo;
            cout << "Enter value: ";
            cin >> value;
            q.addQueue(qNo, value);
            break;

        case 2:
            cout << "Enter Queue Number (1 or 2): ";
            cin >> qNo;
            q.deleteQueue(qNo);
            break;

        case 3:
            cout << "Enter Queue Number (1 or 2): ";
            cin >> qNo;
            q.displayQueue(qNo);
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 26. In a call centre, customer calls are handled on a first-come, first-served basis. Implement a queue system using Linked list where: ● Each customer call is enqueued as it arrives. ● Customer service agents dequeue calls to assist customers. ● If there are no calls, the system waits.
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    string callerName;
    Node* next;

    Node(string n) {
        callerName = n;
        next = NULL;
    }
};

class CallQueue {
    Node* front;
    Node* rear;

public:
    CallQueue() {
        front = rear = NULL;
    }

    // Enqueue new call
    void enqueue(string name) {
        Node* temp = new Node(name);

        if (rear == NULL) {
            front = rear = temp;
        } else {
            rear->next = temp;
            rear = temp;
        }
        cout << "Call from \"" << name << "\" added to waiting queue.\n";
    }

    // Dequeue and assist customer
    void dequeue() {
        if (front == NULL) {
            cout << "No calls waiting. Agent is idle.\n";
            return;
        }

        cout << "Assisting customer: " << front->callerName << endl;
        Node* temp = front;

        front = front->next;
        if (front == NULL)   // queue became empty
            rear = NULL;

        delete temp;
    }

    // Check if queue is empty
    bool isEmpty() {
        return (front == NULL);
    }

    // Display all waiting calls
    void display() {
        if (isEmpty()) {
            cout << "No pending calls.\n";
            return;
        }

        cout << "Calls Waiting: ";
        Node* temp = front;
        while (temp != NULL) {
            cout << temp->callerName << " ";
            temp = temp->next;
        }
        cout << endl;
    }
};

// ----------------- MAIN PROGRAM -----------------

int main() {
    CallQueue cq;
    int choice;
    string name;

    while (true) {
        cout << "\n--- CALL CENTRE QUEUE SYSTEM ---\n";
        cout << "1. Add new incoming call\n";
        cout << "2. Assist next customer (dequeue)\n";
        cout << "3. Display waiting calls\n";
        cout << "4. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter caller name: ";
            cin >> name;
            cq.enqueue(name);
            break;

        case 2:
            cq.dequeue();
            break;

        case 3:
            cq.display();
            break;

        case 4:
            cout << "System shutting down...\n";
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 27. Write a program to perform Binary Search Tree (BST) operations (Create, Insert, Delete, Levelwise and display
```cpp
#include <iostream>
#include <queue>
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data = val;
        left = right = NULL;
    }
};

// ------------ INSERT INTO BST ------------
Node* insert(Node* root, int val) {
    if (root == NULL) 
        return new Node(val);

    if (val < root->data)
        root->left = insert(root->left, val);
    else
        root->right = insert(root->right, val);

    return root;
}

// ------------ FIND MIN VALUE (used for deletion) ------------
Node* findMin(Node* root) {
    while (root->left != NULL)
        root = root->left;
    return root;
}

// ------------ DELETE NODE FROM BST ------------
Node* deleteNode(Node* root, int key) {
    if (root == NULL) return root;

    if (key < root->data)
        root->left = deleteNode(root->left, key);

    else if (key > root->data)
        root->right = deleteNode(root->right, key);

    else {
        // Case 1: No child
        if (root->left == NULL && root->right == NULL) {
            delete root;
            return NULL;
        }

        // Case 2: One child
        else if (root->left == NULL) {
            Node* temp = root->right;
            delete root;
            return temp;
        }
        else if (root->right == NULL) {
            Node* temp = root->left;
            delete root;
            return temp;
        }

        // Case 3: Two children
        Node* temp = findMin(root->right); // inorder successor
        root->data = temp->data;           // replace value
        root->right = deleteNode(root->right, temp->data);
    }

    return root;
}

// ------------ LEVEL ORDER TRAVERSAL ------------
void levelOrder(Node* root) {
    if (root == NULL) {
        cout << "Tree is empty!\n";
        return;
    }

    queue<Node*> q;
    q.push(root);

    cout << "Levelwise Traversal: ";

    while (!q.empty()) {
        Node* curr = q.front();
        q.pop();
        cout << curr->data << " ";

        if (curr->left) q.push(curr->left);
        if (curr->right) q.push(curr->right);
    }
    cout << endl;
}

// ------------ INORDER DISPLAY (Sorted Order) ------------
void inorder(Node* root) {
    if (root == NULL) return;

    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}

// ------------ MAIN ----------------
int main() {
    Node* root = NULL;
    int choice, value;

    while (true) {
        cout << "\n--- BINARY SEARCH TREE MENU ---\n";
        cout << "1. Insert\n";
        cout << "2. Delete\n";
        cout << "3. Levelwise Display\n";
        cout << "4. Inorder Display\n";
        cout << "5. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter value to insert: ";
            cin >> value;
            root = insert(root, value);
            break;

        case 2:
            cout << "Enter value to delete: ";
            cin >> value;
            root = deleteNode(root, value);
            break;

        case 3:
            levelOrder(root);
            break;

        case 4:
            cout << "Inorder Traversal: ";
            inorder(root);
            cout << endl;
            break;

        case 5:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 28. Write a program to perform Binary Search Tree (BST) operations (Count the total number of nodes, Compute the height of the BST).
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data = val;
        left = right = NULL;
    }
};

// ---------------- INSERT INTO BST ----------------
Node* insert(Node* root, int val) {
    if (root == NULL)
        return new Node(val);

    if (val < root->data)
        root->left = insert(root->left, val);
    else
        root->right = insert(root->right, val);

    return root;
}

// ---------------- COUNT NUMBER OF NODES ----------------
int countNodes(Node* root) {
    if (root == NULL)
        return 0;

    return 1 + countNodes(root->left) + countNodes(root->right);
}

// ---------------- COMPUTE HEIGHT OF BST ----------------
int height(Node* root) {
    if (root == NULL)
        return -1;    // height of empty tree is -1

    int leftH = height(root->left);
    int rightH = height(root->right);

    return 1 + max(leftH, rightH);
}

// ---------------- MAIN PROGRAM ----------------
int main() {
    Node* root = NULL;
    int choice, value;

    while (true) {
        cout << "\n--- BST OPERATIONS MENU ---\n";
        cout << "1. Insert Node\n";
        cout << "2. Count Total Nodes\n";
        cout << "3. Compute Height of BST\n";
        cout << "4. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter value to insert: ";
            cin >> value;
            root = insert(root, value);
            break;

        case 2:
            cout << "Total nodes in BST = " << countNodes(root) << endl;
            break;

        case 3:
            cout << "Height of BST = " << height(root) << endl;
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice! Try again.\n";
        }
    }
}

```

# 29. Write a Program to create a Binary Tree Search and Find Minimum/Maximum in BST
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data = val;
        left = right = NULL;
    }
};

// ---------------- INSERT INTO BST ----------------
Node* insert(Node* root, int val) {
    if (root == NULL)
        return new Node(val);

    if (val < root->data)
        root->left = insert(root->left, val);
    else
        root->right = insert(root->right, val);

    return root;
}

// ---------------- FIND MINIMUM ----------------
// Minimum is at the extreme LEFT
int findMin(Node* root) {
    if (root == NULL) {
        cout << "Tree is empty!\n";
        return -1;
    }
    while (root->left != NULL)
        root = root->left;
    return root->data;
}

// ---------------- FIND MAXIMUM ----------------
// Maximum is at the extreme RIGHT
int findMax(Node* root) {
    if (root == NULL) {
        cout << "Tree is empty!\n";
        return -1;
    }
    while (root->right != NULL)
        root = root->right;
    return root->data;
}

// ---------------- MAIN PROGRAM ----------------
int main() {
    Node* root = NULL;
    int choice, value;

    while (true) {
        cout << "\n--- BST MENU ---\n";
        cout << "1. Insert Node\n";
        cout << "2. Find Minimum\n";
        cout << "3. Find Maximum\n";
        cout << "4. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {

        case 1:
            cout << "Enter value to insert: ";
            cin >> value;
            root = insert(root, value);
            break;

        case 2:
            cout << "Minimum value in BST = " << findMin(root) << endl;
            break;

        case 3:
            cout << "Maximum value in BST = " << findMax(root) << endl;
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```

# 30. Write a Program to create a Binary Tree and perform following Nonrecursive operations on it. a. Inorder Traversal
```cpp
#include <iostream>
#include <stack>
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data = val;
        left = right = NULL;
    }
};

// Create binary tree (simple insertion in left/right as user chooses)
Node* createTree() {
    int x;
    cout << "Enter data (-1 for no node): ";
    cin >> x;

    if (x == -1)
        return NULL;

    Node* root = new Node(x);
    cout << "Enter left child of " << x << ":\n";
    root->left = createTree();

    cout << "Enter right child of " << x << ":\n";
    root->right = createTree();

    return root;
}

// ---------------- NON-RECURSIVE INORDER TRAVERSAL ----------------
void inorderNonRecursive(Node* root) {
    stack<Node*> st;
    Node* curr = root;

    while (curr != NULL || !st.empty()) {

        // Step 1: Go to extreme left
        while (curr != NULL) {
            st.push(curr);
            curr = curr->left;
        }

        // Step 2: Process the node
        curr = st.top();
        st.pop();
        cout << curr->data << " ";

        // Step 3: Visit right subtree
        curr = curr->right;
    }
}

// ---------------- MAIN ----------------
int main() {
    Node* root = NULL;

    cout << "\nCreate Binary Tree:\n";
    root = createTree();

    cout << "\nNon-Recursive Inorder Traversal: ";
    inorderNonRecursive(root);

    cout << endl;
    return 0;
}

```


# 31. Write a Program to create a Binary Tree and perform the following Recursive operations on it. a. Inorder Traversal b. Preorder Traversal c. Display Number of Leaf Nodes
```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data = val;
        left = right = NULL;
    }
};

// ---------------- CREATE BINARY TREE ----------------
Node* createTree() {
    int x;
    cout << "Enter data (-1 for no node): ";
    cin >> x;

    if (x == -1)
        return NULL;

    Node* root = new Node(x);

    cout << "Enter left child of " << x << ":\n";
    root->left = createTree();

    cout << "Enter right child of " << x << ":\n";
    root->right = createTree();

    return root;
}

// ---------------- RECURSIVE INORDER ----------------
void inorder(Node* root) {
    if (root == NULL) return;

    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}

// ---------------- RECURSIVE PREORDER ----------------
void preorder(Node* root) {
    if (root == NULL) return;

    cout << root->data << " ";
    preorder(root->left);
    preorder(root->right);
}

// ---------------- COUNT LEAF NODES ----------------
int countLeaves(Node* root) {
    if (root == NULL)
        return 0;

    if (root->left == NULL && root->right == NULL)
        return 1;

    return countLeaves(root->left) + countLeaves(root->right);
}

// ---------------- MAIN PROGRAM ----------------
int main() {
    Node* root = NULL;

    cout << "\nCreate Binary Tree:\n";
    root = createTree();

    cout << "\nInorder Traversal: ";
    inorder(root);

    cout << "\nPreorder Traversal: ";
    preorder(root);

    cout << "\nNumber of Leaf Nodes = " << countLeaves(root) << endl;

    return 0;
}

```

# 32. Write a Program to accept a graph from a user and represent it with Adjacency Matrix and perform BFS and DFS traversals on it.
```cpp
#include <iostream>
#include <queue>
using namespace std;

#define MAX 20

int adj[MAX][MAX];   // adjacency matrix
int visited[MAX];    // for DFS & BFS
int n;               // number of vertices

// ---------------- DFS (Recursive) ----------------
void DFS(int v) {
    cout << v << " ";
    visited[v] = 1;

    for (int i = 0; i < n; i++) {
        if (adj[v][i] == 1 && visited[i] == 0)
            DFS(i);
    }
}

// ---------------- BFS (Iterative using Queue) ----------------
void BFS(int start) {
    queue<int> q;

    for (int i = 0; i < n; i++)
        visited[i] = 0;

    visited[start] = 1;
    q.push(start);

    cout << "BFS Traversal: ";

    while (!q.empty()) {
        int v = q.front();
        q.pop();
        cout << v << " ";

        for (int i = 0; i < n; i++) {
            if (adj[v][i] == 1 && visited[i] == 0) {
                visited[i] = 1;
                q.push(i);
            }
        }
    }
    cout << endl;
}

// ---------------- MAIN PROGRAM ----------------
int main() {
    int start;

    cout << "Enter number of vertices: ";
    cin >> n;

    cout << "Enter adjacency matrix (" << n << "x" << n << "):\n";
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> adj[i][j];
        }
    }

    cout << "\nEnter starting vertex for BFS/DFS: ";
    cin >> start;

    // BFS
    BFS(start);

    // DFS
    for (int i = 0; i < n; i++)
        visited[i] = 0;        // reset visited array

    cout << "DFS Traversal: ";
    DFS(start);
    cout << endl;

    return 0;
}

```

# 33. Write a Program to implement Prim’s algorithm to find minimum spanning tree of a user defined graph.
```cpp
#include <iostream>
using namespace std;

#define INF 999999

int main() {
    int n;

    cout << "Enter number of vertices: ";
    cin >> n;

    int graph[20][20];

    cout << "Enter adjacency matrix (use 0 for no edge):\n";
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> graph[i][j];
            if (graph[i][j] == 0 && i != j)
                graph[i][j] = INF; // No edge → infinity
        }
    }

    int selected[20] = {0};  // To track visited vertices
    selected[0] = 1;         // Start from vertex 0

    int edges = 0;
    int totalCost = 0;

    cout << "\nEdges in the Minimum Spanning Tree:\n";

    while (edges < n - 1) {
        int minWeight = INF;
        int u = -1, v = -1;

        // Find the minimum cost edge connecting selected to unselected
        for (int i = 0; i < n; i++) {
            if (selected[i] == 1) {  
                for (int j = 0; j < n; j++) {
                    if (selected[j] == 0 && graph[i][j] < minWeight) {
                        minWeight = graph[i][j];
                        u = i;
                        v = j;
                    }
                }
            }
        }

        cout << u << " -- " << v << "  (Weight = " << minWeight << ")\n";
        totalCost += minWeight;
        selected[v] = 1;
        edges++;
    }

    cout << "\nTotal cost of Minimum Spanning Tree = " << totalCost << endl;

    return 0;
}

```

# 34. Write a Program to implement Kruskal’s algorithm to find the minimum spanning tree of a user defined graph.
```cpp
#include <iostream>
using namespace std;

#define MAXE 100   // maximum number of edges
#define MAXV 50    // maximum number of vertices

// Edge structure
struct Edge {
    int u, v;   // endpoints
    int w;      // weight
};

// Find parent (with path compression)
int findParent(int v, int parent[]) {
    if (parent[v] == v)
        return v;
    return parent[v] = findParent(parent[v], parent);
}

// Union of two sets
void unionSet(int a, int b, int parent[]) {
    a = findParent(a, parent);
    b = findParent(b, parent);
    if (a != b) {
        parent[b] = a;    // attach one tree under another
    }
}

// Bubble sort edges by weight (ascending)
void sortEdges(Edge e[], int m) {
    for (int i = 0; i < m - 1; i++) {
        for (int j = 0; j < m - 1 - i; j++) {
            if (e[j].w > e[j + 1].w) {
                Edge temp = e[j];
                e[j] = e[j + 1];
                e[j + 1] = temp;
            }
        }
    }
}

int main() {
    int n, m;   // n = vertices, m = edges
    Edge edges[MAXE];

    cout << "Enter number of vertices: ";
    cin >> n;

    cout << "Enter number of edges: ";
    cin >> m;

    cout << "Enter edges (u v weight) with vertices numbered from 0 to " << n - 1 << ":\n";
    for (int i = 0; i < m; i++) {
        cin >> edges[i].u >> edges[i].v >> edges[i].w;
    }

    // Sort edges by their weight
    sortEdges(edges, m);

    int parent[MAXV];
    for (int i = 0; i < n; i++)
        parent[i] = i;

    int edgeCount = 0;
    int totalCost = 0;

    cout << "\nEdges in the Minimum Spanning Tree (Kruskal):\n";

    for (int i = 0; i < m && edgeCount < n - 1; i++) {
        int u = edges[i].u;
        int v = edges[i].v;
        int w = edges[i].w;

        int pu = findParent(u, parent);
        int pv = findParent(v, parent);

        // If they belong to different sets, include this edge
        if (pu != pv) {
            cout << u << " -- " << v << "  (Weight = " << w << ")\n";
            totalCost += w;
            edgeCount++;
            unionSet(pu, pv, parent);
        }
    }

    if (edgeCount != n - 1) {
        cout << "\nMST cannot be formed (graph might be disconnected).\n";
    } else {
        cout << "\nTotal cost of Minimum Spanning Tree = " << totalCost << endl;
    }

    return 0;
}

```

# 35. Write a Program to implement Dijkstra’s algorithm to find shortest distance between two nodes of a user defined graph.

```cpp
#include <iostream>
using namespace std;

#define INF 999999
#define MAX 20

int main() {
    int n;
    int graph[MAX][MAX];
    int dist[MAX], visited[MAX];
    int src, dest;

    cout << "Enter number of vertices: ";
    cin >> n;

    cout << "Enter adjacency matrix (0 for no edge):\n";
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> graph[i][j];
            if (graph[i][j] == 0 && i != j)
                graph[i][j] = INF; // no connection
        }
    }

    cout << "Enter source vertex: ";
    cin >> src;

    cout << "Enter destination vertex: ";
    cin >> dest;

    // Initialize distances
    for (int i = 0; i < n; i++) {
        dist[i] = INF;
        visited[i] = 0;
    }

    dist[src] = 0;

    // Dijkstra's Algorithm
    for (int count = 0; count < n - 1; count++) {
        int u = -1;
        int minDist = INF;

        // Pick the unvisited vertex with the smallest dist[]
        for (int i = 0; i < n; i++) {
            if (!visited[i] && dist[i] < minDist) {
                minDist = dist[i];
                u = i;
            }
        }

        if (u == -1)
            break; // no reachable vertices remain

        visited[u] = 1;

        // Relax edges
        for (int v = 0; v < n; v++) {
            if (!visited[v] && graph[u][v] != INF &&
                dist[u] + graph[u][v] < dist[v]) 
            {
                dist[v] = dist[u] + graph[u][v];
            }
        }
    }

    // Output result
    if (dist[dest] == INF)
        cout << "No path exists between " << src << " and " << dest << endl;
    else
        cout << "Shortest distance from " << src << " to " << dest 
             << " = " << dist[dest] << endl;

    return 0;
}

```

# 36. Write a Program to accept a graph from a user and represent it with Adjacency List and perform BFS traversal on it.
```cpp
#include <iostream>
#include <vector>
#include <queue>
using namespace std;

int main() {
    int n, e;
    cout << "Enter number of vertices: ";
    cin >> n;

    cout << "Enter number of edges: ";
    cin >> e;

    // adjacency list
    vector<int> adj[50];

    cout << "Enter edges (u v) for an undirected graph:\n";
    for (int i = 0; i < e; i++) {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
        adj[v].push_back(u); // remove this line if graph is directed
    }

    int start;
    cout << "Enter starting vertex for BFS: ";
    cin >> start;

    // BFS
    vector<int> visited(n, 0);
    queue<int> q;

    visited[start] = 1;
    q.push(start);

    cout << "\nBFS Traversal: ";

    while (!q.empty()) {
        int node = q.front();
        q.pop();
        cout << node << " ";

        for (int neighbor : adj[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                q.push(neighbor);
            }
        }
    }

    cout << endl;
    return 0;
}

```

# 37. Implement a hash table with collision resolution using linear probing
```cpp
#include <iostream>
using namespace std;

#define SIZE 10   // size of hash table

class HashTable {
    int table[SIZE];

public:
    HashTable() {
        for (int i = 0; i < SIZE; i++)
            table[i] = -1;      // -1 means empty slot
    }

    // Hash function
    int hashFunc(int key) {
        return key % SIZE;
    }

    // Insert using linear probing
    void insertKey(int key) {
        int index = hashFunc(key);

        // Linear probing until empty slot found
        int startIndex = index;
        while (table[index] != -1) {
            index = (index + 1) % SIZE;
            if (index == startIndex) {
                cout << "Hash table is full! Cannot insert.\n";
                return;
            }
        }

        table[index] = key;
        cout << "Inserted " << key << " at index " << index << endl;
    }

    // Search a key
    void searchKey(int key) {
        int index = hashFunc(key);
        int startIndex = index;

        while (table[index] != -1) {
            if (table[index] == key) {
                cout << "Key " << key << " found at index " << index << endl;
                return;
            }
            index = (index + 1) % SIZE;
            if (index == startIndex)
                break;
        }

        cout << "Key " << key << " NOT found.\n";
    }

    // Display hash table
    void display() {
        cout << "\nHash Table:\n";
        for (int i = 0; i < SIZE; i++) {
            cout << i << " --> ";
            if (table[i] != -1)
                cout << table[i];
            else
                cout << "EMPTY";
            cout << endl;
        }
    }
};

// ---------------- MAIN ----------------
int main() {
    HashTable ht;
    int choice, key;

    while (true) {
        cout << "\n--- HASH TABLE MENU ---\n";
        cout << "1. Insert Key\n";
        cout << "2. Search Key\n";
        cout << "3. Display Table\n";
        cout << "4. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter key to insert: ";
            cin >> key;
            ht.insertKey(key);
            break;

        case 2:
            cout << "Enter key to search: ";
            cin >> key;
            ht.searchKey(key);
            break;

        case 3:
            ht.display();
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice.\n";
        }
    }
}

```

# 38. Use hash table to Store and retrieve student records using roll numbers in cpp.
```cpp
#include <iostream>
using namespace std;

#define SIZE 10   // hash table size

struct Student {
    int roll;
    string name;
    bool occupied;

    Student() {
        roll = -1;
        name = "";
        occupied = false;
    }
};

class HashTable {
    Student table[SIZE];

public:
    // Hash function
    int hashFunc(int roll) {
        return roll % SIZE;
    }

    // Insert student record
    void insertRecord(int roll, string name) {
        int index = hashFunc(roll);
        int startIndex = index;

        // Linear probing to find empty slot
        while (table[index].occupied) {
            index = (index + 1) % SIZE;

            if (index == startIndex) {
                cout << "Hash Table FULL! Cannot insert.\n";
                return;
            }
        }

        table[index].roll = roll;
        table[index].name = name;
        table[index].occupied = true;
        cout << "Inserted [" << roll << " → " << name << "] at index " << index << endl;
    }

    // Search student by roll number
    void searchRecord(int roll) {
        int index = hashFunc(roll);
        int startIndex = index;

        while (table[index].occupied) {
            if (table[index].roll == roll) {
                cout << "Record found!\n";
                cout << "Roll No: " << table[index].roll << "\nName: " << table[index].name << endl;
                return;
            }

            index = (index + 1) % SIZE;
            if (index == startIndex)
                break;
        }

        cout << "Record NOT found!\n";
    }

    // Display complete table
    void display() {
        cout << "\nHash Table (Student Records):\n";
        for (int i = 0; i < SIZE; i++) {
            cout << i << " → ";
            if (table[i].occupied)
                cout << table[i].roll << " | " << table[i].name;
            else
                cout << "EMPTY";
            cout << endl;
        }
    }
};

// ---------------- MAIN ----------------

int main() {
    HashTable ht;
    int choice, roll;
    string name;

    while (true) {
        cout << "\n--- STUDENT RECORD HASH TABLE ---\n";
        cout << "1. Insert Student Record\n";
        cout << "2. Search Student Record\n";
        cout << "3. Display Hash Table\n";
        cout << "4. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
        case 1:
            cout << "Enter Roll No: ";
            cin >> roll;
            cout << "Enter Name: ";
            cin >> name;
            ht.insertRecord(roll, name);
            break;

        case 2:
            cout << "Enter Roll No to search: ";
            cin >> roll;
            ht.searchRecord(roll);
            break;

        case 3:
            ht.display();
            break;

        case 4:
            return 0;

        default:
            cout << "Invalid choice!\n";
        }
    }
}

```


