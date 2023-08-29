/*
 * Author: Ciro Fabian Bermudez Marquez
 * Date: 16/06/2022
 * Desing name: A0_lorenz_euler_float.c
 * Description: Lorenz oscillator solve with forward euler, for unix and windows
 * Compile: gcc -o A0_lorenz_float.exe A0_lorenz_euler_float.c
 * Run: ./A0_lorenz_float.exe
*/
#include <stdio.h>
#include <stdlib.h>

int main(void){

    // Open file
    FILE *fpointer = fopen("output_lorenz_float.txt","w");
    
    double sigma = 10.0;
    double rho   = 28.0;
    double beta  = 8.0/3.0;
    double h = 0.001;
    double x0 = 0.0;
    double y0 = -0.01;
    double z0 = 9.0;
    double xn = x0;
    double yn = y0;
    double zn = y0;
    double xni, yni, zni = 0.0;
    int iter = 100000;

    // Initial conditions
    printf(" # x0: %lf\n", x0 );
    printf(" # y0: %lf\n", y0 );
    printf(" # z0: %lf\n", z0 );
    printf(" # iter: %d\n", iter );
    printf(" # lorenz oscillator generated, see output_lorenz_float.txt\n");
       
    fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn, yn,zn);
    for(int i = 0; i < iter; i++){
        xni = xn + h*( sigma*( yn - xn ) );
        yni = yn + h*( xn*( rho - zn ) - yn );
        zni = zn + h*( xn*yn - beta*zn );
        
        xn = xni;            
        yn = yni;
        zn = zni;
        fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn,yn,zn);
    }
    
    fclose(fpointer); // Close file
    return 0;
}
