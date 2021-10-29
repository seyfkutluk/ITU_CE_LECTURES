/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:29.07.2021*/
#include "Piece.h"
#include <string>
using namespace std;

Piece::Piece(string sign, string ornt, int startX,int startY,int endX,int endY){
    this->sign = sign[0];
    if(ornt[0]=='H'){
        this->hor=true;
        this->vert=false;
    }
    else{
        this->vert=true;
        this->hor=false;
    }
    this->startX=startX; 
    this->startY=startY; 
    this->endX=endX;
    this->endY=endY;
}

Piece::Piece(){
    this->sign = '_';
    this->hor=false;
    this->vert=false;
    this->startX=-1; 
    this->startY=-1; 
    this->endX=-1;
    this->endY=-1;
}

char Piece::get_sign(){
    return this->sign;
}
bool Piece::get_vert(){
    return this->vert;
}
bool Piece::get_hor(){
    return this->hor;
}
int Piece::get_startX(){
    return this->startX;
}
int Piece::get_startY(){
    return this->startY;
}
int Piece::get_endX(){
    return this->endX;
}
int Piece::get_endY(){
    return this->endY;
}
void Piece::set_startX(int startX){
    this->startX=startX;
}
void Piece::set_startY(int startY){
    this->startY=startY;
}
void Piece::set_endX(int endX){
    this->endX=endX;
}
void Piece::set_endY(int endY){
    this->endY=endY;
}

void Piece::move(DIR dir){
    if(dir==UP){
        this->startX--;
        this->endX--;
    }
    if(dir==DOWN){
        this->startX++;
        this->endX++;
    }
    if(dir==LEFT){
        this->startY--;
        this->endY--;
    }
    if(dir==RIGHT){
        this->startY++;
        this->endY++;
    }
}

int Piece::getsize(){
    if(get_vert()){
        return endX-startX+1;
    }
    if(get_hor()){
        return endY-startY+1;
    }
    return 0;
}
