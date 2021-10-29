/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:05.08.2021*/
#include <iostream>
#include <string>
#include "TrieNode.h"

using namespace std;

class Trie{
    public:
    TrieNode root;
    void find_word(string);
    void insert_word(string, int);  //inserts the word in the place that is in the integer
};