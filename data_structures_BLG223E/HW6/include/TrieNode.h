/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:05.08.2021*/
#include <vector>
#include <iostream>
#define MAX 26
using namespace std;
class TrieNode{
    public:
    TrieNode* characters[MAX];
    bool IsWord;
    char data;
    vector<int> places;
    TrieNode();
};