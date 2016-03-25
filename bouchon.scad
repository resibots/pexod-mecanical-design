include <modules.scad>
use <utils.scad>

cap();

//////////
// Modules
//////////

module cap() {
  bearing_caps() {
    difference() {
        cap_base();
        mounting_holes();
    }
  }
}

module cap_base() {
  hull() {
    translate([15, 0, 0]) cylinder(h=2, r=11.25);
    mirror([1, 0, 0]) translate([15, 0, 0]) cylinder(h=2, r=11.25);
  }
}

module bearing_caps() {
  // caps over the pipe holders
  difference () {
    union() {
      translate([15, 0, 1]) cylinder(h=6, r=9.5);
      mirror([1, 0, 0]) translate([15, 0, 1]) cylinder(h=6, r=9.5);
      children();
    }

    // Holes in the cap to let the pipes go through.
    translate([15, 0, -1])
      cylinder(h=9, r=7);
    mirror([1, 0, 0])
      translate([15, 0, -1])
        cylinder(h=9, r=7);
  }
}

// These are the cylinders to dig holes to attach this piece to support_guidages.
module mounting_holes(){
  translate([0, 11.25-wall_thickness/2, -1])
    cylinder(h=9, d=2.7);
  mirror([0, 1, 0])
    translate([0, 11.25-wall_thickness/2, -1])
      cylinder(h=9, d=2.7);
}