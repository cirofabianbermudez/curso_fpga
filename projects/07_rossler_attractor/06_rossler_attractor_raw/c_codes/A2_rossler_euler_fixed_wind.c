/*
 * Author: Guadalupe Alonso Contreras
 * Date: 19/07/2023
 * Desing name: A3_rossler_euler_fixed_wind.c
 * Description: Rossler oscillator with forward euler simulation using fixed point for windows
 * Compile: gcc -o A2_rossler_fixed_wind.exe A2_rossler_euler_fixed_wind.c
 * Run: ./A2_rossler_fixed_wind.exe
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
  	FILE *fpointer = fopen("output_rossler_fixed.txt","w");

	int xi, yi, zi, xni, yni, zni;
    int a, b, c;
	double x0, y0, z0, h;
	int integer, frac;
    int iter = 100000;
	
	integer = 6; frac = 20 - integer - 1; 				//despues de frac = 24 la oscilación se reduce, pero aún oscila
	initialize( integer, frac );
	printf(" Representation A(a,b) = A(%d,%d)\n a: integer\tb: fractional \n",integer,frac);

	x0 = 0.1; y0 = 0.1; z0 = 0.1;
	printf(" # x0: %f\n # y0: %f\n # z0: %f\n", x0, y0, z0);
	
	xi = setNumber( x0 );
	yi = setNumber( y0 );
	zi = setNumber( z0 );
	printf(" # x0 real: %2.10f\n # y0 real: %2.10f\n # z0 real: %2.10f\n",getNumber(xi), getNumber(yi), getNumber(zi) );
    printf(" # rossler oscillator generated, see output_rossler_fixed.txt\n");

    a = setNumber( 0.2 );
    b = setNumber( 0.2 );
    c = setNumber( 5.7 );
    h = setNumber( 0.001 );
	
	fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\n",getNumber( xi ), getNumber( yi ),getNumber( zi ));
	for(int i = 0; i<iter; i++){
		xni = xi - multTrunc( h , ( yi + zi ) );
		yni = yi + multTrunc( h , ( xi + multTrunc( a, yi ) ) );
		zni = zi + multTrunc( h , ( b + multTrunc( zi, ( xi - c ) ) ) );
		xi = xni;			 
		yi = yni;
		zi = zni;
        fprintf(fpointer,"%32.27lf\t%32.27lf\t%32.27lf\n",getNumber( xi ), getNumber( yi ),getNumber( zi ));
	}
	
	fclose(fpointer);
	return 0;
}
