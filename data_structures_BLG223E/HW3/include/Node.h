#include <iostream>
using namespace std;

class Blocks{
    string from,to;
    int balance;
    public:
    Blocks(const string &,const string &, int);
    ~Blocks(){};
    void PRINT() const;
    string getFrom(){return from;};
    int getbalance(){return balance;};
    void setFrom(int a){balance=balance-a;};
    string getTo(){return to;};
    void setTo(int a){balance=balance+a;};
};

