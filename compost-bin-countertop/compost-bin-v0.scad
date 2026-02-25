include <BOSL2/std.scad>

$fn=100;

$height=170;

$outer_diameter_1=110;
$outer_diameter_2=130;


$wall_width=8;

$inner_diameter_1=$outer_diameter_1-$wall_width;

$inner_diameter_2=$outer_diameter_2-$wall_width;

$bottom_thickness=4;

$outer_diameter = ($outer_diameter_1 + $outer_diameter_2)/4;


$tilt_angle = asin(0.5*($outer_diameter_2 - $outer_diameter_1) / $height);


$lip=5;
$outer_diameter_lid = $outer_diameter_2 + $lip -5;
$move = -($wall_width/4)+($outer_diameter_1+$outer_diameter_2)/4;


//bucket();
//translate([0,0,100])
lid();


module bucket(){
difference(){
cyl(l=$height,d1=$outer_diameter_1,d2=$outer_diameter_2, rounding=$bottom_thickness);

color([1,0,0])
move([0,0,$bottom_thickness])
//cyl(l=$height-(2*$bottom_thickness),d1=$inner_diameter_1,d2=$inner_diameter_2,rounding1=$bottom_thickness,rounding2=-1*$bottom_thickness);
cyl(l=$height,d1=$inner_diameter_1,d2=$inner_diameter_2,rounding1=$bottom_thickness);


// remove shape of the lid
translate([0,0,84])

//cyl(l=$height_lid+4,d1=$outer_diameter_1,d2=$outer_diameter_2, rounding=2);
lid();
    
// hole in wall for strength
for(theta=[0:15:345]){
zrot(theta)
move([$move,0,0])
color([1,0,0])
yrot($tilt_angle)
cyl(l=$height-9, d=1.5, $fn=8);
}

}

    
    }

$height_lid=7;

module lid(){
    union(){
cyl(l=$height_lid,d1=$outer_diameter_1+10,d2=$outer_diameter_2+5, rounding=2);

translate([0,0,13])
yrot(180)
onion(r=10, ang=30, cap_h=15);
}

    }
