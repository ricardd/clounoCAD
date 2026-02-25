include <BOSL2/std.scad>
$fn=100;

$h=80;
$outer_d=33.2;
$inner_d=26.75;

$seat_d=$inner_d-2;

$th=3;

difference(){

union(){
    cyl(l=$h,d=$outer_d,rounding1=1,rounding2=1);

move([$h/4,0,0])
yrot(90)
cyl(l=$h/2,d=$outer_d,rounding1=1,rounding2=1);
}

color([1,0,0])
cyl(l=$h*1.2,d=$seat_d);


move([($h/4)+1,0,0])
yrot(90)
cyl(l=$h/2,d=$seat_d);

move([0,0,20.5])
cyl(l=$h/4,d=$inner_d,anchor=BOT,rounding2=-3);

move([0,0,-20.5])
cyl(l=$h/4,d=$inner_d,anchor=TOP,rounding1=-3);

move([($h/4)+7,0,0])
yrot(90)
cyl(l=$h/3,d=$inner_d,rounding2=-3);


}

