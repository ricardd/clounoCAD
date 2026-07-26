include <BOSL2/std.scad>
$fn=100;

h=80;
outer_d=33.2;
inner_d=26.7;
thickness=(outer_d-inner_d)/2;

cut1=outer_d+10;
cut2=outer_d+35;

seat_d=inner_d-2;

offset=1;


difference(){
cyl(l=h,d=outer_d,rounding1=5,anchor=TOP);
color([1,0,0])
up(offset-0.1)
cyl(l=h+offset,d=inner_d,anchor=TOP,rounding1=-5);

}

up(20)
torus(inner_d/2,thickness);
