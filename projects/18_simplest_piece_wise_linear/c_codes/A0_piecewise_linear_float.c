/*
 * Author: Ciro Fabian Bermudez Marquez
 * Date: 16/06/2022
 * Desing name: A0_piecewise_linear_float.c
 * Description: 
 * Compile: gcc -o A0_piecewise_linear_float.exe A0_piecewise_linear_float.c
 * Run: ./A0_piecewise_linear_float.exe
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void){

    // Open file
    FILE *fpointer = fopen("output_piecewise_linear_float.txt","w");
    
    double a = 0.6;
    double h = 0.001;
    double x0 = 0.0;
    double y0 = -0.7;
    double z0 = 0.0;
    double xn = x0;
    double yn = y0;
    double zn = y0;
    double xni, yni, zni = 0.0;
    int iter = 1000000;

    // Initial conditions
    printf(" # x0: %lf\n", x0 );
    printf(" # y0: %lf\n", y0 );
    printf(" # z0: %lf\n", z0 );
    printf(" # iter: %d\n", iter );
    printf(" # piecewise linear oscillator generated, see output_piecewise_linear_float.txt\n");
       
    fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn, yn,zn);
    for(int i = 0; i < iter; i++){
        xni = xn + h*( yn );
        yni = yn + h*( zn );
        zni = zn + h*( -a*zn - yn + fabs(xn) - 1.0 );
        
        xn = xni;            
        yn = yni;
        zn = zni;
        fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn,yn,zn);
    }
    
    fclose(fpointer); // Close file
    return 0;
}
