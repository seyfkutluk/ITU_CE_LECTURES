
/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:16.07.2021*/
#include "Job.h"
#include <vector>
#include <queue>
using namespace std;
const int MAX_SIZE=100;
class Processor{
    private:
        int mips, mipsthreshold, jobsec, jobnumrun, time;
        queue<Job> waitingjob;
        queue<Job> nextjob;
        vector<Job> processedjob;
    public:
        Processor(int,int);
        void add(Job);
        void takenewjob();
        void workjob();
        void addnextjob();
        void print(int);
        void wprint();
};