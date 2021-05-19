#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<stdbool.h>
#include "mt19937ar.h"
#include "mt19937ar.c"
#define Lx 50
#define Ly 50
#define N (Lx*Ly)
#define n (N/K)  //total no of K-mer
#define K 3
#define N (Lx*Ly)
#define p1 0.4
#define p2 0.3
#define p3 0.3
#define h_orientation 1
#define v_orientation 2


int Lat[Lx][Ly];
int orientation_type[n+1];
int hor_count=0, ver_count=0, K_mer_counter=0;
int pivotListX[n];
int pivotListY[n];
int PBCX(int x);
int PBCY(int y);
int shiftLeftDown(int pivotx,int pivoty,int orientation);
int shiftRightUp(int pivotx,int pivoty,int orientation);
int rotate(int pivotx,int pivoty,int orientation);
int translate(int pivotx,int pivoty,int orientation);
int NN_orientation();



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
            pivotListX[K_mer_counter]=x;
            pivotListY[K_mer_counter]=PBCY(y+K/2);
            K_mer_counter++;
            orientation_type[K_mer_counter]= h_orientation;
            hor_count++;
            for (i=0;i<K;i++){
            Lat[x][(y+i+Ly) % Ly]= K_mer_counter;
           // Lat[x][(y+i+Ly) % Ly]= 1;

        }
        
    }
    
    
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
            pivotListX[K_mer_counter]=PBCX(x+(K/2));
            pivotListY[K_mer_counter]=y;
            K_mer_counter++;
            orientation_type[K_mer_counter]= v_orientation;
            ver_count++;
            for (i=0;i<K;i++){
            Lat[(x+i+Lx)%Lx][y]= K_mer_counter;
            //Lat[(x+i+Lx)%Lx][y]= 2;
        
            }
            
        
    }
    
}

int PBCX(int x)
{
    return (x+Lx)%Lx;
}

int PBCY(int y)
{
    return (y+Ly)%Ly;
}

int rotate(int pivotx,int pivoty,int orientation)
{
            bool flag = true;  
            for(int i=1;i<=K/2;i++)
            {
                if (orientation==2)
                {
                    if(Lat[pivotx][PBCY(pivoty+i)] != 0 || Lat[pivotx][PBCY(pivoty-i)] != 0)
                    {
                        flag=false;
                    }                
                }
                else
                {
                    if(Lat[PBCX(pivotx+i)][pivoty] != 0 || Lat[PBCX(pivotx-i)][pivoty] != 0)
                    {
                        flag=false;
                    } 
                }
            }
            if(flag == false)
                return -1;
             

            for(int i=1;i<=K/2;i++)
            {
                if (orientation==2)
                {
                    orientation_type[Lat[pivotx][pivoty]] = h_orientation;
                    Lat[pivotx][PBCY(pivoty+i)] =Lat[pivotx][pivoty];
                    Lat[PBCX(pivotx+i)][pivoty] =0;
                    Lat[pivotx][PBCY(pivoty-i)] = Lat[pivotx][pivoty] ;   
                    Lat[PBCX(pivotx-i)][pivoty] =0;
                    ver_count--;
                    hor_count++;
                   // Lat[pivotx][pivoty]=Lat[pivotx][pivoty];
                }
                else
                {
                    orientation_type[Lat[pivotx][pivoty]] = v_orientation;
                    Lat[pivotx][PBCY(pivoty+i)] =0;
                    Lat[PBCX(pivotx+i)][pivoty] =Lat[pivotx][pivoty];
                    Lat[pivotx][PBCY(pivoty-i)] =0;   
                    Lat[PBCX(pivotx-i)][pivoty] =Lat[pivotx][pivoty];
                    ver_count++;
                    hor_count--;
                   // Lat[pivotx][pivoty]=Lat[pivotx][pivoty];
                }
            }
            return 0;
}


int translate(int pivotx,int pivoty,int orientation)
{
    double r=(double)(rand())/(double)(RAND_MAX);
   // printf("random = %f\n",r );
   if(r>0.5)
   {
       return shiftRightUp(pivotx,pivoty,orientation);
   }
   else
     {
        return shiftLeftDown(pivotx,pivoty,orientation);
     }
}

int shiftRightUp(int pivotx,int pivoty,int orientation)
{int headx,heady;
    if(orientation==2)
    {   
         headx = PBCX(pivotx-(K/2)-1);
         if(Lat[headx][pivoty] == 0)
         {
            Lat[headx][pivoty] = Lat[pivotx][pivoty];
            Lat[pivotx+(K/2)][pivoty] = 0;
         }
         else
         {
            return -1;
            
         }
    }
    else
    {
         heady = PBCY(pivoty+(K/2)+1);
         if(Lat[pivotx][heady] == 0)
         {
            Lat[pivotx][heady] = Lat[pivotx][pivoty];
            Lat[pivotx][pivoty-(K/2)] = 0;
         }
         else
         {
            return -1;
             
         }
    }
    return 0;
}

