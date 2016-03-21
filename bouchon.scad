use <modules.scad>

// increase number of faces on rounded faces
$fn=50;

bearing_caps() {
  difference() {
      base();
      mounting_holes();
  }
}

//////////
// Modules
//////////

module base() {
  hull() {
    translate([-22, -13, 0]) cube([44, 26, 2]);

    translate([15, -26, 0]) cylinder(h=2, r=11.25);
    mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=2, r=11.25);
  }
}

module bearing_caps() {
  // caps over the pipe holders
  difference () {
    union() {
      translate([15, -26, 1]) cylinder(h=6, r=9.5);
      mirror([1, 0, 0]) translate([15, -26, 1]) cylinder(h=6, r=9.5);
      children();
    }

    // Holes in the cap to let the pipes go through.
    translate([15, -26, -1])
      cylinder(h=9, r=7);
    mirror([1, 0, 0])
      translate([15, -26, -1])
        cylinder(h=9, r=7);
  }
}