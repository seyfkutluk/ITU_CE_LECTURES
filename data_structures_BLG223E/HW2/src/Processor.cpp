/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:16.07.2021*/
#include "Processor.h"
#include <iostream>

using namespace std;
//#include "Job.h"

Processor::Processor(int mips,int mipsthreshold)
{
    this->mips=mips;
    this->mipsthreshold=mipsthreshold;
    jobsec=(mips/mipsthreshold)-(mips%mipsthreshold==0);
    jobnumrun=0;
    time=0;
}

void Processor::add(Job job)
{
    nextjob.push(job);
}

void Processor::takenewjob()
{
    while(!waitingjob.empty()){
        if(jobnumrun>=jobsec){
            break;
        }
        Job job=waitingjob.front();
        job.setstate('R');
        job.start=-1;
        processedjob.push_back(job);
        jobnumrun+=1;
        waitingjob.pop();
    }
}

void Processor::workjob()
{
    addnextjob();takenewjob();
    int a;
    if(jobnumrun){a=mips/jobnumrun;}
    else{a=0;}
    for(Job& job:processedjob){
        if(job.getid()=='F'){
            continue;
        }
        job.worked(a,time);
        job.start=min(job.start,time);
        if(job.getstate()=='F'){
            jobnumrun-=1;
        }
    }
    time+=1;
}

void Processor::addnextjob()
{
    while(!nextjob.empty()){
        Job job=nextjob.front();
        if(job.start >=time){
            return;
        }
        job.setstate('W');
        waitingjob.push(job);
        nextjob.pop();
    }
}

void Processor::print(int a)
{
    for(Job job:processedjob){
        if(job.getid()==a){
            cout<<job.getstate()<<" "<<job.start<<" "<<job.end;
            return;
        }
    }
    cout<<"W -1 -1";
}

void Processor::wprint()
{
    cout<<" WQ ";
    int amount=waitingjob.size();
    int i=0;
    while(i<amount){
        Job job=waitingjob.front();
        cout<<job.getid()<<" ";
        waitingjob.push(job);
        waitingjob.pop();
    }
}
