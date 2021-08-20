#include <stdio.h>
#include <stdlib.h>
#include<math.h>
#define Lx 70
#define Ly 70
#define N (Lx*Ly)
#define rho 0.80
#define gap 1200
#define n 7860
#define bin (n/gap)


int main(){

	int i;      
    long t;
	float tAvg, Q, abs_Q, Q2 , Q4, QAvg=0.0, abs_QAvg= 0.0, Q2_Avg= 0.0, Q4_Avg= 0.0, chi, U;
	FILE *fpIn, *fpOut1, *fpOut2;
 
	fpIn = fopen ("b.dat", "r");
	fpOut1 = fopen ("output_half_half.dat", "w");
	fpOut2 = fopen ("chi_binCum.dat", "w");

	for (i=1; i<=n; i++){

	fscanf (fpIn, "%ld  %f %f %f %f", &t, &Q, &abs_Q, &Q2, &Q4);

	tAvg += (t-tAvg)/i;
	abs_QAvg += (abs_Q-abs_QAvg)/i;
	Q2_Avg += (Q2 - Q2_Avg)/i;
	Q4_Avg += (Q4 - Q4_Avg)/i;

	}
	chi = 1.0*N*(Q2_Avg - (abs_QAvg * abs_QAvg));
	U = 1.0 - ((Q4_Avg)/ (3.0 * (Q2_Avg * Q2_Avg)));
	fprintf(fpOut1, "%lf\t%lf\t%lf\t%lf\n", tAvg,abs_QAvg, Q2_Avg, Q4_Avg);
	fprintf(fpOut2, "%lf\t%lf\t%lf\n", rho, chi, U );
 	fclose(fpIn);
	fclose(fpOut1);
	fclose(fpOut2);

}






	

          






    


























/*#include <stdio.h>
#include <math.h>

int main(){

  int i = 0, sum = 0, n = 0,avg = 0;

  FILE *fin;
 
  fin = fopen("testdata.dat", "r");

  
  while(fscanf(fin, "%d", &n) != EOF){
      
    sum += n;
      
    i++;
    
  }

 
  avg = (sum / i);
  printf("The average is %d.\n", avg);
 
  fclose(fin);
  return 0;
}


#include <stdio.h>
#include <stdlib.h>
#define n 10

int main()

{

int sum=0;

FILE *myFile;

myFile = fopen("testdata1.dat", "r");

int numberArray[15];

int i;

if (myFile == NULL)

{

printf("Error Reading File\n");

exit (0);


}

for (i = 0; i < n; i++)

{

fscanf(myFile, "%d,", &numberArray[i] );

}

for (i = 0; i < n; i++)

{

sum=sum+(numberArray[i]);

}

fclose(myFile);

printf("Sum is: %d\n\n", sum);

return 0;

} */



