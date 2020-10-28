#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define TOL 0.00001

double func(double x)
{
        double	f;
	f = ((x+1.0)*(x-1.0)*(x-0.5));
	return f;
}

int main ()
{
	
	int i;
	double a,b,c,fa,fb,fc,rerror,diff;
	a =-2.0;
	b = 1.5;
	fa= func(a); 
	fb= func(b);
	
	if ((fa*fb)>0)
	{
		printf("change the intervals");
		exit(0);
	}
	

	i=1; 
	diff=(b-a)/2.0;
	c=a;
	rerror=fabs(diff/c);
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
		if (i==3)
		{
			printf("The solution P3 is %lf\t",c);
			exit(0);
		}
	i++;
	}
	

}