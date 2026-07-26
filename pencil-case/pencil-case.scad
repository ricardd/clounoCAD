
include <BOSL2/std.scad>
include <BOSL2/walls.scad>

include <BOSL2/hinges.scad>
$fn=32;

my_n=6;
my_r=27;
end_h=10;

side_h=25;
side_w=200;
side_d=2;

up(10)left(25)
cuboid([2,side_w,side_d])
  position(TOP+RIGHT) orient(anchor=RIGHT)
    knuckle_hinge(length=side_w-20, segs=20, offset=2, arm_height=0);
    
    
hex_panel([side_h, side_w, side_d], 1, side_h/5, frame = 2);

my_theta=180-(((my_n-2)*180)/my_n);
x1=sin(my_theta)*side_h;
z1=cos(my_theta)*side_h;

right(x1)
up(z1)
yrot(-my_theta)
hex_panel([side_h, side_w, side_d], 1, side_h/5, frame = 2);

left(30)
hex_panel([side_h, side_w, side_d], 1, side_h/5, frame = 2);

left(60)
hex_panel([side_h, side_w, side_d], 1, side_h/5, frame = 2);
left(90)
hex_panel([side_h, side_w, side_d], 1, side_h/5, frame = 2);
left(120)
hex_panel([side_h, side_w, side_d], 1, side_h/5, frame = 2);


back((side_w/2)-(end_h/2))
up(24.5)
xrot(90)
color([1,0,0])
regular_prism(n=my_n, r=my_r,h=end_h);

fwd((side_w/2)-(end_h/2))
up(24.5)
xrot(90)
color([1,0,0])
regular_prism(n=my_n, r=my_r,h=end_h);

my_h=200;

//difference(){
//regular_prism(n=my_n,r=my_r,h=my_h);
//
//regular_prism(n=my_n,r=my_r-3,h=my_h+1);
//}
//
////
//up(my_h/2)
//color([1,0,0])
//regular_prism(n=my_n, r=my_r,h=end_h);
//
//down(my_h/2)
//color([1,0,0])
//regular_prism(n=my_n, r=my_r,h=end_h);
