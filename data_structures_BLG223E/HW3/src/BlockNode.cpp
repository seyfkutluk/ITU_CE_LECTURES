#include "BlockNode.h"
BlockNode::BlockNode(const string & from,const string & to , int balance){
    element= new Blocks(from, to, balance);
    next=0;
}
BlockNode::~BlockNode(){
    delete element;
}