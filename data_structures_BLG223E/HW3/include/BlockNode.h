//#include "BlockList.h"
#include "Node.h"
class BlockNode{
    friend class Blocklist;
    Blocks *element;
    BlockNode *next;
    BlockNode(const string &,const string &, int);
    ~BlockNode();

};