include <BOSL2/std.scad>
$fn=100;
// parameters
outer_d=33.2;
inner_d=26.7;
seat_d=24.7;

short_cyl_length=40;
short_inner_cyl_length=20;

long_cyl_length=50;
long_inner_cyl_length=30;

cap_length=30;
th=3;
fin_length_cap = 26.75;

fin_length = 40;
fin_width = 1;
fin_depth = 2.8;


//////////////////////////////
//short_hollowed_part();

//fwd(35)
//long_hollowed_part();
// corner bracket
//right(45)
corner_bracket();

//right(45)
//fwd(70)
//asym_corner_bracket();

// tee bracket
//left(65)
//tee_bracket();
//
//left(65)
//fwd(35)
//asym_tee_bracket();

// angle bracket
//back(80)
//elbow_bracket();
//
//back(40)
//asym_elbow_bracket();

// end cap
//fwd(70)
//end_cap();
//


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

module elbow_bracket(){
difference(){
union(){
spheroid(d=outer_d);
short_hollowed_part();
yrot(90)
short_hollowed_part();
}

short_hollowed_part_2();
yrot(90)
short_hollowed_part_2();

spheroid(d=seat_d);

}


}

module asym_elbow_bracket(){
difference(){
union(){
spheroid(d=outer_d);
short_hollowed_part();
yrot(90)
long_hollowed_part();
}

short_hollowed_part_2();
yrot(90)
long_hollowed_part_2();

spheroid(d=seat_d);

}


}


module tee_bracket(){
difference(){
union(){
short_hollowed_part();
yrot(90)
short_hollowed_part();
yrot(180)
short_hollowed_part();
}

short_hollowed_part_2();
yrot(90)
short_hollowed_part_2();
yrot(180)
short_hollowed_part_2();

}

}

module asym_tee_bracket(){
difference(){
union(){
short_hollowed_part();
yrot(90)
short_hollowed_part();
yrot(180)
long_hollowed_part();
}

short_hollowed_part_2();
yrot(90)
short_hollowed_part_2();
yrot(180)
long_hollowed_part_2();

}

}


module corner_bracket(){
difference(){
union(){
spheroid(d=outer_d);
short_hollowed_part();

xrot(90)
short_hollowed_part();

yrot(90)
short_hollowed_part();
}

//spheroid(d=inner_d);
spheroid(d=seat_d);
short_hollowed_part_2();
xrot(90)
short_hollowed_part_2();
yrot(90)
short_hollowed_part_2();
}

color([1,0,0])
rotate([90,0,135])
cyl(h=1, d=outer_d);

color([1,0,0])
rotate([135,0,0])
cyl(h=1, d=outer_d);

color([1,0,0])
rotate([0,135,0])
cyl(h=1, d=outer_d);


}

module asym_corner_bracket(){
difference(){
union(){
spheroid(d=outer_d);
short_hollowed_part();

xrot(90)
long_hollowed_part();

yrot(90)
long_hollowed_part();
}

//spheroid(d=inner_d);
spheroid(d=seat_d);
short_hollowed_part_2();
xrot(90)
long_hollowed_part_2();
yrot(90)
long_hollowed_part_2();
}
}


module short_hollowed_part () {
difference(){
cyl(d=outer_d, h=short_cyl_length, rounding2=2, anchor=BOT);

down(0.1)
cyl(d=seat_d, h=short_cyl_length, anchor=BOT);

up((short_cyl_length-short_inner_cyl_length)+0.1)
cyl(d=inner_d, h=short_inner_cyl_length, rounding2=-3, anchor=BOT);

for(rr = [0:10:360]){
xx=(inner_d/2) * sin(rr);
yy=(inner_d/2) * cos(rr);
translate([xx,yy,0])
zrot(-rr+30)

up((short_cyl_length-short_inner_cyl_length)+0.1)
cuboid([fin_width, fin_depth, fin_length], anchor=BOT);
}

up((short_cyl_length-short_inner_cyl_length)+0.1)
tube(h=0.3,od=outer_d-1,id=seat_d);
}


}


module short_hollowed_part_2 () {

cyl(d=seat_d, h=short_cyl_length, anchor=BOT);
}

module long_hollowed_part_2 () {

cyl(d=seat_d, h=long_cyl_length, anchor=BOT);
}


module long_hollowed_part () {
difference(){
cyl(d=outer_d, h=long_cyl_length, rounding2=2, anchor=BOT);

down(0.1)
cyl(d=seat_d, h=long_cyl_length, anchor=BOT);

up((long_cyl_length-long_inner_cyl_length)+0.1)
cyl(d=inner_d, h=long_inner_cyl_length, rounding2=-3, anchor=BOT);

for(rr = [0:10:360]){
xx=(inner_d/2) * sin(rr);
yy=(inner_d/2) * cos(rr);
translate([xx,yy,0])
zrot(-rr+30)

up((long_cyl_length-long_inner_cyl_length)+0.1)
cuboid([fin_width, fin_depth, fin_length], anchor=BOT);
}

up((long_cyl_length-long_inner_cyl_length)+0.1)
tube(h=0.3,od=outer_d-1,id=seat_d);
}

}


