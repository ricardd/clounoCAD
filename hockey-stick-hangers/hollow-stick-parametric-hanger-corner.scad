include <BOSL2/std.scad>
$theta_1=160;
$turn_radius=15;

$outer_width=18;
$outer_depth=29;
$straight_length=2;
$wall_thickness=1;
$insert_thickness=3;

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


//diff()
diff()
path_sweep(rec2,path2_1,scale=0.96)face_mask(FRONT) {
zrot(55) cuboid([2,61,30]);    
    };

//diff()
path_sweep(rec2,path2_2,scale=0.96)
//face_mask(FRONT) {
//cuboid([2,61,30]);    
//    }
;

}

path_sweep(rec3,path3_1,scale=0.97);
path_sweep(rec3,path3_2,scale=0.97);


// flat cut to facilitate FDM printing
translate([55,40,0])
cube([100,50,50], anchor=LEFT,spin=$theta_1+((180-$theta_1)/2));

}



//}

//sphere(r=5);
//}

//translate([50,50,0])
//diff()
//path_sweep(rec2,path2_1,scale=0.9)
//face_mask(FRONT) {
//zrot(45) zrot_copies([10,80]) cuboid([5,61,20]);    
//    }
//;


//translate([-50,-50,0])
    
//diff()
//path_sweep(rec2,path2_1,scale=0.9){
//    attach(TOP,TOP,inside=true,align=FRONT) cuboid(10) ;
//    }
//    