int shiftLeftDown(int pivotx,int pivoty,int orientation)
{
    int headx,heady;
    if(orientation==2)
    {   
         headx = PBCX(pivotx+(K/2)+1);
         if(Lat[headx][pivoty] == 0)
         {
            Lat[headx][pivoty] = Lat[pivotx][pivoty];
            Lat[PBCX(pivotx-(K/2))][pivoty] = 0;
         }
         else{
            return -1;
             
         }
    }
    else
    {
         heady = PBCY(pivoty-(K/2)-1);
         if(Lat[pivotx][heady] == 0)
         {
            Lat[pivotx][heady] = Lat[pivotx][pivoty];
            Lat[pivotx][PBCY(pivoty+(K/2))] = 0;
         }else{return -1;
             
         }
    }
    return 0;
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


int NN_orientation(int pivotX,int pivotY){

    int n_h, n_v;

    int KMerBoundary[n+1];

    if(orientation_type[Lat[pivotX][pivotY]] == h_orientation)
    {
            for(int k = 0 ; k < K ; k++)
            {
                KMerBoundary[Lat[PBCX(pivotX-1)][PBCY(pivotY-K/2+k)]]=1;
                KMerBoundary[Lat[PBCX(pivotX+1)][PBCY(pivotY-K/2+k)]]=1;
            }
                            
                KMerBoundary[Lat[PBCX(pivotX)][PBCY(pivotY-K/2-1)]]=1;
                KMerBoundary[Lat[PBCX(pivotX)][PBCY(pivotY+K/2+1)]]=1;
    }
    else
        if(orientation_type[Lat[pivotX][pivotY]] == v_orientation){
    {
            for(int k = 0 ; k < K ; k++)
            {
                KMerBoundary[Lat[PBCX(pivotX-K/2+k)][PBCY(pivotY-1)]]=1;
                KMerBoundary[Lat[PBCX(pivotX-K/2+k)][PBCY(pivotY+1)]]=1;
            }
                            
                KMerBoundary[Lat[PBCX(pivotX-K/2-1)][PBCY(pivotY)]]=1;
                KMerBoundary[Lat[PBCX(pivotX+K/2+1)][PBCY(pivotY)]]=1;
            }
    }

    for(int i = 1 ;i<=n ; i++)
    {
        if(KMerBoundary[i] == 1)
        {
            if(orientation_type[i]==h_orientation)
                n_h++;
            else
                n_v++;
        }    
    }
    


    if(n_h > n_v){
        return h_orientation;
    }
    else{
        if(n_h < n_v)
            return v_orientation;
        else{
            double r=(double)(rand())/(double)(RAND_MAX);
            if(r < 0.5){
                return h_orientation;
            } 
            else{
                return v_orientation;
            }

        }
    }
}

void Lattice_init(){
    for (int i = 0; i < n; i++)
    {
        double r=(double)(rand())/(double)(RAND_MAX);
        if (r<=0.5)
            vertical();
        else
            horizontal();
    }

    printf("total k=mers:%d\ntotal vertical K-mers :%d\ntotal horizontal K-mers :%d\n",K_mer_counter, ver_count,hor_count);
    printf("The Lattice visualization is: \n");
    printLattice();
}

int evolve()
{
    for(int i =0 ; i < n ; i ++)
    {
        int pivotChoice = K_mer_counter*genrand_real3();
        double r=(double)(rand())/(double)(RAND_MAX);
        
        
        if (r < p1){
            if(orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]] !=  NN_orientation(pivotListX[pivotChoice],pivotListY[pivotChoice]))
            rotate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
        }
        else{
            if(r >= p1 && r < p2)
                rotate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
        }
    
    
        translate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
    }
        




      /*  {
            printf("translate (%d,%d))\n", pivotListX[pivotChoice],pivotListY[pivotChoice]);
            translate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
            printLattice();
        }
        else
        {
            printf("rotate (%d,%d))\n", pivotListX[pivotChoice],pivotListY[pivotChoice]);
            rotate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
            printLattice();
        }*/

}


int main (){
    int i,j,t;
    
    Lattice_init();

//for(i=1; i<= n; i++)
  //  printf("orientation %d K_mer_no %d\n",orientation_type[i],i );
    evolve();

    printf("horizontal %d \n vertical %d", hor_count, ver_count);
    printf("%s\n", "final");
    printLattice();


    
}
