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
#define T 100000000
#define rho 0.65
#define p 1
#define p1 1-p
#define p2 p/2.0
#define p3 p/2.0
#define GAP 10000
#define h_orientation 1
#define v_orientation 2


int Lat[Lx][Ly];
int orientation_type[n + 1];
int pivotListX[n];
int pivotListY[n];
int headListX[n];
int headListY[n];
int hor_count = 0, ver_count = 0, K_mer_counter = 0;
int N_Kmer = ((rho * N) / K);
int PBCX(int x);
int PBCY(int y);
int shiftLeftDown(int pivotx, int pivoty, int orientation, int pivotChoice);
int shiftRightUp(int pivotx, int pivoty, int orientation, int pivotChoice);
int rotate(int pivotx, int pivoty, int orientation);
int translate(int pivotx, int pivoty, int orientation, int pivotChoice);
int NN_orientation();
void output(int t);
char outfile1[100];
time_t tt;
//srand((unsigned) time(&t));

int PBCX(int x)
{
    return (x + Lx) % Lx;
}

int PBCY(int y)
{
    return (y + Ly) % Ly;
}




void horizontal() {                          //function for creating horizontal K-mers
    int x, y, i;
    bool flag;
    do
    {
        x = Lx * genrand_real3();
        y = Ly * genrand_real3();

        flag = true;

        for (i = 0; i < K; i++) {
            if (Lat[x][PBCY(y + i)] != 0) {
                flag = false;
            }
        }
    } while (flag != true);

    if (flag == true)
    {
        pivotListX[K_mer_counter] = x;
        pivotListY[K_mer_counter] = PBCY(y + K / 2);
        // printf("\n horizontal: K_mer_counter%d pivotx %d pivoty %d\n",K_mer_counter,pivotListX[K_mer_counter], pivotListY[K_mer_counter]);
        K_mer_counter++;
        orientation_type[K_mer_counter] = h_orientation;
        hor_count++;
        for (i = 0; i < K; i++) {
            Lat[x][PBCY(y + i)] = K_mer_counter;
            // Lat[x][(y+i+Ly) % Ly]= 1;

        }

    }


}


void vertical() {                           //function for creating vertical K-mers

    int x, y, i;
    bool flag;
    do
    {
        x = Lx * genrand_real3();
        y = Ly * genrand_real3();

        flag = true;

        for (i = 0; i < K; i++) {
            if (Lat[PBCX(x + i)][y] != 0) {
                flag = false;
            }
        }
    } while (flag != true);

    if (flag == true)
    {
        pivotListX[K_mer_counter] = PBCX(x + (K / 2));
        pivotListY[K_mer_counter] = y;
        // printf("\n vertical: K_mer_counter%d pivotx %d pivoty %d\n",K_mer_counter,pivotListX[K_mer_counter], pivotListY[K_mer_counter]);
        K_mer_counter++;
        orientation_type[K_mer_counter] = v_orientation;
        ver_count++;
        for (i = 0; i < K; i++) {
            Lat[PBCX(x + i)][y] = K_mer_counter;
            //Lat[(x+i+Lx)%Lx][y]= 2;

        }


    }

}


