#include <stdlib.h>
#include "Node.h"

Node::Node(char Data)
{
    this->Data=Data;
    this->Left=Left;
    this->Right=Right;
}
void Node::SetData(char Data)
{
    this->Data=Data;
}
char Node::GetData()
{
    return this->Data;
}
void Node::SetLeft(Node* Left)
{
    this->Left=Left;
}
Node* Node::GetLeft()
{
    return this->Left;
}
void Node::SetRight(Node* Right)
{
    this->Right=Right;
}
Node* Node::GetRight()
{
    return this->Right;
}