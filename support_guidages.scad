// increase number of faces on rounded faces
$fn=50;

holder_thickness = 3;
base_height = 5;
plain_bearing_length = 28;
cap_depth = 5;

union() {
  // pierced base
  difference() {
    union() {
      hull() {
        translate([-22, -13, 0]) cube([44, 26, base_height]);

        translate([15, -26, 0]) cylinder(h=base_height, r=11.25);
        mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=base_height, r=11.25);
      }

      // pipe holders
      translate([15, -26, 0]) cylinder(h=plain_bearing_length+cap_depth+3, r=11.25);
      mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=plain_bearing_length+cap_depth+3, r=11.25);
    }

    // holes in the pipe holders
    translate([15, -26, -10]) cylinder(h=plain_bearing_length+cap_depth+10, r=9.55);
    translate([15, -26, -10]) cylinder(h=plain_bearing_length+20, r=7);
    mirror([1, 0, 0]) {
      translate([15, -26, -10]) cylinder(h=plain_bearing_length+cap_depth+10, r=9.55);
      translate([15, -26, 30]) cylinder(h=plain_bearing_length+20, r=7);
    }

    // four mounting holes
    translate([7.77815, 7.77815, -1]) cylinder(h=10, r=1.25);
    translate([7.77815, -7.77815, -1]) cylinder(h=10, r=1.25);
    translate([-7.77815, 7.77815, -1]) cylinder(h=10, r=1.25);
    translate([-7.77815, -7.77815, -1]) cylinder(h=10, r=1.25);
  }

  // fixture for the spring
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