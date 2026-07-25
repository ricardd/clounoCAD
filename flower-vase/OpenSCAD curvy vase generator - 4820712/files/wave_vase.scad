// OpenSCAD code to generate a vase using sine waves.
// thingiverse.com
// written by jamcultur April 2021
// follow https://www.instagram.com/jamcultur/

height = 110;           // [10:1:400]
radius = 40;            // [10:0.5:150]
wall_thickness = 2;     // [1:0.1:10]
base_thickness = 2.4;   // [0:0.1:10]
scale = 0.7;            // [0.25:0.01:4]
waves = 1;              // [0:0.01:10]
wave_amplitude = 8;     // [0:0.1:25]
wave_start_angle = 0;   // [0:0.1:360]
slices = 100;       
//$fn = 180;    

slices_per_mm = slices/height;
offset_per_mm = ((scale-1)*radius)/height;
function offset(y) =(y*offset_per_mm)+sin(((y/height)*(360*waves))+wave_start_angle)*wave_amplitude;
function x(i) = i>slices ? wall_thickness : 0;
function y(i) = i>slices ? height-((i-slices-1)/slices_per_mm) : i/slices_per_mm;

module draw_profile() {    
    translate([radius-wall_thickness,0,0]) {
        y_points = [for(i=[0:(slices*2)+1]) y(i)];
        x_points = [for(i=[0:(slices*2)+1]) x(i)+offset(y_points[i])]; 
        points = [for(i=[0:(slices*2)+1]) [x_points[i], y_points[i]]];
        polygon(points);
    }
    if (base_thickness) square([radius+x(0)+offset(0), base_thickness]);
}


minkowski(){
rotate_extrude() draw_profile();

sphere(wall_thickness /2);
}