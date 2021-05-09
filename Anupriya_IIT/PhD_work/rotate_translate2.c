#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include"mt19937ar.h"
#include"mt19937ar.c"
//#include</home/joyjit/mt19937ar.h>
//#include</home/joyjit/mt19937ar.c>


/* This prog simulates the long rods problem with no intersection
 * allowed in two dimensions. It is  a montecarlo simulation with
 * (1)deposition, (2) evaporation, (3) translation, (4) rotation. The initial
 * conditions can be of two kinds: (1) all empty and (2) all occupied
 * in horizontal direction. This is controlled using INITIAL_FLAG. The
 * mean density, order parameter and second and fourth moment are
 * measured. Horizontal rod is marked with 1 on lat while vertical rod
 * is marked with 2. Time increases by one when roughly N evaporation
 * and deposition moves are attempted*/

#define K 7  /* length of K-mer*/
#define L 126 	/*Number of sites in one direction  LxL lattice*/
#define N (L*L) /* The total number of sites */
#define DIR 2 /*Number of positive directions */
#define NN 2 /*Number of nearest neighbours in forward direction */
#define T 10000000	/*# of MC steps for equilibration*/
#define BLOCKS 10 /*Number of blocks in which average is taken*/
#define AVE 5000000 /* # of readings in each block */
#define PSTART 0.9995 /*starting probability*/
#define PDIFF 0.1 /*increment in probability*/
#define PEND (PSTART+0.5*PDIFF) /*ending probability */
#define GAP2 1000 /*GAP after which output is written during equilibration */
#define INITIAL_FLAG 0 /*0: all empty 1: all filled */
#define BINS 101 /*Keep it odd*/
#define BINSIZE (2.0/(1.0*BINS))
#define RO 2 /*Ratio of rotation*/
#define TR 9 /*ratio of translation*/
#define ED 6 /*ratio of evap+dep */
#define P1 (1.0*RO/(1.0*(RO+TR+ED))) /*prob of rotation*/
#define P2 (1.0*TR/(1.0*(RO+TR+ED))) /*prob of translation*/
#define P3 (1.0-P1-P2) /*prob of evap-dep*/

int lat[N],active[N/K],last,nbr[N][NN],xcoord[N],ycoord[N]; 
double tot_time,prob,count[BINS];
double meanrho[BLOCKS],meanabs[BLOCKS];
double meanm1[BLOCKS],meanm2[BLOCKS],meanm4[BLOCKS];
char outfile1[100],outfile2[100],outfile3[100];

void print_config()
{
	/* Prints out the configuration */
	int x,y;

	for(y=L-1;y>=0;y--)
	{
		for(x=0;x<L;x++)
			printf("%2d",lat[find_site(x,y)]);
		printf("\n");
	}
	printf("***************************\n");
	sleep(2);
}

int find_site(int x, int y)
{
	/* Given x, y it gives site index */
	x=(x+L) % L;
	y=(y+L) % L;
	return x+y*L;
}

void take_input()
{
	/*reads in seed for random number generator */
	long seedval;

	scanf("%ld",&seedval);
	init_genrand(seedval);
}

void initialize()
{
	/* initializes nbr list and output file names */
	int i,j,x,y;

	for(y=0;y<L;y++)
	{
		for(x=0;x<L;x++)
		{
			i=find_site(x,y);
			xcoord[i]=x;
			ycoord[i]=y;
			j=find_site(x+1,y); nbr[i][0]=j;
			j=find_site(x,y+1); nbr[i][1]=j;
		}
	}
	if(INITIAL_FLAG==0)
		sprintf(outfile1,"emptyK%dL%d",K,L);
	if(INITIAL_FLAG==1)
		sprintf(outfile1,"filledK%dL%d",K,L);
}

void lat_init()
{
	/* Initializes quantities that have to initialized for every value
	 * of probability p */
	int i;
	FILE *fp;

	last=0; 
	for(i=0;i<BLOCKS;i++)
	{
		meanrho[i]=0;meanabs[i]=0;meanm1[i]=0; meanm2[i]=0; meanm4[i]=0;
	}
	tot_time=0;
	if(L % K !=0)
	{
		printf("ERROR IN DIVISIBILITY\n");
		exit(0);
	}
	for(i=0;i<BINS;i++)
		count[i]=0;
	if(INITIAL_FLAG==0)
	{
		for(i=0;i<N;i++)
			lat[i]=0;
		sprintf(outfile2,"emptyK%dL%dP%5.4lf_t",K,L,prob);
		sprintf(outfile3,"emptyK%dL%dP%5.4lf_p",K,L,prob);
	}
	if(INITIAL_FLAG==1)
	{
		for(i=0;i<N;i++)
			lat[i]=1;
		for(i=0;i<N/K;i++)
		{
			active[last]=i*K;
			last++;
		}
		sprintf(outfile2,"filledK%dL%dP%5.4lf_t",K,L,prob);
		sprintf(outfile3,"filledK%dL%dP%5.4lf_p",K,L,prob);
	}
	fp=fopen(outfile2,"w");
	fprintf(fp,"#t rho abs(m) m\n");
	fclose(fp);
}

