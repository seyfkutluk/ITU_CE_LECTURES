/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:29.07.2021*/
#include <iostream>
#include "Board.h"

using namespace std;

int k=0;


Board::Board(int dim, int outX, int outY){
    this->DIM=dim;
    this->outX=outX;
    this->outY=outY;
}

Board::Board(){
    this->DIM=0;
    this->outX=0;
    this->outY=0;
}

void Board::SetBoard(int dim, int outx, int outy){
    this->DIM=dim;
    this->outX=outX;
    this->outY=outY;

    board = new char*[dim];
    for(int i=0;i<dim;i++)
    board[i] = new char[dim];

}

Board::Board(const Board &p1){
    this->DIM=p1.DIM;
    this->outX=p1.outX;
    this->outY=p1.outY;

    board = new char*[DIM];
    for(int i=0;i<DIM;i++)
        board[i] = new char[DIM];

    for(int i=0;i<DIM;i++)
        for(int j=0;j<DIM;j++)
            board[i][j]=p1.board[i][j];

    pieces = p1.pieces;
}

void Board::addPiece(Piece ap){
    this->pieces.push_back(ap);
}

void Board::buildBoard(){
    for(int i=0;i<DIM;i++)
        for(int j=0;j<DIM;j++)
            board[i][j]='_';

    for(Piece p:pieces){
        if(p.get_hor()){
            for(int i=p.get_startY();i<=p.get_endY();i++)
                board[p.get_startX()][i]=p.get_sign();
        }
        else{
            for(int i=p.get_startX();i<=p.get_endX();i++)
                board[i][p.get_startY()]=p.get_sign();
        }
    }

}

void Board::printBoard(){
    for(int i=0;i<DIM;i++){
        for(int j=0;j<DIM;j++)
            cout<<board[i][j]<<" ";
        cout<<endl;
    }
    cout<<endl;
}

vector<Move> Board::getMoves(){
    vector<Move> moves;

    for(Piece p:pieces){
        if(p.get_hor()){
            if(p.get_startY()-1>=0 && board[p.get_startX()][p.get_startY()-1]=='_')
                moves.push_back(Move(p, LEFT));
            
            if(p.get_endY()+1<DIM && board[p.get_startX()][p.get_endY()+1]=='_')
                moves.push_back(Move(p, RIGHT));
        }
        else{
            if(p.get_startX()-1>=0 && board[p.get_startX()-1][p.get_endY()]=='_')
                moves.push_back(Move(p, UP));
            
            if(p.get_endX()+1<DIM && board[p.get_endX()+1][p.get_endY()]=='_')
                moves.push_back(Move(p, DOWN));
        }

    }

    return moves;
}

void Board::move(Move m){

    for(Piece& p:pieces){
        if(p.get_sign()==m.getpiece().get_sign())
            p.move(m.getdir());
    }

    this->buildBoard();
}

bool Board::equals(Board b){
    for(int i=0;i<DIM;i++)
        for(int j=0;j<DIM;j++)
            if(board[i][j]!=b.board[i][j])
                return false;

    return true;
}

bool Board::checkend(){
    return board[outX][outY]=='X'; 
}

// bool Board::SolveBoard(){
//     // Move move1(pieces[0],DOWN);
//     // Move move2(pieces[0],DOWN);
//     // move(move1);
//     // move(move2);
//     DIR a;


//     // This part of the code is to start the first movement which is for X
//     if(pieces[k].get_vert() && pieces[k].get_startY()<outY ){   
//         cout<<"verti"<<"UP"<<endl;
//         if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,UP)){}
//     }
//     else if( pieces[k].get_vert() && pieces[k].get_startY()>outY){
//         cout<<"verti"<<"DOWN"<<endl;
//         if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,DOWN)){}
//     }

//     if(pieces[k].get_hor() && pieces[k].get_startX()<outX){
//         cout<<"hor"<<"rıght"<<endl;
//         if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,LEFT)){}
//     }
//     else if(pieces[k].get_hor() && pieces[k].get_startX()>outX ){
//         cout<<"hor"<<"left"<<endl;
//         if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,RIGHT)){}
//     }

    
//     return true;
// }

