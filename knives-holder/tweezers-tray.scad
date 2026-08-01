include<BOSL2/std.scad>

$fn=100;

w=95;
d=20;
h=12;

wi=43;
di=5.3;
hi=12.1;

wi2=15;
di2=5;

magnet_d=8.4;
magnet_h=2.1;

difference(){
cuboid([w,d,h], rounding=2, edges=[TOP,LEFT,RIGHT]);

right(5) back(1)
cuboid([wi2,di2,hi], rounding=-2, anchor=LEFT+FRONT, edges=[TOP]);

//right(27) back(3)
//cuboid([wi2,di2,hi], rounding=-2, anchor=LEFT+FRONT, edges=[TOP]);

//right(5) fwd(3)
//cuboid([wi2,di2,hi], rounding=-2, anchor=LEFT+BACK, edges=[TOP]);

right(27) fwd(0)
cuboid([wi2,di2,hi], rounding=-2, anchor=LEFT+BACK, edges=[TOP]);

left(1.5) back(1.5)
cuboid([wi,di,hi], rounding=-2, anchor=RIGHT+FRONT, edges=[TOP]);

left(1.5) fwd(1.5)
cuboid([wi,di,hi], rounding=-2, anchor=RIGHT+BACK, edges=[TOP]);
}

back(11.3) left(30)
xrot(90)
magnet_inset(magnet_d,magnet_h);

back(11.3) right(30)
xrot(90)
magnet_inset(magnet_d,magnet_h);


module magnet_inset(d,h){

difference(){
cuboid([d+3.5,d+3.6,h+4], rounding=2, edges=[BOTTOM+BACK,BOTTOM+LEFT,BOTTOM+RIGHT]);
down(2.5)
cuboid([d,d,h],anchor=BOT);


}
}

