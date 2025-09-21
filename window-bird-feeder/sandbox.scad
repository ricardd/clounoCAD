include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
cuboid([50,20,10])
  attach(BACK) xcopies(10,5) dovetail("male", slide=10, width=7, taper=4, height=4);


//diff()
//cuboid(100, anchor=BOTTOM) {
//    tag("remove") attach(TOP) cuboid([95,95,105]);
//    }
