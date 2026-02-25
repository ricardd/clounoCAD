include <BOSL2/std.scad>
$fn=100;

h=40;
outer_d=33.2;
inner_d=26.75;


difference(){
union(){
sphere(d=outer_d);

translate([0,0,outer_d/2])
cyl(l=outer_d, d=outer_d);

xrot(90)
translate([0,0,outer_d/2])
cyl(l=outer_d, d=outer_d);

yrot(90)
translate([0,0,outer_d/2])
cyl(l=outer_d, d=outer_d);
}

sphere(d=inner_d);

translate([0,0,outer_d/2])
cyl(l=outer_d+0.1, d=inner_d);

xrot(90)
translate([0,0,outer_d/2])
cyl(l=outer_d+0.1, d=inner_d);

yrot(90)
translate([0,0,outer_d/2])
cyl(l=outer_d+0.1, d=inner_d);


}

color([1,0,0])
translate([-15,15,0])
yrot(45)
xrot(45)
cuboid([100,100,10]);

