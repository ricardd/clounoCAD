

include  <rectangular-bookmark.scad>

difference(){
union(){
intersection(){
rect_bookmark();

union(){
left(61)fwd(55)
import("../../../Documents/HueForge/WIP/bookmarks/Frye-painting-combo_Front_150x100.stl");

back(75)
cuboid([55,60,1.76], anchor=BOT);

fwd(84)
cuboid([55,60,0.8], anchor=BOT);
}

}

width=50;
length=160;
thickness=2;

rect_tube(size=[width,length], wall=2, rounding=8, irounding=8, h=thickness+0.16);
}


left(18)back(48)up(0.6)
linear_extrude(5)
text("FRYE", font="Arial:Bold");

left(18)fwd(70)up(0.6)
linear_extrude(5)
text("FEST", font="Arial:Bold");


}