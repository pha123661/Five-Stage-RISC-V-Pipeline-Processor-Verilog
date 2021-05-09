#include <stdio.h>
#define N 7
#define str1 "th number in the Fibonacci sequence is "

int Fibonacci(int n);

int main(void) 
{
   int result;

   result = Fibonacci(N);
   printf("%d%s%d",N,str1,result);
   
   return 0;
}
 
int Fibonacci(int n) {
   if(n == 0) {
   		return 0;
   } else if (n == 1) {
   		return 1;
   } else {
   		return(Fibonacci(n - 1) + Fibonacci(n - 2));
   }
} 
