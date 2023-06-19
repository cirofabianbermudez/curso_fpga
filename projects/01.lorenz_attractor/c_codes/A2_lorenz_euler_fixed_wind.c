/*
 * Author: Ciro Fabian Bermudez Marquez
 * Date: 16/06/2022
 * Desing name: A3_lorenz_euler_fixed_wind.c
 * Description: Lorenz oscillator with forward euler simulation using fixed point for windows
 * Compile: gcc -o A2_lorenz_fixed_wind.exe A2_lorenz_euler_fixed_wind.c
 * Run: ./A2_lorenz_fixed_wind.exe
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Global variables
int _a;						// integer part
int _b;						// fractional part
int _power;

// A(a,b) fixed point representation
void initialize( int a, int b ){		
	_a = a;								
	_b = b;
	_power = (int)1 << _b;
}

// double to fixed point convertion with truncation
int setNumber( double v ){				 
	return ( (int)(v*_power) );
}

// fixed point to double convertion
double getNumber( int r ){				
	return ( (double)r/_power);
}

// fixed point multiplication with truncation
int multTrunc( int x, int y ){		
	long long r;
	long long a=0;
	long long b=0;
	a = x;
	b = y;
	r = a*b;
	r = r >> _b;
	return( r );
}

int main(void){
  	FILE *fpointer = fopen("output_lorenz_fixed.txt","w");

	int xi, yi, zi, xni, yni, zni;
    int sigma, beta, rho;
	double x0, y0, z0, h;
	int integer, frac;
    int iter = 10000;
	
	integer = 10; frac = 32 - integer - 1; 
	initialize( integer, frac );
	printf(" Representation A(a,b) = A(%d,%d)\n a: integer\tb: fractional \n",integer,frac);

	x0 = 1.0; y0 = 0.0; z0 = 1.0;
	printf(" # x0: %f\n # y0: %f\n # z0: %f\n", x0, y0, z0);
	
	xi = setNumber( x0 );
	yi = setNumber( y0 );
	zi = setNumber( z0 );
	printf(" # x0 real: %2.10f\n # y0 real: %2.10f\n # z0 real: %2.10f\n",getNumber(xi), getNumber(yi), getNumber(zi) );
    printf(" # lorenz oscillator generated, see output_lorenz_fixed.txt\n");

    sigma = setNumber( 10.0 );
    beta  = setNumber( 8.0/3.0 );
    rho   = setNumber( 28.0 );
    h     = setNumber( 0.005 );
	
	fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\t\t%8.8x\t\t%8.8x\t\t%8.8x\n",getNumber( xi ), getNumber( yi ),getNumber( zi ),xi,yi,zi);
	for(int i = 0; i<iter; i++){
        xni = xi + multTrunc( h , multTrunc( sigma, yi - xi ) );
        yni = yi + multTrunc( h , multTrunc( xi, rho - zi ) - yi );
        zni = zi + multTrunc( h , multTrunc( xi, yi ) - multTrunc( beta, zi ) );
		xi = xni;			 
		yi = yni;
		zi = zni;
        fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\t\t%8.8x\t\t%8.8x\t\t%8.8x\n",getNumber( xi ), getNumber( yi ),getNumber( zi ),xi,yi,zi);
	}
	
	fclose(fpointer);
	return 0;
}
