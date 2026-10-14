include <BOSL2/std.scad>
include <BOSL2/hinges.scad>
$fn=100;

board_tile();


module board_tile(){


cuboid([20,5,20]);
snap_lock(thick=10, foldangle=60);

snap_socket(thick=2, foldangle=60);
}