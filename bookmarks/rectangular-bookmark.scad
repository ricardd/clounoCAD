include <BOSL2/std.scad>
$fn=100;


width=30;
length=150;
thickness=3;

hole_radius=4;

difference(){
cuboid([width,length,thickness],anchor=BOT,rounding=1);

up(1.5)
back(length*0.45)
cyl(r=hole_radius, h=thickness*1.1, rounding=-1.5);
}

