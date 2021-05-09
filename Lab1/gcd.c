#include <stdio.h>
#define N1 4
#define N2 8
#define str1 "GCD value of "
#define str2 " and "
#define str3 " is "

int gcd(int m,int n);

int main(void)
{
    int result;
	
    result = gcd(N1, N2);
	printf("%s%d%s%d%s%d",str1,N1,str2,N2,str3,result);
	
    return 0;
}

int gcd(int m, int n) 
{
    if(n == 0)
        return m;
    else
    {
    	int r = m % n;
		return gcd(n, r); 
	}
}
