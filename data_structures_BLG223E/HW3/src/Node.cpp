#include <iostream>
#include <string>
#include "Node.h"

using namespace std;

Blocks::Blocks(const string & from,const string & to , int balance){
    this->from=from;
    this->to=to;
    this->balance=balance;
}
void Blocks::PRINT() const{
    cout<<to<<"BALANCE"<<balance<<endl;
}
