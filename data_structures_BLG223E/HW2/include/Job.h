
/* @Author
Student Name:Seyfülmülük Kutluk
Student ID :150180073
Date:16.07.2021*/
class Job{
    private:
        int mi, id;
        char state='W';
    public:
        Job(int id=0, int mi=0, int start=0);
        int getid();
        int getmi();
        char getstate();
        void setstate(char a){state=a;}
        void worked(int, int);
        int start=-1;
        int end=-1;
};