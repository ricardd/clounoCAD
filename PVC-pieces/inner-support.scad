include <BOSL2/std.scad>
$fn=100;

outer_d=33.2;
inner_d=26.75;

front_half()
cyl(d=(outer_d+inner_d)/2,h=1);

xrot(120)
front_half()
cyl(d=(outer_d+inner_d)/2,h=1);

xrot(240)
front_half()
cyl(d=(outer_d+inner_d)/2,h=1);
