include <BOSL2/std.scad>
include <BOSL2/walls.scad>

mouth_width=15;
mouth_depth=30;

wall=5;

box_width=mouth_width + (2*wall);

tapper_width=10;
tapper_depth=10;

blade_length=100;
blade_depth=20;

wall_angle=30;

box_depth=sin(wall_angle)*blade_length;
box_height=cos(wall_angle)*blade_length;

echo(box_width);
echo(box_depth);
echo(box_height);

//cuboid([box_width, box_depth, box_height],
//anchor=BOTTOM);
up(40)fwd(20)
yrot(90)
hex_panel([box_height, box_depth, box_width],1,8,frame=0);
//cuboid([10, 10, 10]);

color([1,0,0])
xrot(wall_angle)
prismoid(size1=[mouth_width,mouth_depth], size2=[mouth_width-tapper_width,mouth_depth-tapper_depth], h=blade_length);