int chk_compatibility(int i,int dir)
{
	/*checks whehter a k-mer can be put */
	int j;

	/*print_config();*/
	if((dir<0) || (dir >= DIR))											
		printf("error\n");					
	for(j=0;j<K;j++)													//DOUBT
	{
		/*printf("i=%d lat[i]=%d\n",i,lat[i]);*/
		if(lat[i]!=0)
			return 0;
		i=nbr[i][dir];	
	}
	return 1;
}

void place_rod(int i, int dir)
{
	/* places a k-mer with head at i in direction dir */
	int j;

	active[last]=i;
	last++;
	for(j=0;j<K;j++)// what is the use of j?
	{
		lat[i]=dir+1;
		i=nbr[i][dir];
	}
}

void remove_rod(int j,int i)
{
	/* removes a with head at j and at i in active list */
	int k,dir;

	dir=lat[j]-1;
	for(k=0;k<K;k++)//what is the use of k?
	{
		lat[j]=0;
		j=nbr[j][dir];
	}
	active[i]=active[last-1];
	last--;
}

void deposit()
{
	int i,j,dir,flag1,index;
	
	/*index=0;*/
	do
	{
		i=floor(genrand_real3()*N);
		/*printf("lat[%d]=%d; index=%d\n",i,lat[i],index);
		index++;*/
	} 
	while(lat[i]!=0);
	dir=floor(genrand_real3()*DIR);
	if(chk_compatibility(i,dir) == 1)
		place_rod(i,dir);
}

void evaporate()
{
	int i,dir;
	
	i=floor(genrand_real3()*last);
	remove_rod(active[i],i);
}

void translate()
{
	int i,dir,inew,j,eta;
	
	i=floor(genrand_real3()*last);
	j=active[i];
	dir=lat[j]-1;
	remove_rod(j,i);
	eta=floor(genrand_real3()*2*DIR);
	inew=find_site(xcoord[j]+(1-(eta/DIR))*(1-2*eta),ycoord[j]+(eta/DIR)*(5-2*eta));
	if(chk_compatibility(inew,dir) == 1)
		place_rod(inew,dir);
	else
		place_rod(j,dir);
}

void rotate()
{
	int i,dir,inew,j;

	i=floor(genrand_real3()*last);
	j=active[i];
	dir=lat[j]-1;
	remove_rod(j,i);
	inew=find_site(xcoord[j]+(1-2*dir)*(K/2),ycoord[j]-(1-2*dir)*(K/2));
	if(chk_compatibility(inew,1-dir) == 1)
		place_rod(inew,1-dir);
	else
		place_rod(j,dir);
}

void evolve()
{
	double ran,rate;

	rate=prob*(N-last*K)*P3 + (1.0-prob)*last*P3 + last*P2+last*P1;
	tot_time=tot_time+P3/rate;
	ran=genrand_real3()*rate;
	if(ran<last*P1)
	{
		rotate();
		/*printf("rotate\n");*/
	}
	else
	{
		if(ran<(last*(P1+P2)))
		{
			translate();
			/*printf("translate\n");*/
		}
		else
		{
			if(ran< (last*(P1+P2+(1.0-prob)*P3)))
			{
				evaporate();
				/*printf("evaporate\n");*/
			}
			else
			{
				deposit();
				/*printf("deposit\n");*/
			}
		}
	}
}


void take_reading(int j)
{
	int i,lasth,lastv;
	double tmp,sum;

	lasth=0;
	for(i=0;i<last;i++)
		if(lat[active[i]]==1)
			lasth++;
	lastv=last-lasth;

	tmp=1.0*(lasth-lastv)*K/(1.0*N);
	meanrho[j]=meanrho[j]+1.0*last*K/(1.0*N);
	meanabs[j]=meanabs[j]+fabs(tmp);
	meanm1[j]=meanm1[j]+tmp;
	meanm2[j]=meanm2[j]+tmp*tmp;
	meanm4[j]=meanm4[j]+tmp*tmp*tmp*tmp;
	i=floor((tmp+1.0)/BINSIZE);
	if((i<BINS) && (i>=0))
		count[i]++;
}

