#include "BlockNode.h"
class Blocklist{
    BlockNode *head;
    public:
    Blocklist(){head=0;};
    bool append(const string & a ,const string & b=0,int c=0);
    void del(const string &,const string &,int );
    void PRINT() const;
    ~Blocklist();
};