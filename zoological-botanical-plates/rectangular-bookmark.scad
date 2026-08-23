include <BOSL2/std.scad>
$fn=100;

width=50;
length=160;
thickness=2;

hole_radius=4;

//rect_bookmark();

module rect_bookmark(){
difference(){
cuboid([width,length,thickness],anchor=BOT,rounding=8, edges=[BACK+RIGHT,BACK+LEFT,FRONT+RIGHT,FRONT+LEFT]);

up(thickness*0.5)
back(length*0.44)
cyl(r=hole_radius, h=thickness*1.1, rounding=-1*(thickness-1.5));
}

}

// https://www.skyscrapercenter.com/taipei/taipei-101/117/
