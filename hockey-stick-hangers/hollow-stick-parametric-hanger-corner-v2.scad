include <BOSL2/std.scad>

$fn=100;

$theta_1=160;
$turn_radius=15;

$outer_width=18;
$outer_depth=29;
$straight_length=2;
$wall_thickness=1.5;
$insert_thickness=2;

$rounding=5;

$gap = ((2*$turn_radius) - $outer_depth) /2; 

$protrude_1=15;
$protrude_2=10;

$protrude_flare=1;

path0 = [
for(theta=[0:1:$theta_1]) [$turn_radius*cos(theta),$turn_radius*sin(theta)]//,
    ];

rec1 = rect([$outer_depth,$outer_width], rounding=$rounding);



path_sweep(rec1,path0);


// bottom protusion
move([($outer_depth/2)+($wall_thickness/3) ,0,0])
xrot(90) 
rect_tube(
h=$protrude_1, 
size1=[$outer_depth-$wall_thickness,$outer_width-$wall_thickness], 
size2=[$outer_depth-$wall_thickness,$outer_width-$wall_thickness-$protrude_flare], 
isize1=[$outer_depth-$wall_thickness-$insert_thickness,$outer_width-$wall_thickness-$insert_thickness],
isize2=[$outer_depth-$wall_thickness-$insert_thickness,$outer_width-$wall_thickness-$insert_thickness-$protrude_flare],
rounding=$rounding
);

// top protrusion
zrot(-(180-$theta_1))
move([($turn_radius*cos($theta_1))-($straight_length*sin($theta_1))-($gap/2),0,0])
xrot(90)
rect_tube(
h=$protrude_1, 
size1=[$outer_depth-$wall_thickness,$outer_width-$wall_thickness], 
size2=[$outer_depth-$wall_thickness,$outer_width-$wall_thickness-$protrude_flare], 
isize1=[$outer_depth-$wall_thickness-$insert_thickness,$outer_width-$wall_thickness-$insert_thickness],
isize2=[$outer_depth-$wall_thickness-$insert_thickness,$outer_width-$wall_thickness-$insert_thickness-$protrude_flare],rounding=$rounding
);


move([6+($outer_depth/2),0,6])
xrot(90)
color([1,0,0])
cuboid([$outer_depth,$outer_width/2,0.3]);

// flat surface for printing without support
move([6,35,0])
zrot(-(180-$theta_1)/2)
cuboid([50,20,30]);