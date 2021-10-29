#pragma once
#include "Piece.h"
#include <string>

using namespace std;

class Move{

    private:
        Piece p;
        DIR d;

    public:
        Move(Piece,DIR);
        Piece getpiece();
        DIR getdir();
        string getdirstr();
        bool isopposite(Move);
};