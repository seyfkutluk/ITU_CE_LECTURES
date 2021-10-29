/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:10.08.2021*/
class Heap
{
    private:
        int *arr;
        int capacity;
        int size_of_heap;
    
    public:
        Heap(int);
        void heapify(int arr[], int num, int index);
        void insert(int);
        void remove(int);
        void removenum(int,int);
        int find_index(int number);
        void removeindex(int);
        int parent(int);
        int left(int);
        int right(int);
        int removemin();
        void sortarraymin();
        void sortarraymax();
        void make();
        void makeheap(int arr[], int size);
        void print();
    
};