int rotate(int pivotx, int pivoty, int orientation)
{
    bool flag = true;
    for (int i = 1; i <= K / 2; i++)
    {
        if (orientation == 2)
        {
            if (Lat[pivotx][PBCY(pivoty + i)] != 0 || Lat[pivotx][PBCY(pivoty - i)] != 0)
            {
                flag = false;
            }
        }
        else
        {
            if (Lat[PBCX(pivotx + i)][pivoty] != 0 || Lat[PBCX(pivotx - i)][pivoty] != 0)
            {
                flag = false;
            }
        }
    }
    if (flag == false)
        return -1;


    for (int i = 1; i <= K / 2; i++)
    {
        if (orientation == 2)
        {
            orientation_type[Lat[pivotx][pivoty]] = h_orientation;
            Lat[pivotx][PBCY(pivoty + i)] = Lat[pivotx][pivoty];
            Lat[PBCX(pivotx + i)][pivoty] = 0;
            Lat[pivotx][PBCY(pivoty - i)] = Lat[pivotx][pivoty];
            Lat[PBCX(pivotx - i)][pivoty] = 0;

            // Lat[pivotx][pivoty]=Lat[pivotx][pivoty];
            // printf("\nrotated: orientation_type %d, pivotx %d pivoty %d, New_Lat_no_right %d, Old_Lat_no_down %d, New_Lat_no_left %d, Old_Lat_no_up %d\n",h_orientation, pivotx, pivoty,Lat[pivotx][PBCY(pivoty+i)],Lat[PBCX(pivotx+i)][pivoty], Lat[pivotx][PBCY(pivoty-i)],Lat[PBCX(pivotx-i)][pivoty] );
        }
        else
        {
            orientation_type[Lat[pivotx][pivoty]] = v_orientation;
            Lat[pivotx][PBCY(pivoty + i)] = 0;
            Lat[PBCX(pivotx + i)][pivoty] = Lat[pivotx][pivoty];
            Lat[pivotx][PBCY(pivoty - i)] = 0;
            Lat[PBCX(pivotx - i)][pivoty] = Lat[pivotx][pivoty];

            // Lat[pivotx][pivoty]=Lat[pivotx][pivoty];
        }
    }
    if (orientation == 2)
    {
        ver_count--;
        hor_count++;
    }
    else {
        ver_count++;
        hor_count--;
    }
    return 0;
}


int translate(int pivotx, int pivoty, int orientation, int pivotChoice)
{
    double r = (double)(rand()) / (double)(RAND_MAX);
    // printf("random = %f\n",r );
    if (r > 0.5)
    {
        return shiftRightUp(pivotx, pivoty, orientation, pivotChoice);
    }
    else
    {
        return shiftLeftDown(pivotx, pivoty, orientation, pivotChoice);
    }
}

int shiftRightUp(int pivotx, int pivoty, int orientation, int pivotChoice)
{
    int headx, heady;
    if (orientation == 2)
    {
        headx = PBCX(pivotx - (K / 2) - 1);
        if (Lat[headx][pivoty] == 0)
        {
            Lat[headx][pivoty] = Lat[pivotx][pivoty];
            Lat[PBCX(pivotx + (K / 2))][pivoty] = 0;
            pivotListX[pivotChoice] = PBCX(pivotListX[pivotChoice] - 1);
        }
        else
        {
            return -1;

        }
    }
    else
    {
        heady = PBCY(pivoty + (K / 2) + 1);
        if (Lat[pivotx][heady] == 0)
        {
            Lat[pivotx][heady] = Lat[pivotx][pivoty];
            Lat[pivotx][PBCY(pivoty - (K / 2))] = 0;
            pivotListY[pivotChoice] = PBCY(1 + pivotListY[pivotChoice]);

        }
        else
        {
            return -1;

        }
    }
    return 0;
}

int shiftLeftDown(int pivotx, int pivoty, int orientation, int pivotChoice)
{
    int headx, heady;
    if (orientation == 2)
    {
        headx = PBCX(pivotx + (K / 2) + 1);
        if (Lat[headx][pivoty] == 0)
        {
            Lat[headx][pivoty] = Lat[pivotx][pivoty];
            Lat[PBCX(pivotx - (K / 2))][pivoty] = 0;
            pivotListX[pivotChoice] = PBCX(pivotListX[pivotChoice] + 1);
        }
        else {
            return -1;

        }
    }
    else
    {
        heady = PBCY(pivoty - (K / 2) - 1);
        if (Lat[pivotx][heady] == 0)
        {
            Lat[pivotx][heady] = Lat[pivotx][pivoty];
            Lat[pivotx][PBCY(pivoty + (K / 2))] = 0;
            pivotListY[pivotChoice] = PBCY(pivotListY[pivotChoice] - 1);

        }
        else {
            return -1;

        }
    }
    return 0;
}

