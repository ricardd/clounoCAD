include <BOSL2/std.scad>

$fn=100;

$theta_0=240;
$turn_radius_0=25;

$theta_1=60;
$turn_radius_1=30;

$outer_width=18;
$outer_depth=29;
$straight_length=2;
$wall_thickness=1.5;
$insert_thickness=2;

$rounding=5;

$hook_depth=10;

$protrude_1=15;
$protrude_2=10;

$protrude_flare=3;

path0 = [
for(theta=[0:1:$theta_0]) [$turn_radius_0*cos(theta),$turn_radius_0*sin(theta)]//,
    ];

rec0 = rect([$hook_depth,$outer_width], rounding=$rounding);


path_sweep(rec0,path0);

$x_offset_path0=$turn_radius_0*cos($theta_0);
$y_offset_path0=$turn_radius_0*sin($theta_0);


path1 = [
for(theta=[0:1:$theta_1]) [($turn_radius_1*cos(theta)),($turn_radius_1*sin(theta))]
    ];

color([1,0,0])
move([-($turn_radius_1*cos($theta_1))+$x_offset_path0,-($turn_radius_1*sin($theta_1))+($y_offset_path0),0])
//zrot($theta_0)
path_sweep(rec0,path1);



rect_tube(
h=$protrude_1, 
size=[$outer_depth-$wall_thickness,$outer_width-$wall_thickness], 
isize=[$outer_depth-$wall_thickness-$insert_thickness,$outer_width-$wall_thickness-$insert_thickness],
rounding=$rounding
);

