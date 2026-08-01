
// Single‑Knife Magnetic Sleeve (hex) — vanilla OpenSCAD
// v1.2S — sleeve “sticks out” from flat backplate, 30° tilt, tapered pocket,
// embedded magnets via top chimneys (sealed by final cap layers).
// Units: millimeters

$fn = 64;

//-----------------------------
// ENVELOPE
//-----------------------------
W = 76;     // overall width of the assembly
H = 180;    // overall height
D = 70;     // overall depth  (back at y=0, front at y=D)

//-----------------------------
// BACKPLATE + MAGNETS
//-----------------------------
bp_w = 48;          // backplate width (centered)
bp_h = H;
bp_t = 6;           // backplate thickness (y)
back_skin = 0.8;    // PETG between magnet and steel

mag_d = 8;          // POWERFIST magnets
mag_t = 4;
mag_clear = 0.2;    // radial clearance in pocket
mag_top_gap = 12;   // center of top row below top edge
mag_row_gap = 40;   // vertical spacing between rows
mag_cols = 2;       // 2 columns (left/right)
mag_top_z = H - mag_top_gap;
mag_bot_z = H - mag_top_gap - mag_row_gap;
// We will pause just BEFORE the cap closes the chimneys; slicer height will be given below.

//-----------------------------
// SLEEVE (taper + tilt)
//-----------------------------
tilt_deg       = 30;     // sleeve axis leans toward user (front +Y)
slot_len       = 150;    // axis length (Z)
slot_z_base    = 28;     // bottom of pocket
mouth_w        = 20;     // entry width
throat_w       = 10;     // inner width at top
sleeve_wall    = 3.0;    // wall thickness of sleeve
sleeve_depthY  = 26;     // sleeve thickness along Y (front/back)
sleeve_setback = bp_t + 8;  // rear of sleeve from back (creates the “stick out” gap)

//-----------------------------
// ARMS (minimal material)
//-----------------------------
arm_t = 6;      // arm thickness along Y
arm_w = 16;     // arm width (X)
arm_h = 8;      // arm height (Z), top/bottom arms

//-----------------------------
// DRAINAGE
//-----------------------------
drip_slots = 2;
drip_w = 8;
drip_h = 7;
drip_y = sleeve_setback + sleeve_depthY - 10; // near front of sleeve
drip_z = 6;

//-----------------------------
// HEX PERFORATION
//-----------------------------
use_hex   = true;  // turn off to print a solid sleeve for a first test
hex_cell  = 10;    // cell spacing
hex_web   = 1.6;   // strut thickness

//-----------------------------
// HELPERS
//-----------------------------
module rect(x,y,z){ cube([x,y,z], center=false); }
module cylz(d,h){ cylinder(d=d, h=h, center=false); }
module cyly(d,h){ rotate([90,0,0]) cylinder(d=d, h=h, center=false); }

// 2D pointy-top hexagon (circumradius r)
module hex2d(r){ polygon(points=[ for (k=[0:5]) [ r*cos(60*k), r*sin(60*k) ] ]); }

// Hex field cutting mask sized [w,h], leaves approx `web` strut between holes
module hex_field_holes(size=[60,120], cell=10, web=1.6){
    r0 = cell/2; r = max(1, r0 - web*0.5);
    hex_h = sqrt(3)*r;
    pitch_x = 1.5*r;  pitch_y = hex_h;
    nx = ceil(size[0]/pitch_x)+2;  ny = ceil(size[1]/pitch_y)+2;

    difference(){
        square(size, center=false);
        for (iy=[0:ny-1]){
            x_off = (iy%2==1) ? pitch_x/2 : 0;
            for (ix=[0:nx-1]){
                x = ix*pitch_x + x_off;
                y = iy*pitch_y;
                if (x>-2*r && x<size[0]+2*r && y>-2*r && y<size[1]+2*r)
                    translate([x,y]) hex2d(r);
            }
        }
    }
}

