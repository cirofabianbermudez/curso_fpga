/*
 * Author: Guadalupe Alonso Contreras
 * Date: 20/07/2023
 * Desing name: A0_rucklidge_euler_float.c
 * Description: Rucklidge oscillator solve with forward euler, for unix and windows
 * Compile: gcc -o A0_rucklidge_float.exe A0_rucklidge_euler_float.c
 * Run: ./A0_rucklidge_float.exe
*/
#include <stdio.h>
#include <stdlib.h>

int main(void){

    // Open file
    FILE *fpointer = fopen("output_rucklidge.txt","w");
    
    double a  = 2.0;
    double b  = 6.7;
    double h  = 0.001;
    double x0 = 1.0;
    double y0 = 0.0;
    double z0 = 4.5;
    double xn = x0;
    double yn = y0;
    double zn = y0;
    double xni, yni, zni = 0.0;
    int iter = 500000;                   //pq si no no jala c:

    // Initial conditions
    printf(" # x0: %lf\n", x0 );
    printf(" # y0: %lf\n", y0 );
    printf(" # z0: %lf\n", z0 );
    printf(" # iter: %d\n", iter );
    printf(" # rucklidge oscillator generated, see output_rucklidge.txt\n");
       
    fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn, yn,zn);
    for(int i = 0; i < iter; i++){
        xni = xn + h*( b*yn - yn*zn -a*xn );
        yni = yn + h*( xn );
        zni = zn + h*( yn*yn - zn );
        
        xn = xni;            
        yn = yni;
        zn = zni;
        fprintf(fpointer,"%32.29lf\t%32.29lf\t%32.29lf\n",xn,yn,zn);
    }
    
    fclose(fpointer); // Close file
    return 0;
}
