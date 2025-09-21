include<BOSL2/std.scad>

tray_width=170;
tray_depth=120;
tray_height=30;
tray_angle=120;

tray_thickness=3;

backplate_depth=10;

color([0,0,1])
    translate([0,-20,0])
prismoid(
size1=[tray_width, backplate_depth],
h=tray_height/1.5,
xang=90, 
yang=[90,160],
anchor=TOP+FRONT
);

