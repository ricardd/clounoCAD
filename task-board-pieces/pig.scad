include<BOSL2/std.scad>

difference(){
    union(){
translate([-10.5,-35,0])
linear_extrude(5)
scale([0.15,0.15,0.15])
//import("pig-head-svgrepo-com.svg");
import("happy-pig.svg");
//happy_pig_outline_06wtJ.png


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

