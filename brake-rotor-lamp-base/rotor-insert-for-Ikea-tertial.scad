include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=100;

tertial_diam=13;
tertial_height=25;

num_nuts=5;
nuts_center_diameter=57;
bolt_diameter=13;

rotor_diameter_1=68;
rotor_diameter_2=140;

insert_height_1 = 8;
insert_height_2 = 10;
insert_height_3 = 10;
insert_height_4 = 10.4;


//top_part();
screws();
//translate([0,0,-15])
//bottom_part();

module top_part(){
// top part in which the lamp sits
difference(){
cyl(h=insert_height_2, d=rotor_diameter_2,anchor=BOTTOM,rounding2=2)
position(TOP)
cyl(h=insert_height_1 , d=rotor_diameter_1, anchor=BOTTOM,rounding2=2);

color([1,0,0])
translate([0,0,-1])
cyl(h=tertial_height, d=tertial_diam, anchor=BOTTOM);
// remove holes for the screws
for(i=[1:num_nuts]) {
    rad=(i/num_nuts)*(360);
    x=nuts_center_diameter * cos(rad);
    y=nuts_center_diameter * sin(rad);
    
    color([1,0,0])
    translate([x,y,-1])
    cylinder(h=tertial_height, d=bolt_diameter);
    }
 
}
    }


module bottom_part(){
// bottom part that is threaded for the screws and that touches on the bottom

difference(){
color([0,1,0])    
cyl(h=insert_height_3, d=rotor_diameter_2,anchor=BOTTOM,rounding1=2)
position(BOTTOM)
// 5 feet between the screws
for(i=[1:num_nuts]) {
    deg=(360/num_nuts/2)+((i/num_nuts)*(360));
    x=nuts_center_diameter * cos(deg);
    y=nuts_center_diameter * sin(deg);
color([0,0,1])
    translate([x,y,0])
    zcyl(l=insert_height_4, r2=10, r1=4, anchor=TOP);    

}

// hole for lamp
translate([0,0,-1])
cyl(h=tertial_height, d=tertial_diam, anchor=BOTTOM);

// screw holes
for(i=[1:num_nuts]) {
    rad=(i/num_nuts)*(360);
    x=nuts_center_diameter * cos(rad);
    y=nuts_center_diameter * sin(rad);
        translate([x,y,-2])

screw_hole("M10,10",head="socket",counterbore=2,anchor=BOTTOM,thread=true);
    
}

}

    }

module screws(){
// screws
for(i=[1:num_nuts]) {
    rad=(i/num_nuts)*(360);
    x=nuts_center_diameter * cos(rad);
    y=nuts_center_diameter * sin(rad);
color([0,0,1])
    translate([x,y,0])
shoulder_screw("M10",10,length=17);
}
    }

