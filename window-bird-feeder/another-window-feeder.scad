include<BOSL2/std.scad>
include<BOSL2/joiners.scad>

$fn=100;




//
//prismoid(size1=[100,80], size2=[120,100], shift=[0,10], rounding=5, h=20, anchor=FRONT)
//
//position(BOT) up(5) back(2.5)
//
//prismoid(size1=[95,75], size2=[115,95], shift=[0,10], rounding=5, h=20);


color([0,1,0])
dovetail("female", slide=8, width=25, taper=20, height=26);
down(20) fwd(20)
color([1,1,0])
dovetail("male", slide=8, width=25, taper=20, height=26,anchor=BOT+BACK);


difference(){
color([1,0,0])
down(1) fwd(1)
cuboid([130,15,26],rounding=5,anchor=BOT+BACK,edges=[BACK+TOP, BACK+LEFT,BACK+RIGHT,TOP+LEFT,TOP+RIGHT,BOT+LEFT,BOT+RIGHT]);

up(8) left(57) fwd(15)
xrot(90)
scale([1,1.0,1])
linear_extrude(3)
text("Ralph Street bird café", size=8.5, font="Arial");

}

color([0,0,1])
down(22) fwd(5) left(47)
minkowski(){
prismoid(size1=[5,10], size2=[5,80], shift=[0,35], h=20,anchor=BOT+BACK);
sphere(r=1);
}

color([0,0,1])
down(22) fwd(5) right(47)
minkowski(){
prismoid(size1=[5,10], size2=[5,80], shift=[0,35], h=20,anchor=BOT+BACK);
sphere(r=1);
}

fwd(1) right(30) down(1)
dovetail("male", slide=8, width=25, taper=20, height=27,anchor=BOT+BACK);

fwd(1) left(30) down(1)
dovetail("male", slide=8, width=25, taper=20, height=27,anchor=BOT+BACK);


minkowski(){


difference(){
positive_space();
back(1) up(1)
negative_space();
}

sphere(r=1);
}

module positive_space() {
prismoid(size1=[100,80], size2=[120,100], shift=[0,10], rounding=0, h=20, anchor=FRONT+BOT);
rect_tube(size=[145,115], wall=1, rounding=15, h=2, anchor=FRONT+BOT);

cuboid([1,115,2], anchor=FRONT+BOT);
back(78)
cuboid([145,1,2], anchor=FRONT+BOT);


}

module negative_space() {
prismoid(size1=[99,79], size2=[119,99], shift=[0,10], rounding=5, h=20, anchor=FRONT+BOT);

}



