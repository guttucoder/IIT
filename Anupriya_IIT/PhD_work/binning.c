/*#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<math.h>

void main()
{
	int a[100],**b,i,j,r,c,n,temp,k=0,sum,avg[10],l,h;
	
	printf("How many data? ");
	scanf("%d",&n);
	for(i=0;i<n;i++)
	{
		a[i]= rand()%(100);
	}
	printf("\nGenerated Random Numbers:");
	for(i=0;i<n;i++)
	{
		printf(" %d",a[i]);
	}
	printf("\n\nSorted Data:");
	for(i=0;i<n;i++)
	{
		for(j=i+1;j<n;j++)
		{
			if(a[i]>a[j])
			{
				temp=a[i];
				a[i]=a[j];
				a[j]=temp;
			}
		}
	}
	for(i=0;i<n;i++)
	{
		printf(" %d",a[i]);
	}
	printf("\n\nHow many bins? ");
	scanf("%d",&r);
	c=n/r;

	for(i=0;i<r;i++)
	{
		b[i]=(int*)malloc(c*sizeof(int));
		for(j=0;j<c;j++)
		{
			b[i][j]=a[k];
			k++;
		}
	}
	printf("\nData Before Smoothing: \n");
	for(i=0;i<r;i++)
	{
		for(j=0;j<c;j++)
		{
			printf("%d\t",b[i][j]);
		}
		printf("\n");
	}
	for(i=0;i<r;i++)
	{
		sum=0;
		for(j=0;j<c;j++)
		{
			sum=sum+b[i][j];
		}
		avg[i]=sum/c;
	}
	printf("\nBinning By Means: \n");
	for(i=0;i<r;i++)
	{
		for(j=0;j<c;j++)
		{
			printf("%d\t",avg[i]);
		}
		printf("\n");
	}
	for(i=0;i<r;i++)
	{
		l=b[i][0];
		h=b[i][c-1];
		for(j=0;j<c;j++)
		{
			if((b[i][j]-l) < (h-b[i][j]))
			{
				b[i][j]=l;
			}
			else
			{
				b[i][j]=h;
			}
		}
	}
	printf("\nBinning by Boundries: \n");
	for(i=0;i<r;i++)
	{
		for(j=0;j<c;j++)
		{
			printf("%d\t",b[i][j]);
		}
		printf("\n");
	}
	getch();
}*/


/*********************************************************************************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define n 110000
#define m 30
#define minval 0
#define maxval 9990

int *ind, number, NN;
double f,*x1, *x2;

int main(){
	int i,j;
	double bin;

	printf("%f\n"bin );

	FILE *fpIn = fopen("testdata.dat", "r");
	FILE *fpOut = fopen("output.dat", "w");

	ind = (int*)malloc(sizeof(int)* n);
	x1 = (double*)malloc(sizeof(double)*n);
	x2 = (double*)malloc(sizeof(double)*n);
	bin = ((maxval - minval)/m);

	number = 0;
	while (fscanf(fpIn, "%d  %lf %lf\n", &(ind[number]), &(x1[number]), &(x2[number])) != EOF){
		number ++;
	}

	NN = number;
	printf("okk");

	for(i=0; i<NN; i++){
		fprintf(fpOut, "%d  %lf %lf\n", ind[i], x1[i], x2[i]);
	}

	f= (bin * NN);
	printf("int %d f %lf bin %1.16f",NN, f, bin );


	fclose(fpIn);
	fclose(fpOut);
}