void output2(int t)
{
	int i,lastv,lasth;
	double tmp;
	FILE *fp;

	lasth=0;
	for(i=0;i<last;i++)
		if(lat[active[i]]==1)
			lasth++;
	lastv=last-lasth;
	tmp=1.0*(lasth-lastv)*K/(1.0*N);
	fp=fopen(outfile2,"a");
	fprintf(fp,"%d %e %e %e\n",t,1.0*last*K/(1.0*N),fabs(tmp),tmp);
	fclose(fp);
}

void output1(int ave)
{
	int i;
	double sum1,sum2,tmp,tmp1,tmp2;
	FILE *fp;

	tmp=1.0/(1.0*ave);
	tmp1=1.0/(1.0*BLOCKS);
	tmp2=sqrt(tmp1);
	for(i=0;i<BLOCKS;i++)
	{
		meanrho[i]=meanrho[i]*tmp;
		meanabs[i]=meanabs[i]*tmp;
		meanm1[i]=meanm1[i]*tmp; 
		meanm2[i]=meanm2[i]*tmp; 
		meanm4[i]=meanm4[i]*tmp;
	}
	fp=fopen(outfile1,"a");
	fprintf(fp,"%e",prob);

	sum1=0;sum2=0;
	for(i=0;i<BLOCKS;i++)
	{
		sum1=sum1+meanrho[i];
		sum2=sum2+meanrho[i]*meanrho[i];
	}
	sum1=sum1*tmp1;sum2=sum2*tmp1;
	fprintf(fp," %e %e",sum1,sqrt(sum2-sum1*sum1)*tmp2);

	sum1=0;sum2=0;
	for(i=0;i<BLOCKS;i++)
	{
		sum1=sum1+meanabs[i];
		sum2=sum2+meanabs[i]*meanabs[i];
	}
	sum1=sum1*tmp1;sum2=sum2*tmp1;
	fprintf(fp," %e %e",sum1,sqrt(sum2-sum1*sum1)*tmp2);

	sum1=0;sum2=0;
	for(i=0;i<BLOCKS;i++)
	{
		sum1=sum1+meanm1[i];
		sum2=sum2+meanm1[i]*meanm1[i];
	}
	sum1=sum1*tmp1;sum2=sum2*tmp1;
	fprintf(fp," %e %e",sum1,sqrt(sum2-sum1*sum1)*tmp2);

	sum1=0;sum2=0;
	for(i=0;i<BLOCKS;i++)
	{
		sum1=sum1+meanm2[i];
		sum2=sum2+meanm2[i]*meanm2[i];
	}
	sum1=sum1*tmp1;sum2=sum2*tmp1;
	fprintf(fp," %e %e",sum1,sqrt(sum2-sum1*sum1)*tmp2);

	sum1=0;sum2=0;
	for(i=0;i<BLOCKS;i++)
	{
		sum1=sum1+meanm4[i];
		sum2=sum2+meanm4[i]*meanm4[i];
	}
	sum1=sum1*tmp1;sum2=sum2*tmp1;
	fprintf(fp," %e %e\n",sum1,sqrt(sum2-sum1*sum1)*tmp2);

	fclose(fp);


	fp=fopen(outfile3,"w");
	fprintf(fp,"#m P(m)\n");
	for(i=0;i<BINS;i++)
	{
		if(count[i]!=0)
			fprintf(fp,"%e %e\n",-1.0+(i+0.5)*BINSIZE,count[i]/ave/BINSIZE/BLOCKS);
	}
	fclose(fp);

}

void chk_config()
{
	int i,j;
	j=0;
	for (i=0;i<N;i++)
	{
		if(lat[i]!=0)
			j++;
		if((lat[i]>= DIR)||(lat[i]<0))
		{
			printf("ERROR IN STATE\n");
			sleep(3);
		}
	}
	if(j!=last*K)
	{
		printf("ERROR IN BOOK KEEPING\n");
		sleep(3);
	}
}

main()
{
	int i,j;
	FILE *fp;
	void output(int ave);
	

	take_input();
	initialize();
	scanf("%lf",&prob);
	lat_init();
	for(i=0;i<T;i++)
	{
		while(tot_time<i)
		{
			evolve();
		}
		if(i % GAP2 ==0)
			output2(i);
	}
	for(j=0;j<BLOCKS;j++)
	{
		tot_time=0;
		for(i=0;i<AVE;i++)
		{
			while(tot_time<i)
			{
				evolve();
			}
			if(i % GAP2 ==0)
				output2(T+j*BLOCKS+i);
			take_reading(j);
		}
	}
	output1(AVE);
}

