include <BOSL2/std.scad>

 skin(
        [square([2,.2],center=true),
         circle($fn=64,r=0.5)], z=[0,3],
        slices=40,sampling="length",method="reindex");
        
        
        
down(5)
skin(
        [square([2,.2],center=true),
         circle($fn=64,r=0.5)], z=[0,3],
        slices=40,sampling="segment",method="reindex");        