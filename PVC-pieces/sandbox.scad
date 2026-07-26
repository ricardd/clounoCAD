include <BOSL2/std.scad>
$theta_1=160;
$turn_radius=23;

$outer_width=30;
$outer_depth=40;
$straight_length=10;
$wall_thickness=3;
$insert_thickness=4;

$protrude_1=15;
$protrude_2=10;

path0 = [
for(theta=[0:10:$theta_1]) [$turn_radius*cos(theta),$turn_radius*sin(theta)]//,
    ];

path1_1= [
[$turn_radius,0],
[$turn_radius,-$straight_length]
];

path1_2= [
[$turn_radius*cos($theta_1),$turn_radius*sin($theta_1)],
[($turn_radius*cos($theta_1))-($straight_length*sin($theta_1)),($turn_radius*sin($theta_1))+($straight_length*cos($theta_1))]
];

path2_1= [
[$turn_radius,-$straight_length],
[$turn_radius,-$straight_length-$protrude_1]
];

path2_2= [
[($turn_radius*cos($theta_1))-($straight_length*sin($theta_1)),($turn_radius*sin($theta_1))+($straight_length*cos($theta_1))],
[($turn_radius*cos($theta_1))-($straight_length*sin($theta_1))-($protrude_1*sin($theta_1)),($turn_radius*sin($theta_1))+($straight_length*cos($theta_1))+($protrude_1*cos($theta_1))]
];

path3_1= [
[$turn_radius,-$straight_length],
[$turn_radius,-$straight_length-$protrude_1-$protrude_2]
];

path3_2= [
[($turn_radius*cos($theta_1))-($straight_length*sin($theta_1)),($turn_radius*sin($theta_1))+($straight_length*cos($theta_1))],
[($turn_radius*cos($theta_1))-($straight_length*sin($theta_1))-($protrude_1*sin($theta_1))-($protrude_2*sin($theta_1)),($turn_radius*sin($theta_1))+($straight_length*cos($theta_1))+($protrude_1*cos($theta_1))+($protrude_2*cos($theta_1))]
];

    
rec1 = rect([$outer_depth,$outer_width], rounding=5);

rec2 = rect([$outer_depth-$wall_thickness,$outer_width-$wall_thickness], rounding=5);

rec3 = rect([$outer_depth-$wall_thickness-$insert_thickness,$outer_width-$wall_thickness-$insert_thickness], rounding=5);
//path_sweep(rec3,path3);

//minkowski(){

difference(){
union(){
path_sweep(rec1,path0);

path_sweep(rec1,path1_1);
path_sweep(rec1,path1_2);

path_sweep(rec2,path2_1);
path_sweep(rec2,path2_2);
}

path_sweep(rec3,path3_1);
path_sweep(rec3,path3_2);

// flat cut
translate([60,52,0])
cube([100,50,50], anchor=LEFT,spin=$theta_1+((180-$theta_1)/2));

}



//}

//sphere(r=5);
//}
