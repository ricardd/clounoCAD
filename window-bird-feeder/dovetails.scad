include<BOSL2/std.scad>
include<BOSL2/joiners.scad>

dovetail_slide=30;
dovetail_width=15;
dovetail_height=20;
dovetail_taper=2;

dovetail_chamfer=1;
dovetail_radius=1;

dovetail_back_width=12;

//dovetail(gender="male", w=dovetail_width, h=dovetail_height, slide=dovetail_slide, taper=dovetail_taper, chamfer=dovetail_chamfer);
//
//right(30)
//dovetail(gender="male", w=dovetail_width, h=dovetail_height, slide=dovetail_slide, taper=dovetail_taper, radius=dovetail_radius, $fn=32);

module my_dovetail(){
dovetail(gender="male", w=dovetail_width, h=dovetail_height, slide=dovetail_slide, taper=dovetail_taper, radius=dovetail_radius, $fn=32);
}


tray_width=170;


// how many dovetails can we fit?
n_dovetails = floor(tray_width/(3*dovetail_width));
dovetail_spacing=tray_width/((n_dovetails*2)+1) ;

echo(n_dovetails);


xcopies(dovetail_spacing, n=n_dovetails) my_dovetail();