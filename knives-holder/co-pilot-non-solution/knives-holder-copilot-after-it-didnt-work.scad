
//
// Wet‑Lab Magnetic Tool Holder — vanilla OpenSCAD (no external libraries)
// v0.2S — matches agreed design; STL-ready
// Author: M365 Copilot for Daniel Ricard
// Units: millimeters
//

$fn = 64;

//----------------------
// Global Envelope
//----------------------
W = 248;    // width  (<= 256)
H = 240;    // height (<= 256)
D = 90;     // depth

wall = 4;   // nominal wall (kept as reference; body is monolithic for robustness)

//----------------------
// User‑tuned parameters
//----------------------

// Knives (angled & tapered)
knife_tilt_deg   = 30;      // toward user
knife_mouth_w    = 20;      // mouth width at entry
knife_throat_w   = 10;      // throat width deeper in slot
knife_len_large  = 180;     // capture length along slot axis
knife_len_small  = 150;
knife_slot_gap   = 8;       // spacing between slots
knife_front_skin = 5;       // front face skin before cavity starts
knife_slot_depth = D - 12;  // Y depth of the cavity
z_base           = 40;      // slot base elevation
n_large          = 2;
n_small          = 2;

// Scissors (pegs)
n_scissors   = 2;
peg_d        = 10;
peg_len      = 18;
peg_up_tilt  = 5;   // deg
peg_span     = 90;  // spread between pegs
peg_z        = 160; // height

// Tweezers (open-bottom wells)
tweezer_ds = [12,10,8];
tweezer_y  = 8;
tweezer_h  = 75;   // ensures through-bottom

// Calipers (vertical hooks, one per side)
cal_hook_w     = 15;
cal_standoff   = 6;    // rib thickness from side wall
cal_hook_z     = 130;  // seat height
cal_hook_h     = 18;   // seat lip height

// Magnets: 8 pockets (5 top + 3 bottom), top‑heavy layout
mag_d          = 8;   // POWERFIST 8×4 mm
mag_t          = 4;
mag_clear      = 0.2; // radial clearance
mag_back_skin  = 0.8; // thin PETG between magnet and steel
mag_cap_th     = 0.6; // printed after pause to seal pockets

mag_cols_top   = 5;
mag_cols_bot   = 3;
mag_row_gap    = 50;
mag_top_margin_x = 16;
mag_bot_margin_x = 26;

mag_top_z = H - mag_cap_th - mag_t/2;
mag_bot_z = mag_top_z - mag_row_gap;
mag_pause_z = H - mag_cap_th; // <-- Add slicer Pause at this Z, drop magnets, resume to cap

//----------------------
// Helper primitives
//----------------------
module rect(x,y,z){ cube([x,y,z], center=false); }
module cylz(d,h){ cylinder(d=d, h=h, center=false); }
module cyly(d,h){ rotate([90,0,0]) cylinder(d=d, h=h, center=false); }

// Tapered knife slot (cavity): linear_extrude polygon, then rotate to tilt
module knife_slot(len=160, mouth_w=20, throat_w=10, tilt=30, depth=40){
    rotate([tilt,0,0])  // tilt about X (mouth toward +Y/front)
    translate([0,-depth/2,0])
    linear_extrude(height=depth, center=true, convexity=10)
        polygon(points=[
            [-mouth_w/2, 0],
            [ mouth_w/2, 0],
            [ throat_w/2, len],
            [-throat_w/2, len]
        ]);
}

// Caliper hook block (positive feature) on a given side
module caliper_hook(side="left"){
    // side = "left" or "right"
    x = (side=="left") ? 0 : (W - (cal_hook_w+8));
    // Rib
    translate([x, -cal_standoff, 60])
        rect(cal_hook_w+8, cal_standoff, 110);
    // Lip (small top ledge)
    translate([x, -cal_standoff-4, cal_hook_z])
        rect(cal_hook_w+8, 4, cal_hook_h);
}

// Scissor peg (positive)
module scissor_peg(d=10, L=18, up=5){
    rotate([-up,0,0]) cyly(d, L);
}

//----------------------
// Assembly
//----------------------
module tool_holder(){
    difference(){
        // --- Solid body ---
        rect(W, D, H);

        // --- Front bottom drip slots (6 rounded slots) ---
        for (i=[0:5]){
            xctr = 20 + i*((W-40)/6);
            translate([xctr-6, 0, 2])
                hull(){
                    translate([0,0,0])  cylz(6, 8);
                    translate([12,0,0]) cylz(6, 8);
                }
        }

        // --- Knife slots: 2 large + 2 small, all tilted 30° ---
        x0 = 20;
        y_front = knife_front_skin + 0.01;
        // Large
        for (i=[0:n_large-1]){
            translate([x0 + i*(knife_mouth_w + knife_slot_gap), y_front, z_base])
                knife_slot(len=knife_len_large, mouth_w=knife_mouth_w,
                           throat_w=knife_throat_w, tilt=knife_tilt_deg,
                           depth=knife_slot_depth);
        }
        // Small
        x_small0 = x0 + n_large*(knife_mouth_w + knife_slot_gap) + 12;
        for (i=[0:n_small-1]){
            translate([x_small0 + i*(knife_mouth_w + knife_slot_gap), y_front, z_base])
                knife_slot(len=knife_len_small, mouth_w=knife_mouth_w,
                           throat_w=knife_throat_w, tilt=knife_tilt_deg,
                           depth=knife_slot_depth);
        }

        // --- Tweezer wells (3) open-bottom ---
        tw_x0 = W - 64;
        for (i=[0:len(tweezer_ds)-1]){
            d = tweezer_ds[i];
            translate([tw_x0 + i*20, tweezer_y, -5]) cylz(d, tweezer_h+20);
        }

        // --- Magnet pockets (8) — horizontal cylinders near back ---
        // Top row (5)
        for (i=[0:mag_cols_top-1]){
            xpos = mag_top_margin_x + ( (W - 2*mag_top_margin_x) * ( (mag_cols_top==1)? 0.5 : i/(mag_cols_top-1) ) );
            translate([xpos, D - (mag_back_skin + mag_t/2), mag_top_z - mag_t/2])
                rotate([90,0,0]) cylinder(d=mag_d + mag_clear, h=mag_t+0.4, center=false);
        }
        // Bottom row (3)
        for (i=[0:mag_cols_bot-1]){
            xpos = mag_bot_margin_x + ( (W - 2*mag_bot_margin_x) * ( (mag_cols_bot==1)? 0.5 : i/(mag_cols_bot-1) ) );
            translate([xpos, D - (mag_back_skin + mag_t/2), mag_bot_z - mag_t/2])
                rotate([90,0,0]) cylinder(d=mag_d + mag_clear, h=mag_t+0.4, center=false);
        }
    }

    // --- Scissor pegs (2) on front face ---
    peg_x0 = (W - peg_span)/2;
    for (i=[0:n_scissors-1]){
        translate([peg_x0 + i*( (n_scissors==1)? 0 : peg_span/(n_scissors-1) ), wall+0.2, peg_z])
            scissor_peg(peg_d, peg_len, peg_up_tilt);
    }

    // --- Caliper hooks (positive) on both sides ---
    caliper_hook("left");
    caliper_hook("right");
}

tool_holder();

