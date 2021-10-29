#include <iostream>
#include <stdio.h>
#include <stack>
#include <string>
#include <bits/stdc++.h>
#include "Tree.h"
#include <bitset>
#include <math.h>

using namespace std;

void recursive_permutation(char** arr, int start, int end);

int main()
{
    string number;

    cin>>number;

    //cout<<number<<" "<<number.size()<<" ";

    double size1=log2(number.size());
    //cout<<size1<<" ";
    int size=log2(number.size());
    if(size1==(double)size){size=size1;
    //cout<<size;
    }
    else{size=(int)size1+1;
    //cout<<size;
    }
    
    vector<vector<int> > output(size+1,vector<int>(1 << size+1));

    unsigned fill = 1U << (size-1);

    for(unsigned colum=0; colum<size; ++colum,fill >>=1U){
        for(unsigned row=fill; row<(1U <<size); row +=(fill*2))
        {
            fill_n(&output[colum][row], fill, 1);
        }
    }

    for(unsigned i=0 ;i<(1<<size); ++i){
        fill_n(&output[size][i],1,(int)number[i]%48);
    }

    // for(unsigned i=0 ;i<(1<<size); ++i){
    //     for(unsigned j=0; j<size; ++j){
    //         cout<<output[j][i]<<" ";
    //     }
    //     cout<<endl;
    // }

    char **arr = new char*[size];
    string order;
	for(int i=0;i<size;i++){
        arr[i]= new char[2];
		arr[i][0] = 65+i;
		order.push_back(arr[i][0]);
    }
    recursive_permutation(arr, 0, size-1);

    delete[] arr;
    return EXIT_SUCCESS;
}
int total=0;


void recursive_permutation(char** arr, int start, int end){
    int i;
    string *newString = new string;
    if (start == end) { 
  	    for (i = 0; i <= end; i++){ 
            char temp = arr[i][0] ;
       	    //cout << arr[i][0];
            newString->push_back(temp);}
        string last=*newString;
        if(last[2]=='B')
        {cout<<last<<" ";
        total++;
        }
        

    }
    else { 
        for (i = start; i <= end; i++){
  	 	    std::swap(arr[start][0], arr[i][0]);
  	 	    recursive_permutation(arr, start + 1, end);
  	 	    std::swap(arr[start][0], arr[i][0]);
        }
  	}
    delete newString;	
}


