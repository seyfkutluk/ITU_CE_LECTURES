/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:05.08.2021*/
#include "TrieNode.h"
#define MAXS 26
TrieNode::TrieNode()
{
    for(int i=0; i<MAXS; i++)   // points every character to a null
    {
        characters[i]=NULL;
    }
    this->IsWord=false;
}