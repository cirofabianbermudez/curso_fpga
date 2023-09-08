/*
 * Author: Ciro Fabian Bermudez Marquez
 * Date: 16/06/2022
 * Desing name: A3_piecewise_linear_euler_fixed_wind.c
 * Description: 
 * Compile: gcc -o A2_piecewise_linear_fixed_wind.exe A2_piecewise_linear_euler_fixed_wind.c
 * Run: ./A2_piecewise_linear_fixed_wind.exe
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

int abs_fixed(int x){
	int temp;
	temp = (x & 0x80000000) >> 31;
	return (temp) ? -x : x;
}

int main(void){
  	FILE *fpointer = fopen("output_piecewise_linear_fixed.txt","w");

	int xi, yi, zi, xni, yni, zni;
    int a;
	double x0, y0, z0, h;
	int integer, frac;
    int iter = 1000000;
	
	integer = 2; frac = 16 - integer - 1; 
	initialize( integer, frac );
	printf(" Representation A(a,b) = A(%d,%d)\n a: integer\tb: fractional \n",integer,frac);

	x0 = 0.0; y0 = -0.7; z0 = 0.0;
	printf(" # x0: %f\n # y0: %f\n # z0: %f\n", x0, y0, z0);
	
	xi = setNumber( x0 );
	yi = setNumber( y0 );
	zi = setNumber( z0 );
	printf(" # x0 real: %2.10f\n # y0 real: %2.10f\n # z0 real: %2.10f\n",getNumber(xi), getNumber(yi), getNumber(zi) );
    printf(" # piecewise_linear oscillator generated, see output_piecewise_linear_fixed.txt\n");

    a  = setNumber( 0.6 );
    h  = setNumber( 0.0078125 );
	
	//fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\t\t%8.8x\t\t%8.8x\t\t%8.8x\n",getNumber( xi ), getNumber( yi ),getNumber( zi ),xi,yi,zi);
	fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\n",getNumber( xi ), getNumber( yi ),getNumber( zi ));
	for(int i = 0; i < iter; i++){
        xni = xi + multTrunc( h , yi );
        yni = yi + multTrunc( h , zi );
        zni = zi + multTrunc( h , multTrunc( -a , zi ) - yi + abs_fixed(xi) - setNumber( 1.0 ) );
		xi = xni;			 
		yi = yni;
		zi = zni;
        //fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\t\t%8.8x\t\t%8.8x\t\t%8.8x\n",getNumber( xi ), getNumber( yi ),getNumber( zi ),xi,yi,zi);
        fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\n",getNumber( xi ), getNumber( yi ),getNumber( zi ));
	}
	
	fclose(fpointer);
	return 0;
}
