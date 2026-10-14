
include <BOSL2/std.scad>
include <BOSL2/hinges.scad>
include <BOSL2/walls.scad>

$fn=64;
thickness=2;
seg_gap = 0.2;
end_space = 0.6;
ang=60;



side_h=25;
side_w=190;
side_d=2;

module myhinge(inner)
   knuckle_hinge(length=side_w, segs=25,offset=thickness/2+end_space, inner=inner, clearance=-thickness/2, knuckle_diam=thickness,
                 arm_angle=45, gap=seg_gap, in_place=false, clip=thickness/2)
                 children();
module leaf() {//cuboid([25,thickness,25],anchor=TOP+BACK, rounding=7, edges=[BOT+LEFT,BOT+RIGHT]);

xrot(90)
hex_panel([side_w, side_h, side_d], 1, side_h/5, frame = 2,anchor=BOT+BACK);
}


xrot(90)
  myhinge(true){
    position(BOT) leaf();
    color("lightblue")
      up(end_space) attach(BOT,TOP,inside=true)
      tag("")  // cancel default "remove" tag
      xrot(-ang,cp=[0,-thickness/2,thickness/2]) myhinge(false)
        position(BOT) leaf();
  }

//  up(20)
//cuboid([2,40,20]){
//  position(TOP+RIGHT) orient(anchor=RIGHT)
//    knuckle_hinge(length=35, segs=9, offset=3, arm_height=0,
//          arm_angle=90, pin_fn=8, clear_top=true);
//attach(TOP,TOP)color("red")
//cuboid([2,40,20],anchor=TOP)
//  position(TOP+LEFT) orient(anchor=LEFT)
//    knuckle_hinge(length=35, segs=9, offset=3, arm_height=0,
//          arm_angle=90, pin_fn=8, clear_top=true, inner=true);    
//          }
//          