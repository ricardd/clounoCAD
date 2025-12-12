include<BOSL2/std.scad>

$fn=100;

path = [for (theta=[-180:5:180]) [50*sin(theta),0,50*cos(theta)]];

cir1 = circle(d=8);

difference(){
union(){
//
//
//path_sweep(cir1,path);
for(alpha=[0:(360/10):360]) zrot(alpha)
xrot(90) torus(or=40,ir=35);

color([1,0,0])
move([0,0,39])
cyl(h=5,r=8,rounding2=2);

move([0,0,39+1])
xrot(90)
color([1,0,0])
back_half() torus(or=8,ir=4);

}

move([0,0,-44])
cube([50,50,10], center=true);
}
