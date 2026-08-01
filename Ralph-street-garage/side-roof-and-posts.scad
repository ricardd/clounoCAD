
up(height*0.92)
right(width-(width_short/2)+(2.5*wall_thickness))
roof(width_short, depth, -roof_pitch_short,0);

fwd((depth/2)-((1/feet_per_meter)*1000))
right(4400)
union(){
color([0,1,0])
cyl(d=(1/feet_per_meter)*1000, h=slab_depth, anchor=TOP);
cuboid([((4/12)/feet_per_meter)*1000, ((4/12)/feet_per_meter)*1000, 2900], anchor=BOT);
}

back((depth/2)-((1/feet_per_meter)*1000))
right(4400)
union(){
color([0,1,0])
cyl(d=(1/feet_per_meter)*1000, h=slab_depth, anchor=TOP);
cuboid([((4/12)/feet_per_meter)*1000, ((4/12)/feet_per_meter)*1000, 2900], anchor=BOT);
}