int printLattice()
{
    int remaining;
    for (K_mer_counter = 0; K_mer_counter < N_Kmer; K_mer_counter++) {

        if (orientation_type[(K_mer_counter + 1)] == h_orientation)
        {  
            headListY[K_mer_counter] = PBCY(pivotListY[K_mer_counter] - (K / 2));
            if ((headListY[K_mer_counter] + (K - 1)) != PBCY(headListY[K_mer_counter] + (K - 1))) {
                remaining = ((headListY[K_mer_counter] + (K - 1)) % Lx);
                
                printf("\n K_mer_id: %d %d %d %d 0 1\n", (K_mer_counter + 1), headListY[K_mer_counter], pivotListX[K_mer_counter], ((K - 1) - remaining));
                printf("\n K_mer_id: %d 0 %d %d 0 1\n", (K_mer_counter + 1), pivotListX[K_mer_counter], remaining);
            }
            if ((headListY[K_mer_counter] + (K - 1)) == PBCY(headListY[K_mer_counter] + (K - 1))) {
                
                printf("\n K_mer_id: %d %d %d %d 0 1\n", (K_mer_counter + 1), headListY[K_mer_counter], pivotListX[K_mer_counter], (K - 1));
            }
        }
            
        if (orientation_type[(K_mer_counter + 1)] == v_orientation) {
            headListX[K_mer_counter] = PBCX(pivotListX[K_mer_counter] - (K / 2));
           
            if ((headListX[K_mer_counter] + (K - 1)) != PBCX(headListX[K_mer_counter] + (K - 1))) {
                remaining = ((headListX[K_mer_counter] + (K - 1)) % Ly);
                
                printf("\n K_mer_id: %d %d %d 0 %d 2\n", (K_mer_counter + 1), pivotListY[K_mer_counter], headListX[K_mer_counter], ((K - 1) - remaining));
                printf("\n K_mer_id: %d %d 0 0 %d 2\n", (K_mer_counter + 1), pivotListY[K_mer_counter], remaining);
            }
            if ((headListX[K_mer_counter] + (K - 1)) == PBCX(headListX[K_mer_counter] + (K - 1))) {
                
                printf("\n K_mer_id: %d %d %d 0 %d 2\n", (K_mer_counter + 1), pivotListY[K_mer_counter], headListX[K_mer_counter], (K - 1));
            }
        }

    }
    /*    for(int i=0;i<Lx;i++){
            for(int j=0;j<Ly;j++)
                printf("\t%d", Lat[i][j]);
            printf("\n");
        }
        printf("\n");
        return 0; */
}

