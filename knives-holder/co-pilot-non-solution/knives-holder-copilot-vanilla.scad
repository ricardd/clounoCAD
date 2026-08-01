
// Wet-Lab Magnetic Tool Holder — vanilla OpenSCAD version (no BOSL2)
// v0.1S — STL-ready baseline (drain slots; hex lattice to be added in v0.2)
// Author: M365 Copilot for Daniel Ricard
// Units: millimeters

$fn = 64;

// ====== Global Envelope ======
W = 248;  // width  (<=256)
H = 240;  // height (<=256)
D = 90;   // depth

wall = 4; // nominal wall thickness

// ====== Knives ======
knife_tilt_deg = 30;     // toward user
n_large = 2;
n_small = 2;
knife_mouth_w  = 20;     // per your spec
knife_throat_w = 10;     // per your spec
knife_len_large = 180;   // capture along slot axis
knife_len_small = 150;
knife_slot_gap  = 8;
knife_slot_depth = D - 12; // cavity depth
knife_front_skin = 5;      // thin skin so front remains solid

// ====== Scissors ======
n_scissors = 2;
peg_d   = 10;
peg_len = 18;
peg_up_tilt = 5;  // deg upward bias

// ====== Tweezers ======
tweezer_ds = [12,10,8];
tweezer_depth = 55;

// ====== Calipers ======
cal_hook_w = 15;
cal_hook_d = 8;    // seat depth
cal_throat = 2;    // entry throat clearance
cal_standoff = 6;  // from side wall
cal_hook_z = 130;  // seat height
cal_hook_h = 18;   // seat height (thickness)

// ====== Magnets (pause-to-embed) ======
mag_d = 8;      // POWERFIST magnets
mag_t = 4;
mag_clear = 0.2;
mag_back_skin = 0.8; // thin skin to steel
mag_cap_th = 0.6;

mag_cols_top = 5;
mag_cols_bot = 3;
mag_row_gap  = 50;
mag_top_margin_x = 16;
mag_bot_margin_x = 26;

mag_top_z = H - mag_cap_th - mag_t/2;
mag_bot_z = mag_top_z - mag_row_gap;
mag_embed_z_top = H - mag_cap_th; // <-- Pause here in slicer

// ====== Helpers ======
module rect(x,y,z){ translate([0,0,0]) cube([x,y,z], center=false); }
module cyl(d,h){ cylinder(d=d, h=h, center=false); }

// Knife slot cavity: tapered poly extruded and tilted
module knife_slot(len=160, mouth_w=20, throat_w=10, tilt=30, depth=50){
    rotate([tilt,0,0])  // tilt about X (toward +Y/front)
    translate([0,-depth/2,0])
    linear_extrude(height=depth, center=true, convexity=10)
        polygon(points=[
            [-mouth_w/2, 0],
            [ mouth_w/2, 0],
            [ throat_w/2, len],
            [-throat_w/2, len]
        ]);
}

// Scissor peg (simple cylinder), angled up a bit
module scissor_peg(d=10, L=18, up=5){
    rotate([-up,0,0]) cyl(d=d, h=L);
}

// Simple caliper hook: rib + lip + seat subtraction
module caliper_hook(side="left"){
    // side: "left" or "right"
    x = (side=="left") ? 0 : (W - (cal_hook_w+8));
    // Rib
    translate([x, -cal_standoff, 60])
        rect(cal_hook_w+8, cal_standoff, 110);
    // Lip
    translate([x, -cal_standoff-4, cal_hook_z])
        rect(cal_hook_w+8, 4, cal_hook_h);
    // Seat subtraction (cut out)
    difference(){
        // dummy carrier
        translate([x+4, -cal_standoff-4, cal_hook_z-2])
            rect(cal_hook_w, cal_standoff+4, cal_hook_h+4);
        // throat notch (keeps a 2 mm entry)
        translate([x+3.5, -cal_standoff-4, cal_hook_z-2])
            rect(cal_hook_w+1, cal_standoff+4, (cal_hook_h+4)-cal_throat);
    }
}

// Even spacing utility
function linspace(a,b,n) = [ for (i=[0:n-1]) a + (b-a)*(i/(n-1)) ];

// ====== Main Assembly ======
module tool_holder(){
    difference(){
        // --- Solid body ---
        rect(W, D, H);

        // --- Bottom front drip slots (6 rounded slots) ---
        for (i=[0:5]){
            xctr = 20 + i*((W-40)/6);
            translate([xctr-6, 0, 6])
                hull(){
                    translate([0, 0, 0]) cyl(d=6, h=12);
                    translate([12,0,0]) cyl(d=6, h=12);
                }
        }

        // --- Knife slots ---
        x0 = 20;
        y_front = knife_front_skin + 0.01;
        z_base  = 40;

        // 2 large
        for(i=[0:n_large-1]){
            translate([x0 + i*(knife_mouth_w+knife_slot_gap), y_front, z_base])
                knife_slot(len=knife_len_large, mouth_w=knife_mouth_w,
                           throat_w=knife_throat_w, tilt=knife_tilt_deg,
                           depth=knife_slot_depth);
        }

        // 2 small
        x_small0 = x0 + n_large*(knife_mouth_w+knife_slot_gap) + 12;
        for(i=[0:n_small-1]){
            translate([x_small0 + i*(knife_mouth_w+knife_slot_gap), y_front, z_base])
                knife_slot(len=knife_len_small, mouth_w=knife_mouth_w,
                           throat_w=knife_throat_w, tilt=knife_tilt_deg,
                           depth=knife_slot_depth);
        }

        // --- Tweezer wells (open bottom) ---
        tw_x0 = W - 64;
        for (i=[0:len(tweezer_ds)-1]){
            d = tweezer_ds[i];
            translate([tw_x0 + i*20, 8, 0]) cyl(d=d, h=tweezer_depth+20);
        }

        // --- Magnet pockets (open until cap) ---
        // Top row (5)
        xs_top = linspace(mag_top_margin_x, W - mag_top_margin_x, mag_cols_top);
        for (xpos = xs_top){
            translate([xpos, D - (mag_back_skin + mag_t/2), mag_top_z - mag_t/2])
                cylinder(d=mag_d + mag_clear, h=mag_t+0.02, center=false);
        }
        // Bottom row (3)
        xs_bot = linspace(mag_bot_margin_x, W - mag_bot_margin_x, mag_cols_bot);
        for (xpos = xs_bot){
            translate([xpos, D - (mag_back_skin + mag_t/2), mag_bot_z - mag_t/2])
                cylinder(d=mag_d + mag_clear, h=mag_t+0.02, center=false);
        }
    }

    // --- Scissor pegs on front face ---
    peg_span = 90;
    peg_z = 160;
    peg_x0 = (W - peg_span)/2;
    for (i=[0:n_scissors-1]){
        translate([peg_x0 + i*(peg_span/max(1,(n_scissors-1))), wall+0.2, peg_z])
            scissor_peg(d=peg_d, L=peg_len, up=peg_up_tilt);
    }

    // --- Caliper hooks (side add-ons) ---
    caliper_hook("left");
    caliper_hook("right");
}

tool_holder();

