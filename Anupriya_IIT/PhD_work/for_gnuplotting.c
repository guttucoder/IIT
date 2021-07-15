#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<stdbool.h>
#include<time.h>
#include "mt19937ar.h"
#include "mt19937ar.c"
#define Lx 70
#define Ly 70
#define N (Lx*Ly)
#define n (N/K)  //total no of possible K-mer
#define K 7
#define N (Lx*Ly)
#define T 10000000
#define rho 0.75
#define p 1
#define p1 1-p
#define p2 p/2.0
#define p3 p/2.0
#define GAP 10000
#define h_orientation 1
#define v_orientation 2


int Lat[Lx][Ly];
int orientation_type[n+1];
int headListX[n];
int headListY[n];
int pivotListX[n];
int pivotListY[n];
int hor_count=0, ver_count=0, K_mer_counter=0;
int N_Kmer = ((rho*N)/K); 
int PBCX(int x);
int PBCY(int y);
void output (int t);
char outfile1[100];
time_t tt;
//srand((unsigned) time(&t));

int PBCX(int x)
{
    return (x+Lx)%Lx;
}

int PBCY(int y)
{
    return (y+Ly)%Ly;
}




void horizontal(){                          //function for creating horizontal K-mers
    int x,y,i,site,remaining;
    bool flag;
    do
    {
    x= Lx*genrand_real3();
    y= Ly*genrand_real3();

        flag = true;
    
        for (i=0;i<K;i++){
        if(Lat[x][PBCY(y+i)]!=0){
            flag=false;
        }
    }
    }
    while (flag != true);
    
    if(flag == true)
    {
            pivotListX[K_mer_counter]=x;
            pivotListY[K_mer_counter]=PBCY(y+K/2); 
            headListY[K_mer_counter] = PBCY(y);
        //    site = ((pivotListX[K_mer_counter]*Lx)+ headListY[K_mer_counter]);
            if((headListY[K_mer_counter]+(K-1)) != PBCY(headListY[K_mer_counter]+(K-1))){
                remaining = ((headListY[K_mer_counter]+(K-1))% Lx);
                printf("\n K_mer_id %d %d %d 0 %d 1\n",(K_mer_counter+1), pivotListX[K_mer_counter], headListY[K_mer_counter], ((K-1) - remaining));
                //printf("\n %d %d %d %d\n", pivotListX[K_mer_counter], headListY[K_mer_counter], pivotListX[K_mer_counter], (Lx-1));
                printf("\n K_mer_id %d %d 0 0 %d 1\n",(K_mer_counter+1),  pivotListX[K_mer_counter], remaining);
            }
            if((headListY[K_mer_counter]+(K-1)) == PBCY(headListY[K_mer_counter]+(K-1)))
            {
                printf("\n K_mer_id: %d %d %d 0 %d 1\n",(K_mer_counter+1), pivotListX[K_mer_counter], headListY[K_mer_counter], (K-1) );
            }
            K_mer_counter++;
           // printf("\n horizontal: K_mer_counter%d x_y: %d %d site %d length %d\n",K_mer_counter,pivotListX[K_mer_counter], pivotListY[K_mer_counter],site, length);
            orientation_type[K_mer_counter]= h_orientation;
            hor_count++;
            for (i=0;i<K;i++){
            Lat[x][PBCY(y+i)]= K_mer_counter;
           // Lat[x][(y+i+Ly) % Ly]= 1;

        }
        
    }
    
    
}


