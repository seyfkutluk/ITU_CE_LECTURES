/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:05.08.2021*/
#include <iostream>
#include <vector>
#include "Trie.h"

using namespace std;

void Trie::find_word(string word){
    cout<<word<<":";
    
    TrieNode* temp;
    temp= &root;

    int i=0;
    while(i<word.length()){
        if(temp->characters[word[i]-'a']){
            temp = temp->characters[word[i]-'a'];
        }
        else{
            cout<<"-1 ";
            return;
        }
        i++;
    }
    for(auto j= temp->places.begin(); j!=temp->places.end(); j++){
        cout<<*j<<" ";
    }
}

void Trie::insert_word(string word, int where){
    TrieNode* temp;
    temp= &root;
    int i=0;
    while(i<word.length()){
        if(temp->characters[word[i]-'a'] == NULL){
            temp->characters[word[i]-'a'] = new TrieNode;
            temp->characters[word[i]-'a']->data = tolower(word[i]);
        }
        temp = temp->characters[word[i]-'a'];
        i++;
    }
    temp->IsWord=true;
    temp->places.push_back(where);

}
