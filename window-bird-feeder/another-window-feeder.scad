include<BOSL2/std.scad>
include<BOSL2/joiners.scad>

$fn=100;


width=140;
depth=80;
offset=20;

perch_xtra_width=25;
perch_xtra_depth=12.5;

//down(0) fwd(20)
//windowplate();
tray();

module windowplate(){
difference() {
union(){
color([1,0,0])
down(1) fwd(1)
cuboid([width,15,26],rounding=5,anchor=BOT+BACK,edges=[BACK+TOP, BACK+LEFT,BACK+RIGHT,TOP+LEFT,TOP+RIGHT,BOT+LEFT,BOT+RIGHT]);
color([1,0,0])
down(19) fwd(10) 
cuboid([width,6,26],rounding=5,anchor=BOT+BACK,edges=[BACK+TOP, BACK+LEFT,BACK+RIGHT,TOP+LEFT,TOP+RIGHT,BOT+LEFT,BOT+RIGHT]);

}

color([0,1,0])
down(1) left(30) fwd(5)
yrot(180)
dovetail("female", slide=8, width=25, taper=20, height=26.01, $slop=0.4);

color([0,1,0])
down(1) right(30) fwd(5)
yrot(180)
dovetail("female", slide=8, width=25, taper=20, height=26.01, $slop=0.4);

down(9) left(60) fwd(15.5)
xrot(90)
scale([1,1.0,1])
linear_extrude(3)
text("bird café - café oiseau", size=9, font="Arial");
}

//color([1,0,0])
//down(21) fwd(6) left(47)
//minkowski(){
//prismoid(size1=[5,10], size2=[5,depth-10], shift=[0,30], h=20,anchor=BOT+BACK, rounding=1);
//sphere(r=1);
//}

//color([1,0,0])
//down(21) fwd(6) right(47)
//minkowski(){
//prismoid(size1=[5,10], size2=[5,depth-10], shift=[0,30], h=20,anchor=BOT+BACK);
//sphere(r=1);
//}



}

module tray(){

fwd(1) right(30) down(1)
dovetail("male", slide=8, width=25, taper=20, height=24,anchor=BOT+BACK);

fwd(1) left(30) down(1)
dovetail("male", slide=8, width=25, taper=20, height=24,anchor=BOT+BACK);


minkowski(){


difference(){
positive_space();
back(1) up(1)
negative_space();
}

sphere(r=1);
}

module positive_space() {
prismoid(size1=[width-offset,depth-(offset/2)], size2=[width,depth], shift=[0,(offset/4)], rounding=0, h=20, anchor=FRONT+BOT);
rect_tube(size=[width+perch_xtra_width,depth+perch_xtra_depth], wall=1, rounding=15, h=2, anchor=FRONT+BOT);

cuboid([1,depth+perch_xtra_depth,2], anchor=FRONT+BOT);
back(depth/2)
cuboid([width+perch_xtra_width,1,2], anchor=FRONT+BOT);

rod_length = sqrt( pow(depth+(perch_xtra_depth/2),2) +pow((width/2)+(perch_xtra_width/2),2))-2;

zrot(atan((width/2)/depth))
color([1,0,0])
cuboid([1,rod_length ,2], anchor=FRONT+BOT);

zrot(-atan((width/2)/depth))
color([1,0,0])
cuboid([1,rod_length ,2], anchor=FRONT+BOT);


}

module negative_space() {
prismoid(size1=[width-offset-1,depth-(offset/2)-1], size2=[width-1,depth-1], shift=[0,(offset/4)], rounding=5, h=20, anchor=FRONT+BOT);

}


}

