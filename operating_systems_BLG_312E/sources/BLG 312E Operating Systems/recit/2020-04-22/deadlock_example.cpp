#include <iostream>
#include <cstdlib>
#include <pthread.h>
#include <cstdio>
#include <unistd.h>



class Pair
{
private:
    int a;
    int b;
    pthread_mutex_t plock;  //  mutex variable
    
public:
    //  constructors
    Pair(int, int);
    Pair(void){};
    
    //  destructor
    ~Pair();
    
    //  overloaded operators for comparsion
    bool operator<(Pair &);
    bool operator>(Pair &);
    bool operator==(Pair &);
    
    //  methods for setting attributes
    void setA(int);
    void setB(int);
    void setAB(int, int);
    void print(std::string);
    
    //  methods for mutex operations
    void lock();
    void unlock();
};


//  constructor
Pair::Pair(int a_in, int b_in)
{
    a = a_in;
    b = b_in;
    pthread_mutex_init(&plock, NULL);
}

//  destructor
Pair::~Pair()
{
    pthread_mutex_destroy(&plock);
}

//  set methods
void Pair::setA(int a_in)
{
    lock();
    a = a_in;
    unlock();
}

void Pair::setB(int b_in)
{
    lock();
    b = b_in;
    unlock();
}

void Pair::setAB(int a_in, int b_in)
{
    lock();
    a = a_in;
    b = b_in;
    unlock();
}



//  mutex lock method
void Pair::lock()
{
    pthread_mutex_lock(&plock);
}

//  mutex unlock method
void Pair::unlock()
{
    pthread_mutex_unlock(&plock);
}


//  print method
void Pair::print(std::string name)
{
    printf("\n%s: (%d,%d)\n", name.c_str(), a, b);
    //std::cout << std::endl << name << ": (" << a << "," << b << ")" << std::endl;
}



//  overloaded operators
bool Pair::operator<(Pair &other)
{
    //  acquire own lock
    lock();
    
    //  acquire other's lock
    other.lock();
    if (a < other.a)
    {
        //  release locks
        unlock();
        other.unlock();
        return true;
    }
    
    if (a==other.a && b < other.b)
    {
        //  release locks
        unlock();
        other.unlock();
        return true;
    }
    
    
    //  release locks
    unlock();
    other.unlock();
    return false;
}


bool Pair::operator>(Pair &other)
{
    //  acquire own lock
    lock();
    
    //  acquire other's lock
    other.lock();
    if (a > other.a)
    {
        //  release locks
        unlock();
        other.unlock();
        return true;
    }
    
    if (a==other.a && b > other.b)
    {
        //  release locks
        unlock();
        other.unlock();
        return true;
    }
    //  release locks
    unlock();
    other.unlock();
    return false;
}

bool Pair::operator==(Pair &other)
{
    //  acquire locks
    lock();
    other.lock();
    
    //  calculate result
    bool result = (a == other.a && b == other.b);
    
    //  release locks
    unlock();
    other.unlock();
    
    return result;
}







//  thread handling function
void* thread_function(void* arg)
{
    Pair** pList = (Pair**) arg;
    
    //  print x and y
    pList[0]->print("x");
    pList[1]->print("y");
    sleep(1);  //  to have a race
    
    //  compare x and y and print the result
    if ((*pList[0]) > (*pList[1]))
        std::cout << std::endl << "x>y" << std::endl;
    else if ((*pList[0]) < (*pList[1]))
        std::cout << std::endl << "x<y" << std::endl;
    else
        std::cout << std::endl << "x=y" << std::endl;

    return NULL;
}



int main()
{
    pthread_t mythreadA, mythreadB;  //  declaring two threads
    Pair* x = new Pair(1, 2);
    Pair* y = new Pair(2, 3);
    
    //  creating two lists of Pairs (x, y) and (y, x)
    Pair* pList[] = {x, y};
    Pair* qList[] = {y, x};
    
    //  creating two threads
    if ( pthread_create(&mythreadA, NULL, thread_function, (void*)pList))
    {
        printf("error creating thread A\n");
        exit(1);
    }
    if ( pthread_create(&mythreadB, NULL, thread_function, (void*)qList))
    {
        printf("error creating thread B\n");
        exit(2);
    }
    
    //  wait for threads
    if ( pthread_join(mythreadA, NULL) )
    {
        printf("error joining thread A\n");
        exit(3);
    }
    if ( pthread_join(mythreadB, NULL) )
    {
        printf("error joining thread B\n");
        exit(4);
    }
    
    //  cleanup
    delete x;
    delete y;
    
    return 0;
}
