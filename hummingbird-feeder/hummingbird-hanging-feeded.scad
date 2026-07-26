include<BOSL2/std.scad>
include<BOSL2/joiners.scad>

tray_radius=30;
tray_height=15;
tray_thickness=2;
wall_thinkness=1;

cyl(r=tray_radius, height=tray_thickness);
tube(h=tray_height, or=tray_radius, ir=(tray_radius-wall_thinkness), anchor=BOT);

