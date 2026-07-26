include<BOSL2/std.scad>

dd=60;
hh=120;


//xrot(45)
//yrot(45)
x=-12;
y=12;
z=-12;

length=norm([x,y,z]);
b = acos(z/length);
c=atan2(y,x);

difference(){
union(){
spheroid(d=dd, anchor=CENTRE);
cyl(d=dd, h=hh, anchor=BOT);
xrot(90)
cyl(d=dd, h=hh, anchor=BOT);
yrot(90)
cyl(d=dd, h=hh, anchor=BOT);
}


translate([x,y,z])
rotate([0,b,c])
cuboid([100,100,20]);

}

