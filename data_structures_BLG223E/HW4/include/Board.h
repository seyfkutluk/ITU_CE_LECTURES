/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:29.07.2021*/
#pragma once
#include "Piece.h"
#include "Move.h"
#include <vector>

using namespace std;

class Board{
    private:
        int DIM;
        int outX, outY;
        friend class Piece;
    public:
        char** board;
        vector<Piece> pieces;
        Board(int,int,int);
        Board();
        void SetBoard(int,int,int);
        Board(const Board&);
        void addPiece(Piece);
        int getOutX(){return outX;};
        int getOutY(){return outY;};
        void buildBoard();
        void printBoard();
        vector<Move> getMoves();
        void move(Move);
        bool equals(Board);
        bool checkend();
        bool SolveBoard();
        bool find_the_final_spot(char**, int ,int , int , int ,DIR );

};