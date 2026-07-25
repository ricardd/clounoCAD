

include  <rectangular-bookmark.scad>

difference(){
union(){
intersection(){
left(5)

rect_bookmark();

union(){
import("../../../Documents/HueForge/WIP/bookmarks/Taipei-101-with-background-standard_Front_50x127.stl");

back(89.9)
cuboid([55,60,1.76], anchor=BOT);

fwd(90.1)
cuboid([55,60,1.76], anchor=BOT);

left(27)
cuboid([5,165,1.76], anchor=BOT);

right(27)
cuboid([5,150,1.76], anchor=BOT);

}
}

width=50;
length=160;
thickness=1.76;

left(5)
rect_tube(size=[width,length], wall=2, rounding=8, irounding=8, h=thickness+0.16);

}

up(1.2)
left(24)
fwd(71)
linear_extrude(1.5)
text("Taipei 101", size=6, font="Arial");
}
