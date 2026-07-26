include <BOSL2/std.scad>
diff()
cuboid(20){
//  attach(TOP,TOP,inside=true,align=RIGHT,shiftout=.01) cuboid([8,7,3]);
  attach(TOP,TOP,inside=true,align=LEFT+FRONT,shiftout=0.01) cuboid([3,4,5]);
 // attach(RIGHT+FRONT, TOP, inside=true) cuboid([10,3,5]);
 // attach(RIGHT+FRONT, TOP, inside=true, align=TOP,shiftout=.01) cuboid([5,1,2]);
}