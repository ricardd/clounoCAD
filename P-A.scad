include<BOSL2/std.scad>

$fn=100;

l=8;
d=15;
s=d+5;
ds=8;

ll=(ds)+(4*s);

outer = [[0,0],[ds+(d/2),d],[ll,d],[ll,-d],[0,-d],[0,0]];

r=1;

difference(){

minkowski(){
linear_extrude(l)
polygon(outer);

sphere(r=r);
}


right(ds)
down(r+0.05)
cyl(l=(2*r)+l+0.1,d=d, anchor=LEFT+BOT,rounding=-2);
right(s+ds)
down(r+0.05)
cyl(l=(2*r)+l+0.1,d=d, anchor=LEFT+BOT,rounding=-2);
right((2*s)+ds)
down(r+0.05)
cyl(l=(2*r)+l+0.1,d=d, anchor=LEFT+BOT,rounding=-2);
right((3*s)+ds)
down(r+0.05)
cyl(l=(2*r)+l+0.1,d=d, anchor=LEFT+BOT,rounding=-2);

}
