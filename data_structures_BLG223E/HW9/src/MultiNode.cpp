/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:17.08.2021*/
#include "MultiNode.h"
#include<bits/stdc++.h>

MultiNode::MultiNode(int data, int height){
    this->data=data;
    this->height=height;
    next = new MultiNode*[height+1];
}

MultiNode* MultiNode::get_next(){
    return *next;
}
