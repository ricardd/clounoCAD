include<BOSL2/std.scad>
include <BOSL2/walls.scad>
$fn=100;

blade_width=10;
blade_depth=30;
blade_length=155;

magnet_d=8.4;
magnet_h=2.1;

//include<knives.scad>
//back(13)
//up(160)
//yrot(180)
//large_knife();

//color([1,0,0])
//right(15)
//cuboid([1,200,200],anchor=BOT);

difference(){
knife_holder();

cuboid([100,100,10], anchor=TOP);

//up(150)
//cuboid([100,100,15], anchor=TOP);

}


//yrot(-90)
//double_magnet_inset(25,7,8,2);

//color([1,0,0])
//right(11)
//yrot(1)
//cuboid([1,70,270], anchor=BOT);


module knife_holder (){
difference(){
union(){

difference(){
prismoid(
size1=[blade_width,blade_depth], 
size2=[blade_width+15,blade_depth+15], 
h=blade_length,
rounding=5
);

right(12) up(141)
yrot(-90)
double_magnet_space(25,7);
}

color([0,1,0])
right(10) up(5)
yrot(-90)
single_magnet_inset_2(17,7,magnet_d,magnet_h);

color([0,1,0])
right(12) up(141)
yrot(-90)
double_magnet_inset(25,7,magnet_d,magnet_h);

}

yrot(-1)
down(2) //left(6)
prismoid(
size1=[blade_width-5,blade_depth-5], 
size2=[blade_width+5,blade_depth+5], 
h=blade_length+5,
rounding=2
);

hex_r=3;

// hex pattern
for(z=[1:1:9])
 for(y=[-1:1:1])
 right(10) up(8+(z*13)) down(abs(y)*5) back((y*8)+((y*z)/6))
 yrot(100)
 regular_prism(6,r=hex_r+(z/6),h=17);

for(z=[1:1:10])
 for(y=[-1:1:1])
 left(10) up(8+(z*13)) down(abs(y)*5) back((y*8)+((y*z)/6))
 yrot(80)
 regular_prism(6,r=hex_r+(z/6),h=17);

//  left(0.5)
up(blade_length)
  cuboid([blade_width+10, blade_depth+10, 10],rounding=5);
}

} // end module knife_holder


module single_magnet_inset (inset_d, inset_h, mag_d, mag_h){

difference(){
cyl(d=inset_d, h=inset_h,anchor=BOT);
up(1)
cyl(d=mag_d, h=mag_h,anchor=BOT);
}

}

module single_magnet_inset_2 (inset_d, inset_h, mag_d, mag_h){

difference(){
scale([1,1.3,1.3])
cyl(l=inset_h,d1=inset_d-4,d2=inset_d+4,anchor=BOT);
up(1)
cuboid([mag_d,mag_d,mag_h],anchor=BOT);
//cyl(d=mag_d, h=mag_h,anchor=BOT);
}

}

module double_magnet_inset (inset_d, inset_h, mag_d, mag_h){

difference(){
scale([1,1.4,1.4])
cyl(l=inset_h,d=inset_d,anchor=BOT);

up(1) back(mag_d*0.5)
cuboid([mag_d,mag_d,mag_h],anchor=BOT);
//cyl(d=mag_d, h=mag_h,anchor=BOT);

up(1) fwd(mag_d*0.5)
cuboid([mag_d,mag_d,mag_h],anchor=BOT);
//cyl(d=mag_d, h=mag_h,anchor=BOT);
}

}

module double_magnet_space (inset_d, inset_h){

scale([1,1.4,1.4])
cyl(l=inset_h,d=inset_d,anchor=BOT);


}

