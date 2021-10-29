/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:17.08.2021*/
#pragma once
#ifndef MultiNode_h
#define MultiNode_h

class MultiNode{
    public:
        int height;
        int data;
        MultiNode **next;
        MultiNode(int,int);
        MultiNode* get_next();
};
#endif