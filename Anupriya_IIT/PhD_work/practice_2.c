#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<stdbool.h>
#include "mt19937ar.h"
#include "mt19937ar.c"
#define Lx 10
#define Ly 10
#define N (Lx*Ly)
#define n (N/K)  //total no of K-mer
#define K 3
#define N (Lx*Ly)

int lat[N];
int Lat[Lx][Ly], active [N/K];
int hor_count=0, ver_count=0, K_mer_counter=0,first=0;

void take_input()
{
    long seedval;
    
    //scanf("%ld",&seedval);
    seedval=1675897655;
    init_genrand(seedval);
}

void Lattice_init(){
    int x,y;
    for(x=0; x<Lx; x++)
        for(y=0; y<Ly; y++)
            Lat[x][y]=0;
}

void horizontal(){                          //function for creating horizontal K-mers
    int x,y,i;

    x= Lx*genrand_real3();
    y= Ly*genrand_real3();

    bool flag = true;
    for (i=0;i<K;i++){
        if(Lat[x][(y+i+Ly) % Ly]!=0){
            flag=false;
        }
    }
    if(flag == true)
    {
            K_mer_counter++;
            hor_count++;
            for (i=0;i<K;i++){
            //Lat[(x+i+Lx)%Lx][y]= K_mer_counter;
            Lat[x][(y+i+Ly) % Ly]= 1;

        }
        active[first]= ((y+Ly)%Ly);
        printf("HORIZONTAL:: The first index of the %d th horizontal polymer is %d: \n", first,  ((y+Ly)%Ly));
        
    }
    first++;
    
}


void vertical(){                           //function for creating vertical K-mers

    int x,y,i;

    x= Lx*genrand_real3();
    y= Ly*genrand_real3();

    bool flag = true;
    for (i=0;i<K;i++){
        if(Lat[(x+i+Lx)%Lx][y]!=0){
            flag=false;
        }
    }
    if(flag == true)
    {
            K_mer_counter++;
            ver_count++;
            for (i=0;i<K;i++){
            //Lat[x][(y+i+Ly) % Ly]= K_mer_counter;
            Lat[(x+i+Lx)%Lx][y]= 2;
        
            }
             active[first]= ((x+Lx)%Lx);
        printf("VERTICAL :: The first index of the %d th vertical polymer is %d: \n", first,  ((x+Lx)%Lx));
        
    }
    first++;
}


int main(){
    Lattice_init();
    int i,x,y;
    double r;
    
    for (i = 0; i < n; i++)
    {
        r=(double)(rand())/(double)(RAND_MAX);
        if (r<=0.5)
            vertical();
        
        else
            horizontal();
    }
    printf("total k=mers:%d\ntotal vertical K-mers :%d\ntotal horizontal K-mers :%d\n",K_mer_counter, ver_count,hor_count);
    printf("The Lattice visualization is: \n");
    for(x=0; x<Lx; x++){
        for(y=0; y<Ly; y++){
            printf("%d \t",Lat[x][y] );
        }
        printf("\n");
    }




    } 
