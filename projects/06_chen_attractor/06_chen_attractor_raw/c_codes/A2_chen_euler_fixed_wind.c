/*
 * Author: Guadalupe Alonso Contreras
 * Date: 18/07/2023
 * Desing name: A3_chen_euler_fixed_wind.c
 * Description: Chen oscillator with forward euler simulation using fixed point for windows
 * Compile: gcc -o A2_chen_fixed_wind.exe A2_chen_euler_fixed_wind.c
 * Run: ./A2_chen_fixed_wind.exe
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
  	FILE *fpointer = fopen("output_chen_fixed.txt","w");

	int xi, yi, zi, xni, yni, zni;
    int a, b, c;
	double x0, y0, z0, h;
	int integer, frac;
    int iter = 100000;
	
	integer = 10; frac = 32 - integer - 1; 
	initialize( integer, frac );
	printf(" Representation A(a,b) = A(%d,%d)\n a: integer\tb: fractional \n",integer,frac);

	x0 = -10.0; y0 = 0.0; z0 = 37.0;
	printf(" # x0: %f\n # y0: %f\n # z0: %f\n", x0, y0, z0);
	
	xi = setNumber( x0 );
	yi = setNumber( y0 );
	zi = setNumber( z0 );
	printf(" # x0 real: %2.10f\n # y0 real: %2.10f\n # z0 real: %2.10f\n",getNumber(xi), getNumber(yi), getNumber(zi) );
    printf(" # chen oscillator generated, see output_chen_fixed.txt\n");

    a = setNumber( 35.0 );
    b = setNumber( 3.0 );
    c = setNumber( 28.0 );
    h = setNumber( 0.001 );
	
	fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\n",getNumber( xi ), getNumber( yi ),getNumber( zi ));
	//fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\t\t%8.8x\t\t%8.8x\t\t%8.8x\n",getNumber( xi ), getNumber( yi ),getNumber( zi ),xi,yi,zi);
	for(int i = 0; i<iter; i++){
		xni = xi + multTrunc( h , multTrunc( a, yi - xi ) );
		yni = yi + multTrunc( h , multTrunc( c - a, xi ) - multTrunc( xi, zi ) + multTrunc( c, yi ) );
		zni = zi + multTrunc( h , multTrunc( xi, yi ) - multTrunc( b, zi ) );
		xi = xni;			 
		yi = yni;
		zi = zni;
        fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\n",getNumber( xi ), getNumber( yi ),getNumber( zi ));
        //fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\t\t%8.8x\t\t%8.8x\t\t%8.8x\n",getNumber( xi ), getNumber( yi ),getNumber( zi ),xi,yi,zi);
	}
	
	fclose(fpointer);
	return 0;
}
