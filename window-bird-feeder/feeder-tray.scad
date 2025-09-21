include<BOSL2/std.scad>
include<BOSL2/joiners.scad>

tray_width=170;
tray_depth=120;
tray_height=30;
tray_angle=120;

tray_thickness=3;

backplate_depth=10;


perch_distance=35;
perch_width=3;
perch_height=8;

difference(){
    union(){
    outer_volume();
    back_plate();
    spindles();
    perch();
    }
inner_volume();
}

// parts as modules
module outer_volume() {
    // outer volume
prismoid(
size1=[tray_width,tray_depth], 
h=tray_height, 
xang=tray_angle, 
yang=[90,tray_angle],
rounding=[10,10,0,0],
anchor=BOTTOM+FRONT
    );
}

module inner_volume() {
// inner volume to remove
translate([0,tray_thickness,tray_thickness])    
prismoid(
size1=[tray_width-(2*tray_thickness),tray_depth-(2*tray_thickness)], 
h=tray_height, 
xang=tray_angle, 
yang=[90,tray_angle],
rounding=10,
anchor=BOTTOM+FRONT);
}


module back_plate() {
// back plate
color([1,0,0])
prismoid(
size1=[tray_width, backplate_depth],
h=tray_height,
xang=tray_angle, 
yang=[90,90],
anchor=BOTTOM+BACK
);
color([1,0,0])
    translate([0,tray_thickness,tray_height])
prismoid(
size1=[tray_width+34, backplate_depth+3],
h=tray_height/1.5,
xang=90, 
yang=[90,60],
anchor=BOTTOM+BACK
);

}


module spindles(){
// left spindle
color([0,1,0])
translate([0,0,perch_height])
rotate([0,90,0])
linear_extrude((tray_width/2)+perch_distance)
square([perch_height,perch_width]);
// right spindle
color([0,1,0])
translate([0,0,0])
rotate([0,270,0])
linear_extrude((tray_width/2)+perch_distance)
square([perch_height,perch_width]);
// middle spindle
color([0,1,0])
translate([perch_width/2,0,perch_height])
rotate([0,90,90])
linear_extrude(tray_depth+perch_distance)
square([perch_height,perch_width]);
// left radial spindle
color([0,1,0])
translate([0,0,perch_height])
rotate([atan((tray_depth/2)/(tray_width/2)),90,90])
linear_extrude(sqrt((((tray_width/2)+perch_distance)^2)+(((tray_depth/1)+perch_distance)^2))-11)
square([perch_height,perch_width]);
// right radial spindle
color([0,1,0])
translate([perch_width,perch_width/2,perch_height])
rotate([-atan((tray_depth/2)/(tray_width/2)),90,90])
linear_extrude(sqrt((((tray_width/2)+perch_distance)^2)+(((tray_depth/1)+perch_distance)^2))-11)
square([perch_height,perch_width]);

    
    }

module perch(){
// perch
// left side perch
color([0,1,0])
translate([(tray_width/2)+perch_distance,tray_depth,0])
rotate([90,0,0])
linear_extrude(tray_depth)
square([perch_width,perch_height]);

// right side perch
color([0,1,0])
translate([-(tray_width/2)-perch_distance-perch_width,tray_depth,0])
rotate([90,0,0])
linear_extrude(tray_depth)
square([perch_width,perch_height]);

// front perch
color([0,1,0])
translate([-(tray_width/2),tray_depth+perch_distance,0])
rotate([90,0,90])
linear_extrude(tray_width)
square([perch_width,perch_height]);

// left corner perch
color([0,1,0])
translate([(tray_width/2),(tray_depth),0])
rotate_extrude(angle=90)
translate([perch_distance,0,0])
square([perch_width,perch_height]);
// right corner perch
color([0,1,0])
translate([-(tray_width/2),(tray_depth),0])
rotate([0,0,90])
rotate_extrude(angle=90)
translate([perch_distance,0,0])
square([perch_width,perch_height]);
    
    }

