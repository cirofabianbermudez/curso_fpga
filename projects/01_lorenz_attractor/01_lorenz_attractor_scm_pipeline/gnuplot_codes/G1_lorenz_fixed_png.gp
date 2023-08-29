# Author: Ciro Fabian Bermudez Marquez
# Date: 16/06/2022
# Description: Plot from data file to png
# Run: gnuplot G1_lorenz_fixed_png.gp

# Terminal png default size 640, 380 font "arial,12.0"
reset
unit = 500
set term png size unit*5, unit*3.5 fontscale 2.2
filename = "../c_codes/output_lorenz_fixed.txt"

# Plot configurations 
unset key
graph_style = 103
set style line graph_style linecolor rgb "#000000"\
                                      linewidth 2 \
#                                     dashtype  1 \
#                                     pointsize 1 \
#                                     pointtype 4 \		

set xlabel "x" font ",20"
set ylabel "y" font ",20"
set zlabel "z" font ",20"

# Grid configurations
grid_major = 100
grid_minor = 101

set style line grid_major dashtype 1 linecolor rgb "#E0E0E0"
set style line grid_minor dashtype 3 linecolor rgb "#C7C7C7"
set grid xtics ytics ztics
set mxtics 2; set mytics 2; set mztics 2; 
set grid mxtics mytics mztics linestyle grid_major, lines grid_minor
set tics scale 1,0.01

set output "G1_lorenz_oscillator_xy_fixed.png"
plot filename using 1:2 with lines linestyle graph_style

set output "G1_lorenz_oscillator_xz_fixed.png"
plot filename using 1:3 with lines linestyle graph_style

set output "G1_lorenz_oscillator_yz_fixed.png"
plot filename using 2:3 with lines linestyle graph_style

set output "G1_lorenz_oscillator_3d_fixed.png"
set view 65, 50
set xyplane at 0
splot filename using 1:2:3 with lines linestyle graph_style
