/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:17.08.2021*/
#include "SkipList.h"
#include<iostream>
#include<string>

//using namespace std;
//To improve compile time ı have used mostly while loops instead of fro lops
SkipList::SkipList(int &level_size)
{
    this->level_size=level_size;
    level=0;
    head= new MultiNode(0, level_size); //initializing
}

void SkipList::clear()
{ 
    int i=0;
    MultiNode *temp=head->next[i];
    while(temp!=nullptr){
        dell(temp->data);
        temp=temp->next[i];
    }
}

void SkipList::print()
{
    int i=0;
    while(i<level_size){
        MultiNode* temp=head->next[i];
        std::cout<<"L"<<i<<": ";
        while(temp!=nullptr){
            std::cout<<temp->data<<" ";
            temp=temp->next[i];
        }
        i++;
    }   
}

void SkipList::add(int& added)
{
    int i=0;
    MultiNode* temp=head;
    MultiNode* new_node[level_size+1];
    int j=level;
    while(j>=0){
        while(temp->next[j]!=nullptr&& (temp->next[j]->data<added)){
            if(temp->next[j]->data<added)
            {
                temp=temp->next[j];
            }
        }
        new_node[j] = temp;
        j--;
    }
    temp=temp->next[i];//i=0
    if(temp==nullptr||temp->data!=added)
    {
        int random=0+rand()%level_size;//0-level_size
        if(random>level){
            int k=level+1;
            while(k<random+1){
                new_node[k]=head;
                k++;
            }
            level=random;
        }
        MultiNode* added_node= new MultiNode(added, random);
        while(i<=random){
            added_node->next[i]=new_node[i]->next[i];
            new_node[i]->next[i]=added_node;
            i++;
        }
    }
}

void SkipList::dell(int& deleted)
{
    int i=0;
    MultiNode* temp=head;
    MultiNode* new_node[level_size+1];
    int j=level;
    while(j>=0){
        while(temp->next[j]!=nullptr&& temp->next[j]->data<deleted){
            if(temp->next[j]->data < deleted)
            {
                temp=temp->next[j];
            }
        }
        new_node[j] = temp;
        j--;
    }
    temp=temp->next[0];
    if(temp != nullptr){
        if(temp->data == deleted){
            while(i<=level){
                if(new_node[i]->next[i]!= temp){break;}
                new_node[i]->next[i] = temp->next[i];
                i++;
            }
            while(head->next[level]==0&& level>00){level--;}
        }
    }
}

void SkipList::is_contain(int& in_it)
{
    int i=0;
    bool in_there=true;
    MultiNode* temp=head->next[i];
    while(temp!=nullptr){
        if(in_it==temp->data){
            in_there=false;
            std::cout<<in_it<<" IN ";
        }
        temp=temp->next[i];
    }
    if(in_there){
        std::cout<<in_it<<" OUT ";
    }
}


