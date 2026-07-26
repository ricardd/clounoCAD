include <BOSL2/std.scad>

$rect_width=47;
$rect_depth=5;

$tee_diameter=35;

//$fn=100;

minkowski(){

difference(){
union(){
translate([23,0,-40])
linear_extrude(40)
rect([$rect_depth,$rect_width], rounding=2);

rotate([90,0,0])
rotate_extrude(angle=180)
translate([23,0,0])
rect([$rect_depth,$rect_width], rounding=2);


translate([0,0,-40])
rotate([270,0,0])
rotate_extrude(angle=180,scale=2)
translate([23,0,0])
rect([$rect_depth,$rect_width], rounding=2);


}

cylinder(h=50,d=$tee_diameter);

translate([-25,0,24])
rotate([0,270,0])
left_half()
tube(h=50,ir=24,wall=15);


translate([-25,0,-64])
rotate([0,270,0])
right_half()
tube(h=50,ir=24,wall=15);

//cylinder(h=50,r=15,anchor=TOP);

}

sphere(r=2);
}

