/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:05.08.2021*/
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include "Trie.h"
using namespace std;

int main(int argc, char *argv[]){

    if(argc < 2){
        cout<< "The text file is not available"<<endl;
        return 1;
    }

    int word_place=0;

    Trie trie;

    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file
    if(casefile.is_open()){
        while(getline(casefile, line)){   // takes the lines from casefile and store it in line string
            stringstream ss(line); 
            word_place++;

        while(1){
                    string word;
                    ss>>word;
                    //cout<<word<<" ";
                    string lowerword = "";
                
                    for(char lowchar: word){
                        if(tolower(lowchar) < 'a' || tolower(lowchar) > 'z'){
                            continue;
                        }else{
                            lowerword += tolower(lowchar);  // if they are not lowercase make them lower
                        }
                    }

                    trie.insert_word(lowerword, word_place);

                    if(ss.eof()){   //if end of the line break
                        break;}
                }
                //cout<<word_place<<endl;
        }
    }
    for(int i=2; i<argc;i++ ){  //this takes the command line arguments
        trie.find_word(argv[i]); // and seach them
    }

    return 0;
}