void vertical(){                           //function for creating vertical K-mers

    int x,y,i,site, remaining;
    bool flag;
    do
    {
    x= Lx*genrand_real3();
    y= Ly*genrand_real3();

        flag = true;
    
        for (i=0;i<K;i++){
        if(Lat[PBCX(x+i)][y]!=0){
            flag=false;
        }
    }
    }
    while (flag != true);
    
    if(flag == true)
    {
            pivotListX[K_mer_counter]=PBCX(x+(K/2));
            pivotListY[K_mer_counter]=y; 
            headListX[K_mer_counter]=PBCX(x);
           // site = ((headListX[K_mer_counter]*Lx)+pivotListY[K_mer_counter]);
            if((headListX[K_mer_counter]+(K-1)) != PBCX(headListX[K_mer_counter]+(K-1))){
                remaining = ((headListX[K_mer_counter]+(K-1))% Ly);
               // printf("\n %d %d %d %d\n", headListX[K_mer_counter], pivotListY[K_mer_counter],(Ly-1),pivotListY[K_mer_counter]);
                printf("\n K_mer_id %d %d %d %d 0 2\n",(K_mer_counter+1), headListX[K_mer_counter], pivotListY[K_mer_counter],((K-1) - remaining));
                printf("\n K_mer_id %d 0 %d %d 0 2\n",(K_mer_counter+1), pivotListY[K_mer_counter],remaining);
            }
            if((headListX[K_mer_counter]+(K-1)) == PBCX(headListX[K_mer_counter]+(K-1)))
            {
                printf("\n K_mer_id: %d %d %d %d 0 2\n",(K_mer_counter+1), headListX[K_mer_counter], pivotListY[K_mer_counter], (K-1));
            }
            K_mer_counter++;
           // printf("\n horizontal: K_mer_counter%d x_y: %d %d site %d length %d\n",K_mer_counter,pivotListX[K_mer_counter], pivotListY[K_mer_counter],site, length);
            orientation_type[K_mer_counter]= v_orientation;
            ver_count++;
            for (i=0;i<K;i++){
            Lat[PBCX(x+i)][y]= K_mer_counter;
            //Lat[(x+i+Lx)%Lx][y]= 2;
        
            }
            
        
    }
    
}


int printLattice()
{
        for(int i=0;i<Lx;i++){
            for(int j=0;j<Ly;j++)
                printf("\t%d", Lat[i][j]);
            printf("\n");
        }
        printf("\n");
        return 0;
}

/*int main(){
    int i=0;
    srand((unsigned) time(&tt));
    do
    {
        double r=(double)(rand())/(double)(RAND_MAX);
        if (r<=0.5)
            vertical();
        else
            horizontal();

        i++;
    }
    while (i != N_Kmer);

    printf("total k=mers:%d\ntotal vertical K-mers :%d\ntotal horizontal K-mers :%d\n",K_mer_counter, ver_count,hor_count);
    printf("The Lattice visualization is: \n");
    printLattice();
} */

int main() {
    int i,j,k;
    bool flag;
 /*  i=0;
    do
    {
         horizontal();
         i++;
    }
    while (i != N_Kmer); */
      
    for(i=0;i<Lx;i++){                                                         
        for(j=0; j<Ly/2; j+=K){
            if(K_mer_counter == N_Kmer/2){
               break;
            }

                for(k=j; k<(j+K); k++){
                
                        pivotListX[K_mer_counter]=i;
                        pivotListY[K_mer_counter]=PBCY(j+K/2);
                        headListY[K_mer_counter]=PBCY(j);
                        printf("\n K_mer_id: %d %d %d %d 0 1\n", (K_mer_counter+1),  headListY[K_mer_counter], pivotListX[K_mer_counter],(K-1) );
                        K_mer_counter++;     
                        orientation_type[K_mer_counter]= h_orientation;
                        hor_count++;

                        for(k=j; k<(j+K); k++){
                        Lat[i][PBCY(k)]= K_mer_counter;
                        }
                }

         
            }
    }

    for(j=Ly/2;j<=Ly;j++){                                                         
        for(i=0; i<Ly; i+=K){
            if(K_mer_counter < N_Kmer/2 || K_mer_counter >= N_Kmer){
               break;
            }
            for(k=i; k<(i+K); k++){
                
                        pivotListY[K_mer_counter]=j;
                    //    pivotListX[K_mer_counter]=PBCX(j+K/2);
                        headListX[K_mer_counter]=PBCX(i);

                    //    pivotListX[K_mer_counter]=PBCX(x+(K/2));
                    //    pivotListY[K_mer_counter]=y; 
                    //    headListX[K_mer_counter]=PBCX(x);

                        printf("\n K_mer_id: %d %d %d 0 %d 2\n", (K_mer_counter+1),  pivotListY[K_mer_counter], headListX[K_mer_counter],(K-1) );
                       // printf("\n K_mer_id: %d %d %d %d 0 2\n", (K_mer_counter+1), headListX[K_mer_counter], pivotListY[K_mer_counter], (K-1) );
                        K_mer_counter++;     
                        orientation_type[K_mer_counter] = v_orientation;
                        ver_count++;

                        for(k=i; k<(i+K); k++){
                        Lat[PBCX(k)][j]= K_mer_counter;
                        }
                }

         
            }
    } 


      


    printf("total k=mers:%d\ntotal vertical K-mers :%d\ntotal horizontal K-mers :%d\n",K_mer_counter, ver_count,hor_count);
    printf("The initial Lattice visualization is: \n");
    printLattice();
}


