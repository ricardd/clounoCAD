include<BOSL2/std.scad>

vesa_width=95;
vesa_height=95;
vesa_thickness=5;

hole_x=75/2;
hole_y=75/2;
hole_d=5;
hole_h=10;

//xrot(90)
difference(){
cuboid([vesa_width,vesa_height,vesa_thickness],rounding=2,edges=[BACK+RIGHT,BACK+LEFT,FWD+RIGHT,FWD+LEFT]);

back(hole_y)
right(hole_x)
cyl(d=hole_d, h=hole_h);

back(hole_y)
left(hole_x)
cyl(d=hole_d, h=hole_h);

fwd(hole_y)
right(hole_x)
cyl(d=hole_d, h=hole_h);

fwd(hole_y)
left(hole_x)
cyl(d=hole_d, h=hole_h);
}

prismoid(size1=[100,75], h=30, xang=50, yang=70);
