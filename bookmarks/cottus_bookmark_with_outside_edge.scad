

include  <rectangular-bookmark.scad>

//difference(){
intersection(){
back(5)
zrot(270)
rect_bookmark();

//left(10)
union(){
back(5)
//scale([0.39,0.39,0.39])
//import("../../../Documents/HueForge/WIP/Humboldt/Cottus-scorpius-standard-v1_Front_200x113.stl");

left(5)
import("../../../Documents/HueForge/WIP/Humboldt/Cottus-positive-standard_Front_105x50.stl");


//back(5)
//left(40)
//import("../../../Documents/HueForge/WIP/Humboldt/Cottus-positive-standard_Front_105x50.stl");


right(74)
cuboid([55,60,1.475], anchor=BOT);

left(82)
cuboid([50,60,1.475], anchor=BOT);

}


}

width=50;
length=160;
thickness=1.475;

back(5)
zrot(270)
rect_tube(size=[width,length], wall=2, rounding=8, irounding=8, h=thickness+0.16);


//color([1,0,0])


//color([1,0,0])



//up(0.25)
//back(10)
//right(55)
//yrot(180)
//linear_extrude(3)
//color([1,0,0])
//text("Cottus scorpius", size=4);
//
//
//up(0.25)
//back(5)
//right(55)
//yrot(180)
//color([1,0,0])
//linear_extrude(3)
//color([1,0,0])
//text("ICHTYOLOGIE", size=3);
//
//
//up(0.25)
//right(55)
//yrot(180)
//linear_extrude(3)
//color([1,0,0])
//text("Marc Elisier Bloch 1787", size=3);
////}
