class Node{
    public:
        Node(char);
        void SetData(char);
        char GetData();
        void SetLeft(Node*);
        Node* GetLeft();
        void SetRight(Node*);
        Node* GetRight();

    private:
        char Data;
        Node* Left;
        Node* Right;
};