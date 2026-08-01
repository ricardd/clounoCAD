$fn=100;

rotate ([0, 0, $t*360])
translate ([9, 0])
rotate ([0, 0, -$t*360])
sphere(1, center=true);

translate([10*sin($t*360), 20*cos($t*360)])
sphere(4, center=true);
