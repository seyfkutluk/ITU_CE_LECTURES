
/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:15.07.2021*/
#include <iostream>
using namespace std;

#define MAX 100000
class Expandingarray{
    private:
    int arr[MAX];
    int capacity;
    int capacity_beginning;
    int size;
    string strategy;
    void capacity_down(string);
    void capacity_up(string);

    public:
    Expandingarray(int capacity=0);
    
    void put_strategy(string);
    void clear();
    int getcapacity();
    int getsize();
    void add(int);
    void dell(int);
    int find(int);
    void print();
};