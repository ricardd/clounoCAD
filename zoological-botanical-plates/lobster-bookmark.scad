include  <rectangular-bookmark.scad>

w=50;
h=150;
d=1.5;

intersection(){

//up(5)
union(){
fwd(45)
left(30)
import("C:/Users/danie/OneDrive/Documents/HueForge/Projects/lobster_Front_60x89.stl");

fwd(74)
cuboid([50,60,1.5], anchor=BOT);

back(73)
cuboid([50,60,1.5], anchor=BOT);

}

rect_bookmark();

}

width=50;
length=160;
thickness=1.475;

//back(5)
//zrot(270)
rect_tube(size=[width,length], wall=2, rounding=8, irounding=8, h=thickness+0.16);

