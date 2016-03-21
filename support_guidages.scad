use <modules.scad>

// increase number of faces on rounded faces
$fn=50;

holder_thickness = 3;
base_height = 4;
plain_bearing_length = 28;
cap_depth = 5;

union() {
  bearing_holders(plain_bearing_length, cap_depth)
    base(base_height);

  spring_mounting(holder_thickness, base_height);
}

//////////
// Modules
//////////

// Build the flat base
module base(base_height) {
  difference() {
    hull() {
      translate([-22, -13, 0]) cube([44, 26, base_height]);

      translate([15, -26, 0]) cylinder(h=base_height, r=11.25);
      mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=base_height, r=11.25);
    }

    mounting_holes();
  }
}

// This module adds two hollow cylinders where the bearing will be placed. Since
// the holes in the cylinders have to go through the base, this module has to be
// applied to the complete construction
module bearing_holders(plain_bearing_length, cap_depth) {
  difference () {
    // the two cylinders
    union() {
      translate([15, -26, 0]) cylinder(h=plain_bearing_length+cap_depth+2, r=11.25);
      mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=plain_bearing_length+cap_depth+2, r=11.25);

      // reinforcement
      translate([15+1, -15, base_height-0.25])
        rotate([0, -90, 0])
          linear_extrude(2)
            polygon([[0, 0], [0, 14], [plain_bearing_length+cap_depth+2-base_height, 0]]);
      mirror([1, 0, 0])
      translate([15+1, -15, base_height-0.25])
        rotate([0, -90, 0])
          linear_extrude(2)
            polygon([[0, 0], [0, 14], [plain_bearing_length+cap_depth+2-base_height, 0]]);

      children();
    }
    // holes in the bearing mounting, also going through the base
    translate([15, -26, -10]) cylinder(h=plain_bearing_length+cap_depth+10, r=9.55);
    translate([15, -26, -10]) cylinder(h=plain_bearing_length+20, r=7);
    mirror([1, 0, 0]) {
      translate([15, -26, -10]) cylinder(h=plain_bearing_length+cap_depth+10, r=9.55);
      translate([15, -26, -10]) cylinder(h=plain_bearing_length+20, r=7);
    }
  }
}

// Build a mounting for the spring attached to the foot
module spring_mounting(holder_thickness, base_height) {
  for (x_offset = [-4-holder_thickness/2, 4+holder_thickness/2]) {
    union(){
      translate([x_offset-holder_thickness/2, 0, 5+base_height])
        rotate([0, 90, 0])
          difference() {
            linear_extrude(holder_thickness) {
              union() {
                circle(5);
                translate([0, -5, 0]) square([6, 10]);
              }
            }
            translate([0, 0, -1]) cylinder(d=3.2, h=holder_thickness+2);
          }
    }
  }
}

//translate([0, -40, 0])
