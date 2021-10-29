#include <string>
#include "Node.h"

using namespace std;

class Tree{
    public:
        Tree();
        Tree(string,string);
        ~Tree();
        void PrintTree();
        void PrintPreOreder();
        void PrintInOrder();
        void PrintPostOrder();
        void PrintBreadthFirst();
        
    private:
        void PreOrderTraverse(Node*);
        void InOrderTraverse(Node*);
        Node* Root;
        void PostOrderTraverse(Node*);
        Node* RecursiveConstruct(string, string);
        void PostOrderDestruct(Node*);
};