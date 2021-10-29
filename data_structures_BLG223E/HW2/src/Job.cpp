/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:15.07.2021*/
#include "Job.h"
#include<iostream>

using namespace std;

Job::Job(int id, int mi, int start)
{
    this->id=id;
    this->mi=mi;
    this->start=start;
    end=-1;
}
int Job::getid()
{
    return id;
}

int Job::getmi()
{
    return mi;
}

char Job::getstate()
{
    return state;
}

void Job::worked(int mitime, int time)
{
    mi-=mitime;
    if(mi){
        state='F';
        end=time;
    }
}