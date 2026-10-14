include <BOSL2/std.scad>
$fn=100;

w=144;
h=52;
d=30;
bt=2;

epd=32;
eph=25-bt;

fw=32;
fd=4;
fh=25-bt;

difference(){
cuboid([w,h,d], rounding=2, anchor=BOT);

//color([1,0,0])
up(d-eph+0.1)
eyepiece(epd,eph);

up(d-eph+0.1)
left(15+epd)
eyepiece(epd,eph);

up(d-eph+0.1)
right(15+epd)
eyepiece(epd,eph);

}


//color([1,0,0])
//up(d-eph+0.1)
//filter(fw,fd,fh);

module eyepiece(d,h){
cyl(d=d, h=h, rounding2=-2, anchor=BOT);
}

module filter(w,d,h){
cuboid([w,d,h], rounding=-2, anchor=BOT);

}