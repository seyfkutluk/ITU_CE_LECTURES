#include<stdio.h>
int main()
{

	
	int q,m,year,endyear;
	printf("Enter date [year month day]: ");
	scanf("%d %d %d",&year,&m,&q);
	
	
	if(m>12 || m<1 || q>31 || q<1 || year<0)
	{
		printf("Invalid date.");
		return 0;
	}
	if((m==4 || m==6 || m==9 || m==11)&& q>30)
	{
		printf("Invalid date.");
		return 0;
	}
	if(m==2)
	{
		if(year%4==0 && q>29)
		{	
	     	printf("Invalid date.");
	    	return 0;
		}
		if(year%4!=0 && q>28)
		{	
	     	printf("Invalid date.");
	    	return 0;
		}
	}
	
	int k,j,weekday;



    if(m==1 || m==2)
    {
    	j= (year-1) / 100;
	    k= (year-1)%100;
    	weekday=(q+(13*(m+13)/5)+k+(k/4)+(j/4)+(5*j))%7;
    	
	}
	else{
		j= year / 100;
     	k= year%100;
		weekday=(q+(13*(m+1)/5)+k+(k/4)+(j/4)+(5*j))%7;

		
	}
	printf("Enter end year: ");
	scanf("%d",&endyear);	

	
	switch(weekday)
	{
		case 0:
			printf("It's a Saturday.\r\n");
			break;
		case 1:
			printf("It's a Sunday.\r\n");
			break;
		case 2:
			printf("It's a Monday.\r\n");
			break;
		case 3:
			printf("It's a Tuesday.\r\n");
			break;
		case 4:
			printf("It's a Wednesday.\r\n");
			break;
		case 5:
			printf("It's a Thursday.\r\n");
			break;
		case 6:
			printf("It's a Friday.\r\n");
			break;
		}
		
	
	int total=0;
	
    
	for(int a=year+1; a<=endyear; a++)
	{


		int weekdaylast;
    if(m==1 || m==2)
    {
    	j= (a-1) / 100;
	    k= (a-1)%100;
    	weekdaylast=(q+(13*(m+13)/5)+k+(k/4)+(j/4)+(5*j))%7;
    	
	}
	else{
		j= a / 100;
     	k= a%100;
		weekdaylast=(q+(13*(m+1)/5)+k+(k/4)+(j/4)+(5*j))%7;

		
	}
		if(weekday==weekdaylast)
		{
			total++;
		}
	}


	printf("Same day-and-month on same weekday between %d and %d:%d\r\n",year+1,endyear,total);
	
	
	
	

	
	return 0;
}

