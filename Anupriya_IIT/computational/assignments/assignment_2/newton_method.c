#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#define   t    0.95
#define   TOL    pow(10,-6)
#define   N      100

double func(double x)
{
	double f;
	f = log (x-1) + 3 * cos(x-2) + t;

    return f; 
}

double der(double x)
{
	double g;
	g = (1/(x-1)-3*sin((x-2)));

	return g;
}


int main()
{
	 int i;
	 float x0, x1, f0, f1, g0, e;
	 printf("\nEnter initial guess:\n");
	 scanf("%f", &x0);
	 //x0= 3.0;
	 
	 i=1;
	 do
	 {
		  g0 = der(x0);
		  f0 = func(x0);
		  if(g0 == 0.0)
		  {
			   printf("Mathematical Error.");
			   exit(0);
		  }

		
		  x1 = x0 - f0/g0;

		  f1 = func(x1);

		  printf("%d\t%f\t%f\n",i,x1,f1);
		  x0 = x1;
		  
		  i = i+1;
		
		  if(i > N)
		  {
			   printf("Not Convergent.");
			   exit(0);
		  }
		  
		  f1 = func(x1);
		  
	 }while(fabs(f1)>TOL);
	
	 printf("\nRoot is: %f", x1);
	 return 0;
	 
}
