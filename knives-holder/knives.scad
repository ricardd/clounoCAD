include<BOSL2/std.scad>
include <BOSL2/walls.scad>
//$fn=100;

small_blade_w=2;
small_blade_l=95;
small_blade_d=18;

small_handle_w=17;
small_handle_l=110;
small_handle_d=35;


large_blade_w=2;
large_blade_l=150;
large_blade_d=27;

large_handle_w=26;
large_handle_l=135;
large_handle_d=40;
large_handle_slant=15;

//small_knife();
//left(40)
//large_knife();


module large_knife (){

//back(2)
//cuboid([small_handle_w,small_handle_d,  small_handle_l], anchor=TOP+BACK);
//prismoid(size1=[large_handle_w,large_handle_d],h=large_handle_l, xang=[90,90], yang=[90,90], anchor=TOP+BACK);

fwd((large_handle_d/2)-2)
down((large_handle_l/2)-5)
right((large_handle_w/2))
yrot(270)
zrot(180)
color([0,0,1])
linear_extrude(large_handle_w)
trapezoid(h=large_handle_d, w1=large_handle_l,ang=[75,90]);

// size2=[small_handle_w,small_handle_d], 
color([1,0,0])
skin([
rect([1,large_blade_d], anchor=BACK), 
rect([large_blade_w,8], anchor=BACK), 
rect([large_blade_w,1], anchor=BACK)], 
z=[0,large_blade_l,large_blade_l+3],
slices=10
);

}

module small_knife (){

back(5)
cuboid([small_handle_w, small_handle_d, small_handle_l], anchor=TOP+BACK);

color([1,0,0])
skin([
rect([1,small_blade_d], anchor=BACK), 
rect([small_blade_w,8], anchor=BACK), 
rect([small_blade_w,1], anchor=BACK)], 
z=[0,small_blade_l,small_blade_l+3],
slices=10
);

}
