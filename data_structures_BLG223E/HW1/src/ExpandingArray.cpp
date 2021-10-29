/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:15.07.2021*/
#include "Expandingarray.h"
#include <iostream>
#include <math.h>

using namespace std;

Expandingarray::Expandingarray(int capacity)
{
    this->capacity=capacity;
    capacity_beginning=capacity;
    size=0;
    strategy="TWICE";
}
void Expandingarray::capacity_down(string command1){
    if(command1.compare("TWICE")==0){
        if(size <= capacity/2){
            capacity >>=1;
        }
    }
    if(command1.compare("LOG")==0)
    {
        int c=(int)log2(capacity);
        if(size <= capacity-c){
            capacity-=c;
        }
    }
    if(command1.compare("CAP_BY_CAP")==0){
        if(size <= capacity- capacity_beginning){
            capacity-=capacity_beginning;
        }
    }
}

void Expandingarray::capacity_up(string command1){
    if(size<=capacity){return;}
    if(command1.compare("TWICE")==0){
        capacity <<=1;
    }
    if(command1.compare("LOG")==0)
    {
        capacity+=(int)log2(capacity);
    }
    if(command1.compare("CAP_BY_CAP")==0){
        capacity +=capacity_beginning;
    }
}

void Expandingarray::put_strategy(string strategy){
    this->strategy=strategy;
}

int Expandingarray::getcapacity(){
    return capacity;
}

int Expandingarray::getsize(){
    return size;
}

void Expandingarray::add(int number){
    arr[size++]=number;
    capacity_up(strategy);
}

void Expandingarray::dell(int number){
    int a=1;
    for(int i=0; i<size; i++){
        if(arr[i]==number&& a==1){
            a=0;
            continue;
        }
        if(a==0){
            arr[i-1]=arr[i];
        }
    }
    if(a==0){
        size--;
        capacity_down(strategy);
    }
}

int Expandingarray::find(int number){
    for(int i=0; i<size; i++){
        if(arr[i]==number){
            return i;
            break;
        }
    }
    return -1;
}

void Expandingarray::print(){
    for(int i=0;i<size;i++){
        cout<<arr[i]<<" ";
    }
}

void Expandingarray::clear(){
    capacity=capacity_beginning;
    size=0;
}