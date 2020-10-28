#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define N 100 
#define TOL 0.00001

double func(double x)
{
        double	f;
	f=pow(x,3.0)+4*pow(x,2.0)-10;
//	f=((x*x*x)-(9*x)+1);
//	f=((x*x)-(4*x)+4);
//	f= 100-50*exp(x*10)-20*(exp(x*10)-1.0)/x;
//  	f=((x*x)-(6*x)+9);
	return f;
}

int main ()
{
	
	int i;
	double a,b,c,fa,fb,fc,rerror,diff;
	printf("Enter the value of a:  ");
	scanf("%lf",&a);
	printf("Enter the value of b:  ");
	scanf("%lf",&b);
	fa= func(a); 
	fb= func(b);
	
	if ((fa*fb)>0)
	{
		printf("change the intervals");
		exit(0);
	}
	if ((fa*fb)==0)
	{
		if (fa==0)
		printf("The solution is %lf",a);
		else
		printf("The solution is %lf",b);
	exit(0);
	}

	i=0; 
	diff=(b-a)/2.0;
	c=a;
	rerror=fabs(diff/c);
//	printf("value of c=%lf \t relative error=%lf\n",c,rerror);
	while (rerror > TOL)
	{
		diff=(b-a)/2.0;
		c=(a+b)/2;
		fc=func(c);
		printf("i= %d\ta=%lf\tb=%lf\tc=%lf\tf(a)=%lf\tf(b)=%lf\tf(c)=%lf\n",i,a,b,c,fa,fb,fc);
	
		if ((fa*fc)<0)
			b=c;
		else 
			a=c;
	
		rerror= fabs(diff/c);
		if (i==N)
		{
			printf("Not converged");
			exit(0);
		}
	i++;
	}
	printf("No. of iteration at which the convergence occured is: %d and  The solution is %f",i,c);
	

}
