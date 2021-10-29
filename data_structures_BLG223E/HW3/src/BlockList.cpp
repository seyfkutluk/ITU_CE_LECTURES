#include "BlockList.h"

bool Blocklist::append(const string &from,const string &to,int balance){
    BlockNode *previous, *current;
    if(head){

        previous=head;
        current=head->next;
        while(current){
            previous=current;
            current=current->next;

        }
        previous->next=new BlockNode(from,to,balance);
        if(!(previous->next))return false;
    }
    else{
        head = new BlockNode(from,to,balance);
        if(!head) return false;
    }
    return true;
}
    // bool del(const string &,const string &,int );
    // void PRINT() const;
Blocklist::~Blocklist(){
    BlockNode *temp;
    while(head){
        temp=head;
        head=head->next;
        delete temp;
    }
}

void Blocklist::PRINT() const{
    BlockNode *temp;
    if(head){
        temp=head;
        while(temp){
            (temp->element)->PRINT();
            temp=temp->next;

        }
    }
    else{
        cout<<"The List İS Empty"<<endl;
    }
}

void Blocklist::del(const string &from,const string &to,int balance){
    BlockNode *temp;
    if(head){
        temp=head;
        while (temp)
        {
            if(from==temp->element->getFrom()){
                temp->element->setFrom(balance);
                //cout<<temp->element->getbalance()<<temp->element->getFrom();
            }
			temp=temp->next;
        }
        // temp=head;
        // while (temp)
        // {
        //     if(to==temp->element->getFrom()){
        //         temp->element->setTo(balance);
        //     }
		// 	temp=temp->next;
        // }
        
    }
    else{
        cout<<"The list is empty"<<endl;
    }
}
