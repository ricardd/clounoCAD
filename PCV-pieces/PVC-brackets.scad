include <BOSL2/std.scad>
$fn=100;
// parameters
outer_d=33.2;
inner_d=26.75;
seat_d=24.75;

cyl_length=45;
inner_cyl_length=25;

cap_length=30;
th=3;
fin_length_cap = 26.75;

fin_length = 40;
fin_width = 1;
fin_depth = 2.5;


//////////////////////////////

//hollowed_part();
// corner bracket
//fwd(70)
corner_bracket();

// tee bracket
//tee_bracket();

// angle bracket
//back(80)
//angle_bracket();

// end cap
//left(45)
//end_cap();



//////////////////////////////
//////////////////////////////
module end_cap(){
union(){
difference(){
cyl(d=outer_d, h=cap_length, rounding2=3, anchor=BOT);
down(0.1)
cyl(d=inner_d, h=cap_length-th, rounding1=-3, anchor=BOT);

for(rr = [0:10:360]){
xx=(inner_d/2) * sin(rr);
yy=(inner_d/2) * cos(rr);
translate([xx,yy,0])
zrot(-rr+30)
cuboid([fin_width, fin_depth, fin_length_cap], anchor=BOT);

}

up(cap_length-th-1.2)
tube(h=0.3,od=outer_d-1,id=seat_d);

}

//color([1,0,0])
up(cap_length-th)
tube(h=2,od=outer_d-1,id=seat_d);
}

//color([1,0,0])

}

module angle_bracket(){
difference(){
union(){
spheroid(d=outer_d);
hollowed_part();
yrot(90)
hollowed_part();
}

hollowed_part_2();
yrot(90)
hollowed_part_2();

spheroid(d=seat_d);


translate([sin(45)*-23,0,cos(45)*-23])
rotate([0,45,0])
cuboid([100,100,20]);

}



}


module tee_bracket(){
difference(){
union(){
hollowed_part();
yrot(90)
hollowed_part();
yrot(180)
hollowed_part();
}

hollowed_part_2();
yrot(90)
hollowed_part_2();
yrot(180)
hollowed_part_2();

}

}


module corner_bracket(){
difference(){
union(){
spheroid(d=outer_d);
hollowed_part();

xrot(90)
hollowed_part();

yrot(90)
hollowed_part();
}

//spheroid(d=inner_d);
spheroid(d=seat_d);
hollowed_part_2();
xrot(90)
hollowed_part_2();
yrot(90)
hollowed_part_2();


translate([-30,30,8])
rotate([45,0,45])
//translate([sin(45)*-25,cos(45)*-25,0])
cuboid([100,100,20], anchor=CENTER);

}


}


module hollowed_part () {
difference(){
cyl(d=outer_d, h=cyl_length, rounding2=2, anchor=BOT);

down(0.1)
cyl(d=seat_d, h=cyl_length, anchor=BOT);

up((cyl_length-inner_cyl_length)+0.1)
cyl(d=inner_d, h=inner_cyl_length, rounding2=-3, anchor=BOT);

for(rr = [0:10:360]){
xx=(inner_d/2) * sin(rr);
yy=(inner_d/2) * cos(rr);
translate([xx,yy,0])
zrot(-rr+30)

up((cyl_length-inner_cyl_length)+0.1)
cuboid([fin_width, fin_depth, fin_length], anchor=BOT);
}

up((cyl_length-inner_cyl_length)+0.1)
tube(h=0.3,od=outer_d-1,id=seat_d);
}


}


module hollowed_part_2 () {

cyl(d=seat_d, h=cyl_length, anchor=BOT);
}
