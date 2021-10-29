#include <stdlib.h>
#include <iostream>
#include <queue>
#include <string>
#include "Tree.h"

using namespace std;

Tree::Tree()
{
    this->Root = new Node('A');
    
    Node* Rl = new Node('B');
    Node* Rr = new Node('C');

    Node* Rll = new Node('D');
    Node* Rlr = new Node('E');
    Node* Rrl = new Node('F');
    Node* Rrr = new Node('G');
    
    Root->SetLeft(Rl);
    Root->SetRight(Rr);

    Rl->SetRight(Rlr);
    Rl->SetLeft(Rll);
    Rr->SetRight(Rrr);
    Rr->SetLeft(Rrl);
}

void Tree::PrintTree()
{
    cout<<Root->GetData()<<"("
                        <<Root->GetLeft()->GetData()
                        <<"("
                        <<Root->GetLeft()->GetLeft()->GetData()
                        <<","
                        <<Root->GetLeft()->GetRight()->GetData()
                        <<")"
                        <<","
                        <<Root->GetRight()->GetData()
                        <<"("
                        <<Root->GetRight()->GetLeft()->GetData()
                        <<","
                        <<Root->GetRight()->GetRight()->GetData()
                        <<")"
                        <<")"
                        <<endl;

}
Tree::Tree(string PreOrder, string InOrder)
{
    this->Root= RecursiveConstruct(PreOrder, InOrder);
}

Tree::~Tree()
{
    if(this->Root != NULL){
        this->PostOrderDestruct(this->Root);
    }
    this->Root=NULL;
}

void Tree::PrintPreOreder()
{
    this->PreOrderTraverse(this->Root);
    cout<<endl;
}

void Tree::PrintInOrder()
{
    this->InOrderTraverse(this->Root);
    cout<<endl;
}

void Tree::PrintPostOrder()
{
    this->PostOrderTraverse(this->Root);
    cout<<endl;
}

void Tree::PrintBreadthFirst()
{
    Node* temp;
    queue<Node*> que;
    if(this->Root == NULL)
    {
        return;
    }
    que.push(this->Root);

    while(!que.empty()){
        temp= que.front();
        que.pop();
        cout<<temp->GetData();
        if(temp->GetLeft()!=NULL)
        {
            que.push(temp->GetLeft());
        }
        if(temp->GetRight()!=NULL)
        {
            que.push(temp->GetRight());
        }
    }
    cout<<endl;
}

void Tree::PreOrderTraverse(Node* node)
{
    if(node != NULL)
    {
        cout << node->GetData();
        this->PreOrderTraverse(node->GetLeft());
        this->PreOrderTraverse(node->GetRight());
    }
}

void Tree::InOrderTraverse(Node* node)
{
    if(node != NULL)
    {
        this->InOrderTraverse(node->GetLeft());
        cout << node->GetData();
        this->InOrderTraverse(node->GetRight());
    }
}

void Tree::PostOrderTraverse(Node* node)
{
    if(node != NULL)
    {
        this->PostOrderTraverse(node->GetLeft());
        this->PostOrderTraverse(node->GetRight());
        cout << node->GetData();
    }
}

Node* Tree::RecursiveConstruct(string PreOrder, string InOrder)
{
    if(PreOrder.length()==0)
    {
        return NULL;
    }
    if(PreOrder.length()==1)
    {
        return new Node(PreOrder[0]);
    }

    char RootData = PreOrder[0];
    string InLeft = InOrder.substr(0, InOrder.find(RootData));
    string InRight = InOrder.substr(InOrder.find(RootData)+1);

    string PreLeft ="";
    string PreRight ="";

    for(char c:PreOrder.substr(1))
    {
        int i = InRight.find(c);
        if(i>=0)
        {
            break;
        }
        PreLeft = PreLeft + c;
    }

    if(PreLeft.length()>0)
    {
        PreRight = PreOrder.substr(PreOrder.find(PreLeft[PreLeft.length()-1])+1);
    }
    else
    {
        PreRight = PreOrder.substr(PreOrder.find(RootData)+1);
    }

    Node* LocalRoot = new Node(RootData);
    LocalRoot->SetLeft(RecursiveConstruct(PreLeft, InLeft));
    LocalRoot->SetRight(RecursiveConstruct(PreRight, InRight));
    return LocalRoot;
}

void Tree::PostOrderDestruct(Node* node)
{
    if(node=NULL)
    {
        this->PostOrderDestruct(node->GetLeft());
        this->PostOrderDestruct(node->GetRight());
        delete node;
    }
}