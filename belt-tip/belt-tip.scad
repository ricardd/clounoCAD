include<BOSL2/std.scad>

tip_length=40;
tip_width=28;
tip_depth=6;

difference(){
    union(){
cuboid(
[tip_length,tip_width,tip_depth],
rounding=2,
edges=[RIGHT,LEFT,BACK]
        );

translate([tip_length*0.45,0,0])
scale([0.75,1,tip_depth/tip_width])
spheroid(d=tip_width,  circum=true, $fn=10);
    }
    
color([1,0,0])
translate([-3,0,0])
cuboid(
[tip_length,tip_width*1.1,tip_depth/2.5]);

for(i=[-3:3]){
color([0,0,1])
translate([(i*5)-1,9,-5])
cylinder(h=10, r=0.5,$fn=50);
color([0,0,1])
translate([(i*5)-1,-9,-5])
cylinder(h=10, r=0.5,$fn=50);
}
color([0,0,1])
translate([-16,0,-5])
cylinder(h=10, r=0.5,$fn=50);
color([0,0,1])
translate([-16,4.5,-5])
cylinder(h=10, r=0.5,$fn=50);
color([0,0,1])
translate([-16,-4.5,-5])
cylinder(h=10, r=0.5,$fn=50);
}
