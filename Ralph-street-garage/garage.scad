include<BOSL2/std.scad>

feet_per_meter=2.6;

//roof_pitch=20;
roof_pitch=atan(3/12);

depth=(20/feet_per_meter)*1000;
width=(11/feet_per_meter)*1000;

height=(9/feet_per_meter)*1000;

slab_depth=(1.5/feet_per_meter)*1000;
slab_protusion=((6/12)/feet_per_meter)*1000;

wall_thickness=(0.5/feet_per_meter)*1000;

left_right_offset=(width/2)-(wall_thickness/2);

roof_protusion=(2/feet_per_meter)*1000;
roof_depth=(0.3/feet_per_meter)*1000;

width_short=(6/feet_per_meter)*1000;

roof_pitch_short=atan(3/12);

pitch_height=width*tan(roof_pitch);

height_high=height+pitch_height;

door_width=((36/12)/feet_per_meter)*1000;
door_height=((80/12)/feet_per_meter)*1000;
door_thickness=((9/12)/feet_per_meter)*1000;
door_offset=((36/12)/feet_per_meter)*1000;

garage_door_width=(9/feet_per_meter)*1000;
garage_door_height=(7/feet_per_meter)*1000;
garage_door_thickness=((9/12)/feet_per_meter)*1000;;


difference(){
//////////////////////
union(){
//down(((4/12)/feet_per_meter)*1000)
//land();
slab();

left(left_right_offset+wall_thickness)
left_side();

right(left_right_offset+wall_thickness)
right_side();

//up((height/2)+(slab_depth/2))
back((depth/2)-(wall_thickness/2))
front_back();

//up((height/2)+(slab_depth/2))
fwd((depth/2)-(wall_thickness/2))
front_back();

//up(roof_depth+((height+height_high)/2))
up(0.99*(roof_depth+((height_high+height)/2)))
roof(width, depth, roof_pitch,roof_protusion);

}

color([1,1,1])
right((width/2)+(wall_thickness/2))
fwd((depth/2)-door_offset-(door_width/2))
color([0,1,0])
door_remove(door_thickness,door_width, door_height);

color([1,1,1])
fwd((depth/2)-(wall_thickness/2))
zrot(90)
color([0,1,0])
door_remove(garage_door_thickness,garage_door_width, garage_door_height);

right((width/2)+(wall_thickness/2))
up(((42/12)/feet_per_meter)*1000)
back((2.5/feet_per_meter)*1000)
side_window_remove();



left((width/2)+(wall_thickness/2))
up(height-window_down-window_unit_height)
//window_unit();
window_multi_remove(window_n_units);

right((width/2)+(wall_thickness/2))
up(height_high-window_down-window_unit_height)
//window_unit();
window_multi_remove(window_n_units);

}

// add door and garage
color([1,1,1])
fwd((depth/2)-(wall_thickness/2))
zrot(90)
color([0,1,0])
door_remove(garage_door_thickness*0.15,garage_door_width, garage_door_height);

color([1,1,1])
right((width/2)+(wall_thickness/2))
fwd((depth/2)-door_offset-(door_width/2))
color([0,1,0])
door_remove(door_thickness*0.15,door_width, door_height);

/////////////////////

side_window_unit_width=((60/12)/feet_per_meter)*1000;
side_window_unit_height=((36/12)/feet_per_meter)*1000;


module land() {
color("#B58B71")
cuboid([2.5*width,1.5*depth,slab_depth], anchor=TOP);
}

module slab() {
color([0,1,0])
cuboid([width+(2*slab_protusion)+(2*wall_thickness),depth+(2*slab_protusion),slab_depth], anchor=TOP);
}


module front_back() {
color([0,0,1])
up(height/2)
left(width/2)
yrot(90)
zrot(90)
prismoid(size1=[wall_thickness, height], size2=[wall_thickness, height_high], h=width, shift=[0,pitch_height/2]);
}


module right_side() {
color([0.5,0.2,1])
cuboid([wall_thickness, depth, height_high], anchor=BOT);

}

module left_side() {
color([0.5,0.2,1])
cuboid([wall_thickness, depth, height], anchor=BOT);
}

module roof(width, depth, pitch, protusion) {
color([0.4,0.4,0.4])
yrot(-pitch)
cuboid([width+(2*protusion)+(2*wall_thickness),depth+(2*protusion),roof_depth], anchor=TOP);

}


module door_remove(thickness, width, height) {
cuboid([thickness, width, height], anchor=BOT);
}

window_down=((9/12)/feet_per_meter)*1000;

window_unit_thickness=((8/12)/feet_per_meter)*1000;
window_unit_width=((34/12)/feet_per_meter)*1000;
window_unit_height=((15/12)/feet_per_meter)*1000;
window_n_units=4;

window_gap=((32/12)/feet_per_meter)*1000;

module window_unit(){
cuboid([window_unit_thickness,window_unit_width,window_unit_height], anchor=BOT);
}

module window_multi_remove(nu){

// even or odd number of windows?
if(nu % 2 ==0){
} else {
}


window_unit();
fwd(window_unit_width+window_gap)
window_unit();

//fwd(2*(window_unit_width+window_gap))
//window_unit();
back(window_unit_width+window_gap)
window_unit();
//back(2*(window_unit_width+window_gap))
//window_unit();

}


module side_window_remove() {
cuboid([window_unit_thickness,side_window_unit_width,side_window_unit_height], anchor=BOT);
}

