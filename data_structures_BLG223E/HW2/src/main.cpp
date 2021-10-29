/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:16.07.2021*/
#include "Processor.h"
#include<iostream>
#include<fstream>
#include<string>
#include<stdio.h>
#include<stack>
#include<sstream>
using namespace std;

const int MAX_NUMBER_OF_NUMBERS=100;

void simulate(Processor& processor, int first_time, int last_time) {
    for (int i = first_time; i <= last_time; i++)
        processor.workjob();
}

int main(int argc, char *argv[]){
    if(argc < 2){
        cout<< "The text file is not available"<<endl;
        return 1;
    }

    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file

    if(casefile.is_open()){
        string first;
        getline(casefile,first);
        stringstream s(first);

        int time, mips, mipsthreshold;
        s>>time>>mips>>mipsthreshold;
        //cout<<time<<mips<<mipsthreshold;
        Processor processor(mips,mipsthreshold);
        
        while(getline(casefile, line)){   // takes the lines from casefile and store it in line string
            stringstream ss(line);  // ss is used to break the the numbers and words
            int first,mips,mipsthreshold;   
            int other_time;
            string command;

            ss>>other_time;
            ss>>command;
            if(command.compare("JOB")==0){
                simulate(processor, time, other_time-1);
                int id,mi;
                ss>>id;
                ss>>mi;
                cout<<command<<id<<mi<<other_time<<endl;
                Job job(id, mi, other_time);
                processor.add(job);
            }
            if(command.compare("PRINT")==0){
                simulate(processor, time, other_time);
                int id;
                ss>>id;
               // cout<<command<<id<<endl;
                processor.print(id);
            }
            if(command.compare("PRINTQ")==0){
                simulate(processor, time, other_time);
                processor.wprint();
               // cout<<command<<id<<endl;

        }
        time=other_time;
    }
    }
    casefile.close();
    return 0;
}