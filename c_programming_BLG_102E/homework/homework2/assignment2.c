#include<stdio.h>

int main()
{
	int target;
    printf("Target: ");
	scanf("%d",&target);
	int sequence;
	char ring;
    while(1)
    {

	
	printf("Throw: ");
	scanf("%d %c",&sequence,&ring);
	
	

	if(ring=='D')
	{

			target=remain(target,sequence,&ring);
			printf("Points: %d",target);
			while(1){
			printf("Throw: ");
         	scanf("%d %c",&sequence,&ring);
         	target=remain(target,sequence,&ring);
       		printf("Points: %d",target);
        	printf("Points: %d",target);
         	if(target==0){	break; }
				
			}
	}
	if(target==0){	break; }
	}
	
	
}
int point(int ser, char rin)
{
	int score;
	if(rin=='S'){score=ser;}
	if(rin=='D'){score=2*ser;}
	if(rin=='T'){score=3*ser;}
	return score;
	
}
int remain(int last, int ser1, char* rin1)
{
	last= last- point(ser1,rin1);

	
	if(last<0 || last==1)
	{
	last= last+ point(ser1,rin1);	
	}
	printf("Points: %d",last);

	return last;
}
