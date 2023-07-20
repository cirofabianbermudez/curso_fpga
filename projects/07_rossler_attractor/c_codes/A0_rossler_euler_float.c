/*
 * Author: Guadalupe Alonso Contreras
 * Date: 19/07/2023
 * Desing name: A0_rossler_euler_float.c
 * Description: Rossler oscillator solve with forward euler, for unix and windows
 * Compile: gcc -o A0_rossler_float.exe A0_rossler_euler_float.c
 * Run: ./A0_rossler_float.exe
*/
#include <stdio.h>
#include <stdlib.h>

int main(void){

    // Open file
    FILE *fpointer = fopen("output_rossler.txt","w");
    
    double a  = 0.2;
    double b  = 0.2;
    double c  = 5.7;
    double h  = 0.001;
    double x0 = 0.1;
    double y0 = 0.1;
    double z0 = 0.1;
    double xn = x0;
    double yn = y0;
    double zn = y0;
    double xni, yni, zni = 0.0;
    int iter = 100000;                   //pq si no no jala c:

    // Initial conditions
    printf(" # x0: %lf\n", x0 );
    printf(" # y0: %lf\n", y0 );
    printf(" # z0: %lf\n", z0 );
    printf(" # iter: %d\n", iter );
    printf(" # rossler oscillator generated, see output_rossler.txt\n");
       
    fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn, yn,zn);
    for(int i = 0; i < iter; i++){
        xni = xn - h*(  yn + zn  );
        yni = yn + h*( xn + a*yn );
        zni = zn + h*( b + zn*( xn - c ) );
        
        xn = xni;            
        yn = yni;
        zn = zni;
        fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn,yn,zn);
    }
    
    fclose(fpointer); // Close file
    return 0;
}
