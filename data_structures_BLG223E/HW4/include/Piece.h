/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:29.07.2021*/
#pragma once
#include <string>

enum DIR { UP, DOWN, LEFT, RIGHT };

using namespace std;

class Piece{
    private:
        char sign;
        bool vert;
        bool hor;
        int startX, startY, endX, endY;
    public:
        Piece(string,string,int,int,int,int);
        Piece();
        char get_sign();
        bool get_vert();
        bool get_hor();
        int get_startX();
        int get_startY();
        int get_endX();
        int get_endY();
        void set_startX(int);
        void set_startY(int);
        void set_endX(int);
        void set_endY(int);
        int getsize();
        void move(DIR);
};