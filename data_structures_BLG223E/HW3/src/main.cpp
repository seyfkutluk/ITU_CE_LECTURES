/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:16.07.2021*/
#include "BlockList.h"
//#include "BlockNode.h"
#include<iostream>
#include<fstream>
#include<string>
#include<stdio.h>
#include<stack>
#include<sstream>
using namespace std;

const int MAX_NUMBER_OF_NUMBERS=100;

int main(int argc, char *argv[]){
    if(argc < 2){
        cout<< "The text file is not available"<<endl;
        return 1;
    }

    Blocklist blocklist,individuals,individualschanged;
    cout<<"file"<<endl; 
    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file
    if(casefile.is_open()){
        cout<<"casefile is open"<<endl; 
        while(getline(casefile, line)){   // takes the lines from casefile and store it in line string
            stringstream ss(line);  // ss is used to break the the numbers and words

            string name;
            int balance;   

            string command;
            string fromname, toname;
            int howmuch;

                     

            int a;
            if(a==0){  // to read first command
                while(1){
                    ss>>name;
                    ss>>balance;
                    //individuals.append(name,name,balance);
                    //individualschanged.append(name,name,balance);
                    cout<<name<<" "<<balance<< " ";

                    if(ss.eof()){break;}

                    
                }
                cout<<endl;
                
                a=1;
            }

            ss>>command;

            if(command.compare("BLOCK")==0){
                cout<<command<<" ";
                while(1){
                    ss>>fromname;
                    ss>>toname;
                    ss>>howmuch;
                    //blocklist.append(fromname,toname,howmuch);
                    cout<<fromname<<toname<<howmuch;
                    individuals.del(fromname,toname,howmuch);
                    //cout<<fromname<<toname<<howmuch;


                    if(ss.eof()){break;}
                }
                cout<<endl;
                //cout<<time<<" "<<command<<" "<<id<<" "<<mi<<" "<<endl;
            }

            if(command.compare("BALANCE")==0){
                 cout<<"BALANCE is called"<<endl;
                 individuals.PRINT();
                //cout<<time<<" "<<command<<" "<<id<<" "<<mi<<" "<<endl;
            }

            if(command.compare("CLEAR")==0){
                cout<<"CLEAR is called"<<endl;
                //cout<<time<<" "<<command<<" "<<id<<" "<<mi<<" "<<endl;
            }

            if(command.compare("PRINT")==0){
                cout<<"PRINT is called"<<endl;
                    //blocklist.PRINT();

                //cout<<time<<" "<<command<<" "<<id<<" "<<mi<<" "<<endl;
            }
    
 
            
        }
    }
    casefile.close();

    return 0;
}