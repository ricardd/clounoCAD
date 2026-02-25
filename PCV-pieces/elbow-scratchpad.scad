include <BOSL2/std.scad>
$fn=100;

h=80;
outer_d=33.2;
inner_d=26.7;

cut1=outer_d+10;
cut2=outer_d+35;

seat_d=inner_d-2;

module piece(){
difference(){
cyl(l=h,d=outer_d,rounding1=5,anchor=TOP);
down(1)
cyl(l=h,d=inner_d,anchor=TOP);
left(7)
down(10)
yrot(45)
cuboid([cut2,cut1,cut1],anchor=BOT);

right(25)
down(97)
yrot(-45)
cuboid([cut2,cut1,cut1],anchor=BOT);
}
}

union(){
piece();
down(16.7)
right(60.6)
yrot(90)
piece();
}

//color([1,0,0])

//yrot(90)
//cyl(l=$h,d=$outer_d,rounding1=0,rounding2=5);

//color([1,0,0])
