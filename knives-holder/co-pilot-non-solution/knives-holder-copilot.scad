
// Wet-Lab Magnetic Tool Holder (parametric, BOSL2)
// Draft v0.1 — 256³ build volume safe
// Author: M365 Copilot for Daniel Ricard
// Units: millimeters

include <BOSL2/std.scad>;
include <BOSL2/rounding.scad>;
$fn = 64;

//====================
// Global Parameters
//====================
W = 248;               // overall width (<=256)
H = 240;               // overall height
D = 90;                // overall depth

wall = 4;              // nominal wall thickness
fillet_r = 3;          // outer corner fillet radius
front_chamfer = 2;     // small top/front edge chamfer for wipe-down

//--------------- Knives ---------------
knife_tilt_deg = 30;   // tilt toward user
n_large = 2;
n_small = 2;
knife_mouth_w   = 20;  // <-- user request
knife_throat_w  = 10;  // <-- user request
knife_len_large = 180; // capture length along the slot axis
knife_len_small = 150;
knife_slot_gap  = 8;   // spacing between adjacent knife channels
knife_slot_depth = D - 12; // how deep the channel cuts into the body (front-to-back)
knife_slot_margin_front = 5; // keep small skin in front of lattice

// Lattice (front vent on knife channels)
pattern = "hex";       // "hex" | "solid" (Voronoi in later rev)
hex_cell = 12;         // hexagon cell diameter
hex_web  = 1.6;        // strut thickness for PETG bridging

//--------------- Scissors ---------------
n_scissors = 2;
peg_d      = 10;       // hanging peg diameter
peg_len    = 18;       // projection from face
peg_up_tilt = 5;       // deg upward to resist bounce

//--------------- Tweezers ---------------
n_tweezers = 3;
tweezer_ds = [12,10,8];
tweezer_depth = 55;
tweezer_front_sc = 6;  // scallop height on the front face

//--------------- Calipers ---------------
cal_hook_w = 15;       // jaw seat width
cal_hook_d = 8;        // jaw seat depth
cal_throat = 2;        // entry throat clearance
cal_standoff = 6;      // standoff from side wall for drainage
cal_open_bottom = 40;  // how far caliper can extend below body

//--------------- Magnets (pause-to-embed) ---------------
mag_d = 8;             // POWERFIST default
mag_t = 4;
mag_clear = 0.2;       // radial clearance for press-fit
mag_back_skin = 0.8;   // thin PETG between magnet and steel wall
mag_cap_th = 0.6;      // top cap thickness (printed after pause)
mag_rows = 2;          // keep at 2 (top-heavy layout)
mag_cols_top = 5;      // 5 magnets on top row
mag_cols_bot = 3;      // 3 magnets on bottom row
mag_top_margin_x = 16; // lateral margin on top row
mag_bot_margin_x = 26; // lateral margin on bottom row
mag_row_gap = 50;      // vertical spacing between rows
mag_top_z = H - mag_cap_th - mag_t/2; // center Z for top row (open until cap prints)
mag_bot_z = mag_top_z - mag_row_gap;

// Derived: pause height for embedding (Bambu Studio "Pause at height")
mag_embed_z_top = H - mag_cap_th;     // just before cap layers start

//====================
// Utility Modules
//====================

// Top-level body with gentle outer fillets
module body_outer() {
    // BOSL2 cuboid with rounding; anchor back-left-bottom for easy placement
    cuboid([W, D, H], rounding=fillet_r, edges=EDGES_ALL,
           anchor=BACK+LEFT+BOT);
}

// Hex lattice cutout panel (through-holes)
module hex_panel(w=60, h=160, t=D-2*wall, cell=hex_cell, web=hex_web) {
    // create a panel of hex holes by differencing an extruded rectangle
    difference() {
        cuboid([w, t, h], anchor=BACK+LEFT+BOT);
        // hex grid built as a 2D region and linear_extruded through panel
        // Use BOSL2 grid of hexagons
        translate([0, 0, 0]) {
            linear_extrude(height=t+0.2, center=false, convexity=10)
                hexagon_grid(size=[w, h], dia=cell, wall=web, anchor=LEFT+BOT);
        }
    }
}

// Knife slot cavity (angled), rectangular taper from mouth -> throat
module knife_slot(len=160, mouth_w=20, throat_w=10, tilt=30, depth=knife_slot_depth) {
    // Build a tapered 3D cavity along Z (slot axis), then rotate to tilt
    // The slot is extruded in Y (depth) and tapered in X
    path_l = len;
    difference() {
        // Main tapered prism
        rotate([tilt,0,0])  // tilt around X so the slot axis leans toward user (front)
            translate([0, -depth/2, 0])
                linear_extrude(height=depth, center=true)
                    polygon(points=[
                        [ -mouth_w/2, 0],
                        [  mouth_w/2, 0],
                        [  throat_w/2, path_l],
                        [ -throat_w/2, path_l]
                    ]);
        // Slight rounding at mouth: add small fillets by overcut
    }
}