int NN_orientation(int pivotX,int pivotY){

    int n_h, n_v;
    int KMerBoundary[n+1];

    if(orientation_type[Lat[pivotX][pivotY]]==h_orientation)
    {
        n_h++;
    }else
    {
        n_v++;
    }


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
            for(int k = 0 ; k < K ; k++)
            {
                KMerBoundary[Lat[PBCX(pivotX-K/2+k)][PBCY(pivotY-1)]]=1;
                KMerBoundary[Lat[PBCX(pivotX-K/2+k)][PBCY(pivotY+1)]]=1;
            }
                            
                KMerBoundary[Lat[PBCX(pivotX-K/2-1)][PBCY(pivotY)]]=1;
                KMerBoundary[Lat[PBCX(pivotX+K/2+1)][PBCY(pivotY)]]=1;
            
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


void Lattice_init() {

    int i, j, k;
    bool flag;

    printf("initial configuration:\n");
    for (i = 0; i < Lx; i++) {
        for (j = 0; j < Ly / 2; j += K) {
            if (K_mer_counter == N_Kmer / 2) {
                break;
            }

            for (k = j; k < (j + K); k++) {

                pivotListX[K_mer_counter] = i;
                pivotListY[K_mer_counter] = PBCY(j + K / 2);
                headListY[K_mer_counter] = PBCY(j);
                //  printf("\n K_mer_id: %d px: %d py: %d hy: %d 0 %d 1\n",(K_mer_counter+1), pivotListX[K_mer_counter], pivotListY[K_mer_counter], headListY[K_mer_counter], (K-1) );
                printf("\n K_mer_id: %d %d %d %d 0 1\n", (K_mer_counter + 1), headListY[K_mer_counter], pivotListX[K_mer_counter], (K - 1));
                K_mer_counter++;
                orientation_type[K_mer_counter] = h_orientation;
                hor_count++;

                for (k = j; k < (j + K); k++) {
                    Lat[i][PBCY(k)] = K_mer_counter;
                }
            }


        }
    }

    for (j = Ly / 2; j <= Ly; j++) {
        for (i = 0; i < (2.3*Lx)/3; i += K) {
            if (K_mer_counter < N_Kmer / 2 || K_mer_counter >= N_Kmer) {
                break;
            }
            for (k = i; k < (i + K); k++) {

                pivotListY[K_mer_counter] = j;
                headListX[K_mer_counter] = PBCX(i);
                pivotListX[K_mer_counter] = PBCX(i + K / 2);

                printf("\n K_mer_id: %d %d %d 0 %d 2\n", (K_mer_counter + 1), pivotListY[K_mer_counter], headListX[K_mer_counter], (K - 1));
                // printf("\n K_mer_id: %d hx: %d px: %d py: %d %d 0 2\n",(K_mer_counter+1), headListX[K_mer_counter], pivotListX[K_mer_counter], pivotListY[K_mer_counter], (K-1));
                // printf("\n K_mer_id: %d %d %d %d 0 2\n", (K_mer_counter+1), headListX[K_mer_counter], pivotListY[K_mer_counter], (K-1) );
                K_mer_counter++;
                orientation_type[K_mer_counter] = v_orientation;
                ver_count++;

                for (k = i; k < (i + K); k++) {
                    Lat[PBCX(k)][j] = K_mer_counter;
                }
            }


        }
    }

    printf("\ntotal k_mers:%d\n", K_mer_counter);
    /*printf("The initial Lattice visualization is: \n");
    for(int i=0;i<Lx;i++){
                for(int j=0;j<Ly;j++)
                    printf("\t%d", Lat[i][j]);
                printf("\n");
            }
            printf("\n"); */

}



int evolve()
{

    int pivotChoice; 

        pivotChoice = K_mer_counter*genrand_real3();

        double r = (double)(rand())/(double)(RAND_MAX);

        
        if (r < p1){
            if(orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]] !=  NN_orientation(pivotListX[pivotChoice],pivotListY[pivotChoice]))
            rotate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
        }
        else{
            if(r >= p1 && r < p2)
                rotate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]]);
        }
        
        translate(pivotListX[pivotChoice],pivotListY[pivotChoice],orientation_type[Lat[pivotListX[pivotChoice]][pivotListY[pivotChoice]]],pivotChoice);
        
}

void output(int t) {
    double tmp;
    FILE* fp;

   // printf("t %d n_h: %d, n_v: %d\n", t, hor_count, ver_count);
    tmp = 1.0 * (hor_count - ver_count) / (1.0 * K_mer_counter);
    sprintf(outfile1, "K_mer%dLat_size%dprob%0.3frho%0.3f.dat", K, Lx, p, rho);
    fp = fopen(outfile1, "a");
    fprintf(fp, "%d  %e %e\n", t, tmp, fabs(tmp));
    fclose(fp);

}


int main() {
    srand((unsigned)time(&tt));
    int i;
    long int t;

    Lattice_init();

    for (t = 100000; t < T; t++)
    {
        for (i = 0; i < N; i++) {

            evolve();
        }


        if (t % GAP == 0) {
            output(t);

            printf("\ntime_step: %d\t horizontal: %d\tvertical: %d", t, hor_count, ver_count);
            printf("\n%s\n", "final");
            printLattice();
        }
    }




}
