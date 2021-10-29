/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:17.08.2021*/
//#include <string>
#include <fstream>
#include <sstream>
#include "SkipList.h"

//using namespace std;
// ı did not used iostream header since its a pretty big header file and it affect compile time
// Also ı did not used all namespaces ı used needed one with std::
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
        std::string name;
        int seed; 
        first >> name;
        first >> seed;
        srand(seed);

        std::getline(casefile, line);
        std::stringstream second(line);
        std::string name1;
        int level; 
        second >> name1;
        second >>level;
        SkipList skiplist(level);

        while(getline(casefile, line)){   // takes the lines from case file and store it in line string
            std::string command;
            std::stringstream ss(line);
            ss>>command;
            if(command.compare("ADD")==0){
                while(!ss.eof()){
                    int added;
                    ss>>added;
                    skiplist.add(added);
                }
            }
            if(command.compare("DEL")==0){
                while(!ss.eof()){
                    int dell;
                    ss>>dell;
                    skiplist.dell(dell);
                }
            }
            if(command.compare("CONTAINS")==0){
                while(!ss.eof()){
                    int contain;
                    ss>>contain;
                    skiplist.is_contain(contain);
                }
            }
            if(command.compare("CLEAR")==0){
                skiplist.clear();
            }
            if(command.compare("PRINT")==0){
                skiplist.print();
            }
        }
    }
    casefile.close();
    return 0;
}