// bool Board::find_the_final_spot(char** maze, int cur_y,int cur_x, int exit_x, int exit_y, DIR camefrom){



//     return false;
// }










    // if(pieces[k].get_vert() && pieces[k].get_startY()<outY && board[pieces[k].get_startY()+1][pieces[k].get_startX()] != '_'){
    //     cout<<"verti"<<"UP"<<endl;
    //     if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,UP)){
    //         Move a(pieces[k],camefrom);
    //         move(a);
    //         printBoard();
    //         return true;
    //     }
    //     else{
    //         find_the_final_spot(board, pieces[k+1].get_startY(),pieces[k].get_startX(),outY,outX,UP);
    //     }
    // }
    // else if( pieces[k].get_vert() && pieces[k].get_startY()>outY && board[pieces[k].get_startY()-1][pieces[k].get_startX()] != '_'){
    //     cout<<"verti"<<"DOWN"<<endl;
    //     if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,DOWN)){
    //         Move a(pieces[k],camefrom);
    //         move(a);
    //         printBoard();
    //         return true;
    //     }
    //     else{
    //         find_the_final_spot(board, pieces[k+1].get_startY(),pieces[k].get_startX(),outY,outX,DOWN);
    //     }
    // }

    // if(pieces[k].get_hor() && pieces[k].get_startX()<outX && board[pieces[k].get_startY()][pieces[k].get_startX()-1] != '_'){
    //     cout<<"hor"<<"rıght"<<endl;
    //     if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,LEFT)){
    //         Move a(pieces[k],camefrom);
    //         move(a);
    //         printBoard();
    //         return true;
    //     }
    //     else{
    //         find_the_final_spot(board, pieces[k+1].get_startY(),pieces[k].get_startX(),outY,outX,LEFT);
    //         return true;
    //     }
    // }
    // else if(pieces[k].get_hor() && pieces[k].get_startX()>outX &&( board[pieces[k].get_startY()][pieces[k].get_startX()+1] != '_' && &board[pieces[k].get_startY()][pieces[k].get_startX()+1] == NULL )){
    //     cout<<"hor"<<"left"<<endl;
    //     if(find_the_final_spot(board, pieces[k].get_startY(),pieces[k].get_startX(),outY,outX,RIGHT)){
    //         Move a(pieces[k],camefrom);
    //         move(a);
    //         printBoard();
    //         return true;
    //     }
    //     else{
    //         find_the_final_spot(board, pieces[k+1].get_startY(),pieces[k].get_startX(),outY,outX,RIGHT);
    //         Move a(pieces[k],camefrom);
    //         move(a);
    //         printBoard();
    //         return true;
    //     // }
    // }






    // if(pieces[].get_vert() && pieces[0].get_startY()<outY){
    //     cout<<"verti"<<"UP"<<endl;
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,UP)){}
    // }
    // else if( pieces[0].get_vert() && pieces[0].get_startY()>outY){
    //     cout<<"verti"<<"DOWN"<<endl;
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,DOWN)){}
    // }

    // if(pieces[0].get_hor() && pieces[0].get_startX()<outX){
    //     cout<<"hor"<<"rıght"<<endl;
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,LEFT)){}
    // }
    // else if(pieces[0].get_hor() && pieces[0].get_startX()>outX){
    //     cout<<"hor"<<"left"<<endl;
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,RIGHT)){}
    // }

    // if(pieces[0].get_vert() && pieces[0].get_startY()<outY && maze){
    //     cout<<"verti"<<"UP";
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,UP)){
    //         return true;
    //     }
    // }
    // else if( pieces[0].get_vert() && pieces[0].get_startY()>outY){
    //     cout<<"verti"<<"DOWN";
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,DOWN)){}
    // }

    // if(pieces[0].get_hor() && pieces[0].get_startX()<outX){
    //     cout<<"hor"<<"left";
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,LEFT)){}
    // }
    // else if(pieces[0].get_hor() && pieces[0].get_startX()>outX){
    //     cout<<"hor"<<"right";
    //     if(find_the_final_spot(board, pieces[0].get_startY(),pieces[0].get_startX(),outY,outX,RIGHT)){}
    // }