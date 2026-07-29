include<BOSL2/std.scad>

$fn=100;

w=80;
d=20;
h=12;

wi=45;
di=8;
hi=12.1;

magnet_d=8.4;
magnet_h=2.1;

difference(){
cuboid([w,d,h], rounding=2, edges=[TOP,LEFT,RIGHT]);


fwd(4)
cuboid([wi,di,hi], rounding=-2, anchor=FRONT, edges=[TOP]);

}

back(11.0)
xrot(90)
magnet_inset(magnet_d,magnet_h);

back(11.0) left(30)
xrot(90)
magnet_inset(magnet_d,magnet_h);

back(11.0) right(30)
xrot(90)
magnet_inset(magnet_d,magnet_h);


module magnet_inset(d,h){

difference(){
cuboid([d+3.5,d+3.6,h+4], rounding=2, edges=[BOTTOM+BACK,BOTTOM+LEFT,BOTTOM+RIGHT]);
down(2.5)
cuboid([d,d,h],anchor=BOT);


}
}

