include <BOSL2/std.scad>
$fn=100;

$h=30;
$outer_d=33.2;
$inner_d=26.75;

$th=4;

difference(){
cyl(l=$h,d=$outer_d,rounding1=5,rounding2=1, anchor=BOTTOM);

move([0,0,$th])
cyl(l=$h,d=$inner_d, rounding1=1, anchor=BOTTOM);

move([0,0,$h-$th+0.001])
cyl(l=$th,d=$inner_d, rounding1=1, rounding2=-3, anchor=BOTTOM);

for(ii=[0:10:360]){
xx=sin(ii)*(($inner_d/2)-0.5);
yy=cos(ii)*(($inner_d/2)-0.5);

translate([xx,yy,$th+1])
zrot(-ii+20)
cube([1,2.2,$h-$th]);
}

    
}
