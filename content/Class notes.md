---
title: Class notes
---

```cpp
#include<iostream>

using namespace std;

  

int main(){

    int sparse[20][20], a[20][20];

    int rows, cols,nz,k=1;

    cout << "Enter the number of rows and coloums :";

    cin >> rows >> cols;

  

    for (int i = 0 ; i < rows ; i++){

        for (int j = 0; j < cols ; j++){

            cin >> a[i][j];

        }

    }

  

    for (int i = 0 ; i < rows ; i++){

        for(int j = 0 ; j < cols; j++){

            cout << a[i][j] << " ";

        }

  

        cout << endl;

    }

  

    sparse[0][0]= rows;

    sparse[0][1]=cols;

    for (int i = 0 ; i < rows; i++){

        for (int j = 0 ; j < cols ; j++){

            if(a[i][j] != 0 ){

                sparse[k][2] = a[i][j];

                sparse[k][1] = j;

                sparse[k][0] = i;

  

                k++;

            }

        }

    }

    sparse[0][2]= k-1;

  

    for(int i = 0; i <= sparse[0][2]; i++){

        cout << "\t"<<  sparse[i][0] <<" "<<  sparse[i][1]<< " "<< sparse[i][2] << endl;

    }

  
  

    cout << endl;

    for(int i = 0; i <= sparse[0][2]; i++){

        cout << "\t"<<  sparse[i][1] <<" "<<  sparse[i][0]<< " "<< sparse[i][2] << endl;

    }

  

  
  

}
```