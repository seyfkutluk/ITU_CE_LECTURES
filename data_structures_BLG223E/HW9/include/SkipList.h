/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:17.08.2021*/
#pragma once
#ifndef SkipList_h
#define SkipList_h

#include "MultiNode.h"

class SkipList{
    public:
        SkipList(int&);
        void print();
        void add(int&);
        void dell(int&);
        void is_contain(int&);
        void clear();

    private:
        int level_size;
        int level;
        MultiNode* head;

};
#endif