/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:10.08.2021*/
#include "Heap.h"
#include <iostream>
#include <bits/stdc++.h>


using namespace std;

Heap::Heap(int c){
    capacity=c;
    size_of_heap=0;
    arr = new int[c];

}

void Heap::insert(int num){
    if(num<0 || num> 22000 || num==0){return;}

    if(size_of_heap== capacity){
        cout<<"not enough space";
    }
    size_of_heap++;
    arr[size_of_heap-1]=num;
    heapify(arr, size_of_heap, size_of_heap-1);
}

void Heap::heapify(int array[], int num, int index){
    int biggest = index;
    int le= 2*index + 1;
    int ri= 2*index + 2;

    if(le< num && array[le]> array[biggest]){biggest= le;    }
    if(ri< num && array[ri]> array[biggest]){biggest= ri;    }
    if(biggest != index){swap(array[index], array[biggest]);
    heapify(array, num, biggest);  }
}

void Heap::remove(int num){
    if(find_index(num)==-1){
        //cout<<"boş";
        return;
    }else{ removeindex(find_index(num));}
    
}

int Heap::find_index(int number){
    for(int i=0; i<size_of_heap; i++){
        if(number==arr[i]){
        return i;}
    }
    return -1;
}
void Heap::removeindex(int index){
    make();
    removenum(index,-2147483648);
    removemin();

}
int Heap::removemin(){
    if(size_of_heap<=0){return 2147483647;}
    if(size_of_heap==1){
        size_of_heap--;
        return arr[0];
    }
    int root=arr[0];
    arr[0]=arr[size_of_heap-1];
    size_of_heap--;
    make();
    return root;
}

void swap(int *first, int* second){
    int temp= *first;
    *first=*second;
    *second=temp;
}

int Heap::parent(int index){ return (index-1)/2;}
int Heap::left(int index){ return (index*2+1);}
int Heap::right(int index){ return (index*2+2);}


void Heap::removenum(int index, int nev){
    arr[index] = nev;
    while(index !=0 && arr[parent(index)] > arr[index]){
        swap(&arr[index], &arr[parent(index)]);
        index= parent(index);
    }
}

void Heap::sortarraymin()
{  
sort(arr, arr + size_of_heap);
for (int i = 0; i < size_of_heap; ++i)
    cout << arr[i] << " ";

}
void Heap::sortarraymax()
{  
sort(arr, arr + size_of_heap, greater<int>());
for (int i = 0; i < size_of_heap; ++i)
    cout << arr[i] << " ";

}

void Heap::make(){
    makeheap(arr,size_of_heap);
}

void Heap::makeheap(int array[], int size){
    int leaf=(size / 2)-1;
    for(int i=leaf; i>= 0; i--){
        heapify(array, size, i);
    }
}

void Heap::print(){
//cout<<heap_size<<endl;

for(int i=0; i<size_of_heap; i++){
    cout<<arr[i];
        if(i+1!=size_of_heap){cout<<" ";}
    }
    cout<<endl;
}