// Simple cylindrical well (tweezer/forceps)
module well(d=10, h=60) {
    // Fully open bottom (we'll place it to pass through bottom face)
    cylinder(d=d, h=h, center=false);
}

// Scissor peg (hang by finger ring)
module scissor_peg(d=10, L=18, up_tilt=5) {
    rotate([ -up_tilt, 0, 0 ])
        cyl(d=d, h=L, anchor=BOT, rounding=1);
}

// Caliper jaw hook on side face; a "J" shaped seat + standoff rib
module caliper_hook(side="left") {
    // side: "left" or "right" — mounted on outer side walls
    mirrorx = (side=="right") ? 1 : 0;
    mirror([mirrorx,0,0]) {
        // hook body (solid) to be unioned to the side, with inner seat subtracted
        translate([0, 0, 0]) {
            // add-on block
            union() {
                // Main rib
                translate([0, -cal_standoff, 60])
                    cuboid([cal_hook_w+8, cal_standoff, 110], anchor=BACK+LEFT+BOT, rounding=2);
                // Upper lip forming the seat
                translate([0, -cal_standoff-4, 130])
                    cuboid([cal_hook_w+8, 4, 18], anchor=BACK+LEFT+BOT, rounding=1);
            }
            // Subtract seat area
            translate([4, -cal_standoff-0.01, 128])
                difference() {
                    cuboid([cal_hook_w, cal_standoff+4, 16], anchor=BACK+LEFT+BOT, rounding=1);
                    // throat notch
                    translate([-0.5, 0, 0])
                        cuboid([cal_hook_w+1, cal_standoff+4, 16 - cal_throat], anchor=BACK+LEFT+TOP);
                }
        }
    }
}

// Generate evenly-spaced X positions
function linspace(a,b,n) = [ for (i=[0:n-1]) a + (b-a)*(i/(n-1)) ];

// Magnet pockets (cylinders) placed near the back face, with thin rear skin
module magnet_pockets() {
    // Top row (more magnets)
    xs_top = linspace(mag_top_margin_x, W - mag_top_margin_x, mag_cols_top);
    xs_bot = linspace(mag_bot_margin_x, W - mag_bot_margin_x, mag_cols_bot);
    for (xpos = xs_top) {
        translate([xpos, D - (mag_back_skin + mag_t/2), mag_top_z])
            cylinder(d=mag_d + mag_clear, h=mag_t+0.02, center=true);
    }
    for (xpos = xs_bot) {
        translate([xpos, D - (mag_back_skin + mag_t/2), mag_bot_z])
            cylinder(d=mag_d + mag_clear, h=mag_t+0.02, center=true);
    }
}

//====================
// Assembly
//====================
module tool_holder() {
    difference() {
        // --- Outer body ---
        body_outer();

        // --- Bottom drip slots (front edge) ---
        // 6× slots 6x12 mm rounded
        for (i=[0:5]) {
            translate([20 + i*( (W-40)/6 ), 2, 8])
                rotate([0,90,0])
                    hull() {
                        translate([-3,0,0]) cylinder(d=6, h=12, center=true);
                        translate([ 3,0,0]) cylinder(d=6, h=12, center=true);
                    }
        }

        // --- Knife slots (left cluster large, then small) ---
        x0 = 20;
        y_front = knife_slot_margin_front + 0.01;
        z_base = 40;

        // Large knives (2)
        for (i=[0:n_large-1]) {
            translate([x0 + i*(knife_mouth_w + knife_slot_gap), y_front, z_base])
                knife_slot(len=knife_len_large, mouth_w=knife_mouth_w, throat_w=knife_throat_w,
                           tilt=knife_tilt_deg, depth=knife_slot_depth);
        }

        // Small knives (2)
        x_small0 = x0 + n_large*(knife_mouth_w + knife_slot_gap) + 12;
        for (i=[0:n_small-1]) {
            translate([x_small0 + i*(knife_mouth_w + knife_slot_gap), y_front, z_base])
                knife_slot(len=knife_len_small, mouth_w=knife_mouth_w, throat_w=knife_throat_w,
                           tilt=knife_tilt_deg, depth=knife_slot_depth);
        }

        // --- Front lattice panels over knife area (through-holes) ---
        if (pattern=="hex") {
            // One wider panel spanning all knife slots
            panel_w = (x_small0 + (n_small)*(knife_mouth_w + knife_slot_gap) - x0) + 10;
            translate([x0-5, wall, z_base])
                hex_panel(w=panel_w, h=max(knife_len_large, knife_len_small)+20,
                          t=D - 2*wall, cell=hex_cell, web=hex_web);
        }

        // --- Tweezer wells (3) ---
        tw_x0 = W - 60;
        for (i=[0:n_tweezers-1]) {
            d = (i < len(tweezer_ds)) ? tweezer_ds[i] : 10;
            translate([tw_x0 + i*18, wall+6, 16])
                well(d=d, h=tweezer_depth + 16); // extend down to open bottom
        }

        // --- Magnet pockets (pause-to-embed) ---
        magnet_pockets();
    }