// Create a tapered, tilted solid by hulling two thin slabs:
// lower (mouth) and upper (throat). Upper is shifted forward by tan(tilt)*length.
module tapered_tilted_block(xc, z0, length, w0, w1, depthY, tilt){
    dy = tan(tilt*PI/180) * length;  // forward shift (+Y)
    hull(){
        translate([xc - w0/2, sleeve_setback,               z0])        rect(w0, depthY, 1.2);
        translate([xc - w1/2, sleeve_setback + dy, z0 + length])        rect(w1, depthY, 1.2);
    }
}

// Sleeve = outer shell minus inner core.
// Then we optionally perforate the front & sides using a hex mask that intersects only the sleeve.
module sleeve_shell(){
    // Outer shell (slightly bigger than inner by sleeve_wall)
    difference(){
        // outer block
        tapered_tilted_block(W/2, slot_z_base, slot_len,
                             mouth_w + 2*sleeve_wall,
                             throat_w + 2*sleeve_wall,
                             sleeve_depthY, tilt_deg);

        // inner cavity
        tapered_tilted_block(W/2, slot_z_base + 0.5, slot_len - 1.0,
                             mouth_w, throat_w,
                             max(2, sleeve_depthY - 2*sleeve_wall),
                             tilt_deg);
    }

    // Hex perforation mask (subtract through-shell, leaving a hex lattice wall)
    if (use_hex){
        panel_w = W - 10;
        panel_h = slot_len + 24;
        translate([ (W - panel_w)/2, sleeve_setback + sleeve_wall, slot_z_base - 12 ])
            difference(){
                rect(panel_w, sleeve_depthY - 2*sleeve_wall, panel_h);
                linear_extrude(height=panel_h, center=false, convexity=10)
                    hex_field_holes([panel_w, panel_h], hex_cell, hex_web);
            }
    }
}

// Flat backplate (no external holes)
module backplate_solid(){
    translate([ (W-bp_w)/2, 0, 0 ]) rect(bp_w, bp_t, bp_h);
}

// Arms linking backplate to sleeve (minimal material)
module arms(){
    // Bottom arm
    translate([ (W-arm_w)/2, bp_t, 6 ])
        rect(arm_w, sleeve_setback - bp_t, arm_h);
    // Top arm
    translate([ (W-arm_w)/2, bp_t, H - arm_h - 6 ])
        rect(arm_w, sleeve_setback - bp_t, arm_h);
}

// Front drip openings (elongated ovals) near sleeve front
module drip_openings(){
    for (i=[0:drip_slots-1]){
        xctr = (W/(drip_slots+1))*(i+1);
        translate([xctr - drip_w/2, drip_y - drip_w/2, drip_z])
            hull(){
                cylz(6, drip_h);
                translate([drip_w, 0, 0]) cylz(6, drip_h);
            }
    }
}

// Internal magnet pockets (horizontal cylinders along Y) + narrow top chimneys
module magnet_pocket_cut(xc, zc){
    // Horizontal seat is fully inside the backplate, just behind the back skin
    translate([xc, back_skin + mag_t/2, zc - mag_t/2])
        cyly(mag_d + mag_clear, mag_t + 0.4);

    // Chimney (narrow) up to just below the top surface so it seals after the pause
    chim_w = max(5, mag_d*0.6);
    chim_t = 2.8;
    chim_h = (H - 0.6) - zc;            // leave ~0.6mm cap at the very top
    if (chim_h > 0.5)
        translate([xc - chim_w/2, back_skin + 0.3, zc]) rect(chim_w, chim_t, chim_h);
}

//-----------------------------
// FINAL ASSEMBLY
//-----------------------------
module knife_holder_single(){
    difference(){
        union(){
            backplate_solid();
            arms();
            sleeve_shell();
        }

        // Drainage
        drip_openings();

        // Magnets: 2 columns × 2 rows (4 magnets total)
        x_l = (W - bp_w)/2 + bp_w*0.30;
        x_r = (W - bp_w)/2 + bp_w*0.70;
        for (xc=[x_l, x_r]){
            magnet_pocket_cut(xc, mag_top_z);
            magnet_pocket_cut(xc, mag_bot_z);
        }
    }
}

knife_holder_single();
