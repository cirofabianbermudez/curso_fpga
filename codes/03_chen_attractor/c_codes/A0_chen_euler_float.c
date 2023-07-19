/*
 * Author: Guadalupe Alonso Contreras
 * Date: 18/07/2023
 * Desing name: A0_chen_euler_float.c
 * Description: Chen oscillator solve with forward euler, for unix and windows
 * Compile: gcc -o A0_chen_float.exe A0_chen_euler_float.c
 * Run: ./A0_chen_float.exe
*/
#include <stdio.h>
#include <stdlib.h>

int main(void){

    // Open file
    FILE *fpointer = fopen("output_chen.txt","w");
    
    double a  = 40.0;
    double b  = 3.0;
    double c  = 28.0;
    double h  = 0.001;
    double x0 = -0.1;
    double y0 = 0.5;
    double z0 = -0.6;
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
    printf(" # chen oscillator generated, see output_chen.txt\n");
       
    fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn, yn,zn);
    for(int i = 0; i < iter; i++){
        xni = xn + h*( a*( yn - xn ) );
        yni = yn + h*( (c - a)*xn - xn*zn + c*yn );
        zni = zn + h*( xn*yn - b*zn );
        
        xn = xni;            
        yn = yni;
        zn = zni;
        fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn,yn,zn);
    }
    
    fclose(fpointer); // Close file
    return 0;
}
