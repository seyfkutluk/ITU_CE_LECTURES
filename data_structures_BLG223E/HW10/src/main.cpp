/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:19.08.2021*/
//#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include "RBVector.h"
using namespace std;
 
int main(int argc, char *argv[]){

    if(argc < 2){
       // std::cout<< "The text file is not available"<<std::endl;
        return 1;
    }

    std::fstream casefile;
    std::string line;
    casefile.open(argv[1],std::ios::in); // to open case file
    if(casefile.is_open()){

        getline(casefile, line);
        std::stringstream first(line);
        std::string rbv;
        int rbv1; 
        first >> rbv;
        first >> rbv1;
        //std::cout<<rbv<<" "<<rbv1<<std::endl;

        while(getline(casefile, line)){   // takes the lines from case file and store it in line string
            std::string command;
            std::stringstream ss(line);
            ss>>command;
            if(command.compare("PUSH")==0){
                std::string pushed;
                ss>>pushed;
                //std::cout<<command<<" "<<pushed<<std::endl;
            }
            if(command.compare("RM")==0){
                std::string rmed;
                ss>>rmed;
                //std::cout<<command<<" "<<rmed<<std::endl;
            }
            if(command.compare("GNC")==0){
            }
            if(command.compare("UPDATE")==0){
                int uptnum;
                std::string updated;
                ss>>uptnum;
                ss>>updated;
                //std::cout<<command<<" "<<uptnum<<" "<<updated<<std::endl;
            }
            if(command.compare("FIND")==0){
                std::string finded;
                ss>>finded;
                //std::cout<<command<<" "<<finded<<std::endl;
            }
            if(command.compare("PRINT")==0){
            }
            if(command.compare("CLEAR")==0){
                //std::cout<<command;
            }
            if(command.compare("RMI")==0){
                int rmi;
                ss>>rmi;
                //std::cout<<command<<" "<<rmi<<std::endl;
            }
            if(command.compare("GNC")==0){
                std::cout<<command<<std::endl;
            }
        }
    }
    casefile.close();
    return 0;
}
