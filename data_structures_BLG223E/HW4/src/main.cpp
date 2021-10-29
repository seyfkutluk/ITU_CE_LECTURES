/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:29.07.2021*/
#include "Board.h"
#include "Piece.h"
#include "Move.h"
#include<iostream>
#include<fstream>
#include<string>
#include<stdio.h>
#include<stack>
#include<sstream>
#include <vector>
using namespace std;

const int MAX_NUMBER_OF_NUMBERS=100;

int DIMENSION;

void moveboard(Board board1,int index, DIR direc);
bool solver(Board board);
bool find_the_final_spot(Board board1, Board board, DIR);

int main(int argc, char *argv[]){
    if(argc < 2){
        cout<< "The text file is not available"<<endl;
        return 1;
    }

    int dimension, row,column;
    string command;

    string id, vertic_or_horiz;
    int initx, inity, finalx, finaly;

    int a=0;

    Board board1; 

    //cout<<"file"<<endl; 
    fstream casefile;
    string line;
    casefile.open(argv[1],ios::in); // to open case file
    if(casefile.is_open()){
        //cout<<"casefile is open"<<endl; 
        while(getline(casefile, line)){   // takes the lines from casefile and store it in line string
            stringstream ss(line);  // ss is used to break the the numbers and words

            if(a==0){  // to read first command
                ss>>dimension;
                ss>>row;
                ss>>column;
                ss>>command;
                DIMENSION=dimension;
                cout<<dimension<<" "<<row<<" "<<column<<" "<<command<<endl;
                board1.SetBoard(dimension,row,column);
                a=1;
            }
            
            ss>>id;
            ss>>vertic_or_horiz;

            if(vertic_or_horiz.compare("V")==0){
                //cout<<command<<"Vertical"<<endl;
                ss>>initx;
                ss>>inity;
                ss>>finalx;
                ss>>finaly;
                cout<<id<<" " <<vertic_or_horiz<<" "<<initx<<" "<<inity<<" "<<finalx<<" "<<finaly<<endl;
                Piece piece(id,vertic_or_horiz,initx,inity,finalx,finaly);
                board1.addPiece(piece);
                
            }        
            if(vertic_or_horiz.compare("H")==0){
                //cout<<command<<"Horizantel"<<endl;
                ss>>initx;
                ss>>inity;
                ss>>finalx;
                ss>>finaly;
                cout<<id<<" "<<vertic_or_horiz<<" "<<initx<<" "<<inity<<" "<<finalx<<" "<<finaly<<endl;
                Piece piece(id,vertic_or_horiz,initx,inity,finalx,finaly);
       
                board1.addPiece(piece);
            }     
        }
        board1.buildBoard();
        //moveboard(board1,0,DOWN);  // to try moveboard function
        //board1.printBoard();   // implementation of the given input board can be checked with this line
        //solver(board1);
        if(command.compare("PRINT")==0){
            if(solver(board1)){
            cout<<"Board has been succesfully solved";
        }
        else{
            cout<<"The board cannot be solved";
        }

        }
        if(command.compare("CHECK")==0){
            if(solver(board1)){
            cout<<"Board has been succesfully solved";
        }
        else{
            cout<<"The board cannot be solved";
        }
        }
        
    }
    casefile.close();

    return 0;
}

bool solver(Board board){
if(board.pieces[0].get_vert() && board.pieces[0].get_startY()<board.getOutY() ){   
        //cout<<"verti"<<"UP"<<endl;
        if(find_the_final_spot(board,board,UP)){
            return true;
        }
    }
    else if( board.pieces[0].get_vert() && board.pieces[0].get_startY()>board.getOutY()){
        //cout<<"verti"<<"DOWN"<<endl;
        if(find_the_final_spot(board,board,DOWN)){
            return true;
        }
    }

    if(board.pieces[0].get_hor() && board.pieces[0].get_startX()<board.getOutX()){
        //cout<<"hor"<<"rıght"<<endl;
        if(find_the_final_spot(board,board,LEFT)){
            return true;
        }
    }
    else if(board.pieces[0].get_hor() && board.pieces[0].get_startX()>board.getOutX() ){
        //cout<<"hor"<<"left"<<endl;
        if(find_the_final_spot(board,board,RIGHT)){
            return true;
        }
    }
    return false;


}

bool find_the_final_spot(Board board1, Board board, DIR direction){
    board.printBoard();
    vector<Move> allmoves;
    allmoves=board.getMoves();
    int i=0;
    while(allmoves.size()!=i)
    {
        if(!(direction==LEFT && allmoves[i].getdir()==RIGHT||   // if it came from left and wants to go right
            direction==RIGHT && allmoves[i].getdir()==LEFT||
            direction==DOWN && allmoves[i].getdir()==UP||
            direction==UP && allmoves[i].getdir()==DOWN ))
            {
            board.move(allmoves[i]);
            if(board.equals(board1)){return false;} // if it stays same return false
            else if(find_the_final_spot(board1,board,allmoves[i].getdir())){   return true;}
        }
        i++;
    }
    if(board.checkend()){ // if the "X" is in the final point return true
        return true;
    }
    return false;
}

/*
The idea is moving X towards the final point
if the X hits a piece move the piece up-down
or right left if the peace open the way move 
X if the piece doesnt open the way move the 
piece that didnt let the previous piece move.
And do this for all of the pieces until it 
reaches the final point.
*/