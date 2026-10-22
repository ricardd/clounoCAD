include<BOSL2/std.scad>

$fn=100;

outer_diameter=33.2;
inner_diameter=26.75;
total_height=40;
seating_height=20;

difference(){
cyl(d=outer_diameter, h=total_height,rounding1=0,rounding2=5,anchor=BOT);
down(0.1)
cyl(d=inner_diameter, h=total_height-3,rounding1=-3,rounding2=0,anchor=BOT);
}
