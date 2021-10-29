/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:10.08.2021*/
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include "Heap.h"
using namespace std;
  


int main(int argc, char *argv[]){

    if(argc < 2){
        cout<< "The text file is not available"<<endl;
        return 1;
    }
    Heap heap(1500);

    string command;
    int heapcapacity;

    string min_or_max;

    vector<int> arr;

    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file
    if(casefile.is_open()){
        int k=0;
        while(getline(casefile, line)){   // takes the lines from casefile and store it in line string
            stringstream ss(line); 
        ss>>command;
        if(command.compare("MINHEAP")==0){
            ss>>heapcapacity;
            min_or_max=command;
            //heap.setcapacity(heapcapacity);
            //cout<<command<<" "<<heapcapacity<<" ";
            while(1){
                            int number;
                            ss>>number;
                            //heap.insertKey(number);
                            //cout<<number<<" ";
                            arr.push_back(number);
                            //cout<<heap.find_index(number)<<" ";
                            if(ss.eof()){   //if end of the line break
                                break;}
                        }
                        // for(int i=0; i<j; i++){
                        //     heap.insertKey(arr[i]);
                        // }
                        //cout<<endl;

        }
        if(command.compare("MAXHEAP")==0){
            ss>>heapcapacity;
            min_or_max=command;
           // heap.setcapacity(heapcapacity);
            //cout<<command<<" "<<heapcapacity<<" ";
            
            while(1){
                            if(ss.eof()){   //if end of the line break
                                break;}
                            else{int number;
                            ss>>number;
                            //heap.insertKey(number);

                            arr.push_back(number);
                            //cout<<number<<" ";
                            }
                           
                        }
                        //cout<<endl;
        }

        if(k==0){
            for(int i= arr.size()-1; i>=0; i--)
                {
                    int num=arr[i];
                    heap.insert(num);
                
                }
                //cout<<endl;
                k=1;
                }

        if(command.compare("ADD")==0){
                            int number;
                            ss>>number;
                            //arr.insert(arr.begin(),number);
                            //arr.push_back(number);
                            heap.insert(number);
                            heap.make();
                            //cout<<command<<" "<<number<<endl;
        }
        if(command.compare("DEL")==0){
                            int number;
                            ss>>number;
                            heap.remove(number);
                            heap.make();

        }

        

        if(command.compare("PRINT")==0){


                            heap.make();
                            heap.print();

                            
        }
        if(command.compare("SORT")==0){
                            //cout<<command<<endl;
                            if(min_or_max.compare("MAXHEAP")==0){
                            heap.sortarraymax();
                            }
                            if(min_or_max.compare("MINHEAP")==0){
                            heap.sortarraymin();}
                            
        }
        

    }
    }
    casefile.close();

    return 0;
}

