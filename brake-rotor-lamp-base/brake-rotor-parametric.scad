include <BOSL2/std.scad>

tertial_diam=15;

num_nuts=5;
nuts_center_radius=55;
bolt_diameter=8;

rotor_inner_diameter=70;
rotor_outer_diameter=300;
rotor_thickness=10;

insert_outer_diam=rotor_inner_diameter-1;

rotor_head_outer_diameter=160;
rotor_head_thickness=15;

remove_height=rotor_thickness+rotor_head_thickness;

insert_thickness=rotor_thickness+rotor_head_thickness;


difference(){
cyl(h=rotor_thickness, d=rotor_outer_diameter,anchor=BOTTOM)
position(TOP)
cyl(h=rotor_head_thickness, d=rotor_head_outer_diameter, anchor=BOTTOM);

// top center piece
cyl(h=remove_height, d=rotor_inner_diameter,anchor=BOTTOM);
    
// bottom center piece
    
translate([nuts_center_radius,0,0])
cyl(h=remove_height, d=bolt_diameter,anchor=BOTTOM);

    
}

/*
color([1,0,0])
cyl(h=insert_thickness,d=insert_outer_diam);
color([0,1,0])
cyl(h=insert_thickness,d=tertial_diam);
    
*/


