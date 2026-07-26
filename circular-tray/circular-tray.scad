include<BOSL2/std.scad>
$fn=100;

tray(40,2,10,2);

module tray(dia,bth,hei,wth){

cyl(d=dia,h=bth,rounding=1);
down(0.001)
tube(h=hei, od=dia, wall=wth, anchor=BOT, rounding2=1);
}
