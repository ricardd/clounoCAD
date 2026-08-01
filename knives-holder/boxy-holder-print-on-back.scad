include<BOSL2/std.scad>
include <BOSL2/walls.scad>
$fn=100;
w1=6;
h1=21;
w2=w1/2;
h2=29;
t1=1.5;

magnet_d=8.4;
magnet_h=2.1;

cross_section_points_inner = [[0,0],[w1,0],[w1,h1],[w2,h2],[0,h1]];

cross_section_points_outer =[[-t1,-t1],[w1+t1,-t1],[w1+t1,h1],[w2,h2+t1],[-t1,h1],[-t1,-t1]];

blade_length=164;

//include<knives.scad>
//right(168) back(3) 
//xrot(270)yrot(270)
//large_knife();

xrot(90)
union(){

yrot(90)
sleeve(blade_length);


up(t1)
back(9)
right(20)
single_magnet_insert(magnet_d,magnet_h);

up(t1)
back(9)
right(57)
single_magnet_insert(magnet_d,magnet_h);

up(t1)
back(9)
right(94)
single_magnet_insert(magnet_d,magnet_h);

up(t1)
back(9)
right(131)
single_magnet_insert(magnet_d,magnet_h);
}




module sleeve(kl){
//color([1,0,0])

difference(){
minkowski(){
difference(){
{
linear_extrude(kl)
polygon(cross_section_points_outer);
}
up(kl-7)
xrot(15)
cuboid([30,70,10], anchor=BOT);

}
 sphere(r=1);

}

down(1)
linear_extrude(kl+3)
polygon(cross_section_points_inner);

holes(6,3.5,t1*3);

}
}


module single_magnet_insert(d,h){
//cyl(d=d,h=h,anchor=BOT);

difference(){
regular_prism(10, side1=6.5, ir2=6, height=10, anchor=BOT);
up(3.3)
cuboid([d,d,h],anchor=BOT);
//cyl(d=d, h=h,anchor=BOT);

}
}



module holes(n_sides,hex_r,hex_h){

// hex pattern
for(y=[1:1:15])
 for(x=[1:1:2])
 right(8) back((x*10)-5) up((y*9.6)+(x*3))
 //color([1,0,0])
  yrot(90)
  zrot(30)

 regular_prism(6,r=hex_r,h=hex_h);

//down(w1+t1) right(10) back(10)
//zrot(0.5*(180-(((n_sides-2)*180)/n_sides)))
//regular_prism(n_sides, r=3, h=t1*3);


}
