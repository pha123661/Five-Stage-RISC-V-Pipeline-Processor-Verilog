#include <stdio.h>
#define N 7
#define str1 "Factorial value of "
#define str2 " is "

int fact(int a);

int main (void)
{
	int result;
	
	result = fact(N);
	printf("%s%d%s%d",str1,N,str2,result);
	
	return 0;
}

int fact(int a)
{
	if ( a==1 || a==0)
	{
		return 1;
	}
	else
	{
		return fact(a-1)*a;
	}
}
