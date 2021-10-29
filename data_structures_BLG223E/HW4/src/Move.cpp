#include "Move.h"

Move::Move(Piece p, DIR d){

    this->p = p;
    this->d = d;
}


Piece Move::getpiece(){
    return p;
}

DIR Move::getdir(){
    return d;
}

string Move::getdirstr(){
    if(d==UP)
        return "UP";
    if(d==DOWN)
        return "DOWN";
    if(d==LEFT)
        return "LEFT";
    if(d==RIGHT)
        return "RIGHT";
    return "NONE";
}

bool Move::isopposite(Move m){
    return (this->d==UP && m.d==DOWN) || (this->d==DOWN && m.d==UP) || (this->d==LEFT && m.d==RIGHT) || (this->d==RIGHT && m.d==LEFT);
}