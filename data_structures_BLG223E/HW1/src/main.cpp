/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:15.07.2021*/
#include "Expandingarray.h"
#include<iostream>
#include<fstream>
#include<string>
#include<sstream>
using namespace std;

const int MAX_NUMBER_OF_NUMBERS=10;

int main(int argc, char *argv[]){

    if(argc < 2){
        return 1;
    }
    
    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file
    if(casefile.is_open()){
        string first;
        getline(casefile,first);
        stringstream s(first);
        int initial_capacity;
        s>>initial_capacity;
        Expandingarray array(initial_capacity);

        while(getline(casefile, line)){   // takes the lines from casefile and store it in line string
            stringstream ss(line);  // ss is used to break the the numbers and words

            string command;
            ss>>command;

            if(command.compare("SS")==0){
                string command1;
                ss>>command1;
                array.put_strategy(command1);
            }
            if(command.compare("ADD")==0){
                int added;
                while(ss>>added){
                    array.add(added);
                }
            }
            if(command.compare("REMOVE")==0){
                while(!ss.eof()){
                    int removed;
                    ss>>removed;
                    array.dell(removed);
                }
            }
            if(command.compare("GC")==0){
                cout <<array.getcapacity()<<" ";               
            }
            if(command.compare("GS")==0){
                cout <<array.getsize()<<" ";               
            }
            if(command.compare("PRINT")==0){
                array.print();              
            }
            if(command.compare("CONTAINS")==0){
                int containsnum;
                ss>>containsnum;
                if(array.find(containsnum)!=-1){
                    cout << containsnum<<" is at index "<<array.find(containsnum)<<" ";
                }
                else{
                    cout<<containsnum<<" is not in the array ";
                }
            }
            if(command.compare("CLEAR")==0){
                    array.clear();
                cout <<"CLEAR is called"<<endl;
            }
        }
    }
    casefile.close();
    
    return 0;
}