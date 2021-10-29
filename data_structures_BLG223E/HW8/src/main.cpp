/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:12.08.2021*/
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <bits/stdc++.h>

using namespace std;

void find_path(int from, int to, int size, vector<vector<int>> restriction, list<int>* matrix);
void print_path(int from,int to, int size,int has_visit[],int path[],int& index,list<int>* matrix, vector<vector<int>> restriction);


vector<string> names;

int main(int argc, char *argv[]){

    if(argc < 2){
        cout<< "The text file is not available"<<endl;
        return 1;
    }

    list<int>* matrix;
    vector<vector<int>> restriction;

    int dimension,walk_length;
    int linenumber=0;

    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file
    if(casefile.is_open()){
        getline(casefile, line);
        stringstream s (line);
        s >> dimension;
        matrix = new list<int>[dimension];

        while(getline(casefile, line)){   // takes the lines from case file and store it in line string
            stringstream ss(line);

            if(linenumber<dimension){
                for(int i=0; i<dimension; i++){
                    int num;
                    ss>>num;
                    if(num==1){ 
                       matrix[linenumber].push_back(i);
                    }
                }
            }
            if(dimension<=linenumber && linenumber<2*dimension){
                char word;
                int numb;
                ss>>word;
                ss>>numb;
                vector<int> row1;
                row1.push_back(word-65);
                row1.push_back(numb);
                restriction.push_back(row1);
            }
            if(linenumber==2*dimension){
                ss>>walk_length;
            }
          linenumber++;
        }

        for(int from=0; from<dimension; from++){
            for(int to=0; to<dimension; to++){
                if(restriction[from][1]==0 || restriction[to][1]==0){
                    break;
                }
                else{
                    find_path(from, to, walk_length, restriction, matrix);
                }
            }
        }
    }

    names.erase(unique( names.begin(), names.end()), names.end());

    for(vector<string>::const_iterator i=names.begin(); i!=names.end(); i++){
        cout<<*i<<" ";
    }
    casefile.close();


    return 0;
}

void find_path(int from, int to, int size,  vector<vector<int>> restriction, list<int>* matrix)
{
    int numb=30;
    int index=0;
    int has_visit[numb],path[numb];

    for(int i=0; i<numb; i++)
    {
        has_visit[i]= 0;
    }
    print_path(from, to, size, has_visit, path, index, matrix, restriction);
}

void print_path(int from,int to, int size,int has_visit[],int path[],int& index,list<int>* matrix, vector<vector<int>> restriction){
    has_visit[from]=1;
    path[index]=from;
    index++;

    if(index==size){
        string the_way;
        for(int i=0; i<index; i++){
            char a='A';
            a+=path[i];
            the_way.push_back(a);
            for(int j=0; j<restriction.size(); j++){
                if(path[i]==path[i+1] || path[i]==path[i-1] || (restriction[j][0]==path[i] && restriction[j][1]==0)){
                    i=index;
                    the_way="";
                }
                if(restriction[j][0]==path[i] && restriction[j][1]!=-1){
                    restriction[j][1]--;
                }
            }
        }

        if(the_way!=""){
            for(int l=0; l<restriction.size(); l++){
                if(restriction[l][1]!=0 &&restriction[l][1]!=-1){
                    the_way="";
                }
            }
            if(the_way!=""){
                    names.push_back(the_way);
                    //cout<<the_way<<" ";
                }
        }
    }
    else{
        for(auto const &i:matrix[from]){
            print_path(i, to, size,has_visit, path, index, matrix, restriction);
        }
    }

    has_visit[from]=0;
    index--;

}