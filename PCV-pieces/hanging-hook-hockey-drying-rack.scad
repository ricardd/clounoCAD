include <BOSL2/std.scad>

$height=110;
$width=57;
$depth=57;

$hole_diameter=38;// to fit 3/4 inch tee

difference(){
cuboid([$width,$depth,$height],rounding=10);

// vertical hole for 3/4 inch tee
cyl(length=$height*1.2, d=$hole_diameter);

// horizontal hole for 3/4 inch tee
translate([0,0,$height/3.9])
rot(from=UP, to=BACK) cyl(length=$width*1.2, d=$hole_diameter);

// to remove
color([1,0,0])
translate([16.9,0,-20])
cuboid([$width*1.25,$depth*1.25,$height],rounding=0);
}

rect([5,$width],rounding=2);

rgn1 = right($hole_diameter/2, [rect([5,$width],rounding=2)]);

rotate_sweep(rgn1, angle=180);