    // --- Scissor pegs (positive features on face) ---
    peg_span = 80;
    peg_z = 150;
    peg_x0 = (W - peg_span)/2;
    for (i=[0:n_scissors-1]) {
        translate([peg_x0 + i*(peg_span/(max(1,n_scissors-1))), wall+0.1, peg_z])
            scissor_peg(d=peg_d, L=peg_len, up_tilt=peg_up_tilt);
    }

    // --- Caliper hooks on both sides ---
    // Left side
    translate([0, 0, 0]) caliper_hook("left");
    // Right side
    translate([W - (cal_hook_w+8), 0, 0]) caliper_hook("right");

    // --- Small front chamfer at top for wipe-down ---
    // (visual only; the rounded cuboid already smooths edges)
}

// Build it
tool_holder();

// Helpful console output for pause heights and checks
echo("=== EMBED MAGNETS ===");
echo(str("Pause at Z (mm): ", mag_embed_z_top));
echo(str("Top magnet center Z (mm): ", mag_top_z, "  Bottom magnet center Z (mm): ", mag_bot_z));
echo(str("Knife mouth/throat (mm): ", knife_mouth_w, " -> ", knife_throat_w));


// ----------------------
// Hex Lattice Utilities
// ----------------------

// 2D pointy-top hexagon centered at [0,0] with circumradius r.
// (Circumradius r yields width=2r; height=sqrt(3)*r)
module hex2d(r) {
    polygon(points=[ for (k=[0:5]) [ r*cos(60*k), r*sin(60*k) ] ]);
}

// Lay down a field of hexagon HOLES sized to achieve roughly the given 'web'
// between neighboring holes. This is an approximation because the true web
// depends on both pitch and hex geometry, but it is stable and printable.
//
// cell  = nominal across-flats target spacing (controls density)
// web   = approximate strut thickness between holes
// size  = [width, height] of the rectangular field to cover
module hex_field_holes(size=[100,100], cell=12, web=1.6) {
    // We build a pointy-top hex grid.
    // Choose a circumradius r so that the minimum strut between neighbors is ~web.
    // Start with r from desired "cell" then subtract half the web to widen struts.
    r0 = cell/2;
    r  = max(1, r0 - web*0.5);

    hex_w = 2*r;                // width of hex
    hex_h = sqrt(3)*r;          // height of hex
    pitch_x = 1.5*r;            // horizontal step for pointy-top grid
    pitch_y = hex_h;            // vertical step

    nx = ceil(size[0]/pitch_x)+2;
    ny = ceil(size[1]/pitch_y)+2;

    // Cut holes within the requested field
    difference() {
        // carrier is a thin plate only to bound the 2D difference;
        // the caller extrudes it, so here we just provide the area.
        square(size, center=false);

        // Hex holes
        for (iy = [0:ny-1]) {
            x_off = (iy%2==1) ? pitch_x/2 : 0;
            for (ix = [0:nx-1]) {
                x = ix*pitch_x + x_off;
                y = iy*pitch_y;
                if (x > -hex_w && x < size[0]+hex_w && y > -hex_h && y < size[1]+hex_h)
                    translate([x, y]) hex2d(r);
            }
        }
    }
}

// Through‑hex lattice panel: subtracts hex holes from a solid panel.
// w,h = face dimensions; t = thickness (extrusion) along Y by default.
module hex_panel(w=60, h=160, t=10, cell=12, web=1.6) {
    difference() {
        // Solid panel
        cuboid([w, t, h], anchor=BACK+LEFT+BOT);
        // Hex field cut all the way through panel thickness
        translate([0, -0.1, 0])  // slight overshoot to avoid z-fighting
            linear_extrude(height=t+0.2, center=false, convexity=10)
                hex_field_holes(size=[w, h], cell=cell, web=web);
    }
}

