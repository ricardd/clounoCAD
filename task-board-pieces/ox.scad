include<BOSL2/std.scad>

difference(){
    union(){
translate([-11.5,-12.5,0])
linear_extrude(5)
scale([0.11,0.11,0.11])
import("bull-frontal-head-svgrepo-com.svg");


difference(){
color([1,0,0])
cyl(l=4,r=15,chamfer1=2,anchor=BOT); 

translate([0,0,3])
cyl(l=4,r=13,rounding=2,anchor=BOT); 

}
}

translate([0,0,1.5])
color([0,1,0])
cyl(l=2.1,r=4.1,$fn=100);   
}

