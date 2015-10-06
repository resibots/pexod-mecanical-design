// increase number of faces on rounded faces
$fn=50;

holder_thickness = 3;

union() {
  // pierced base
  difference() {
    union() {
      hull() {
        translate([-22, -13, 0]) cube([44, 26, 8]);

        translate([15, -26, 0]) cylinder(h=8, r=11.25);
        mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=8, r=11.25);
      }

      // pipe holders
      translate([15, -26, 0]) cylinder(h=35.8, r=11.25);
      mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=35.8, r=11.25);
    }

    // four mounting holes
    translate([7.77815, 7.77815, -1]) cylinder(h=10, r=1.25);
    translate([7.77815, -7.77815, -1]) cylinder(h=10, r=1.25);
    translate([-7.77815, 7.77815, -1]) cylinder(h=10, r=1.25);
    translate([-7.77815, -7.77815, -1]) cylinder(h=10, r=1.25);

    // holes in the pipe holders
    translate([15, -26, -10]) cylinder(h=42.8, r=9.55);
    translate([15, -26, 30]) cylinder(h=10, r=7);
    mirror([1, 0, 0]) {
      translate([15, -26, -10]) cylinder(h=42.8, r=9.55);
      translate([15, -26, 30]) cylinder(h=10, r=7);
    }

  }

  // fixture for the springs
  for (x_offset = [-4-holder_thickness/2, 4+holder_thickness]) {
    union(){
      translate([x_offset-holder_thickness/2, 0, 5+8])
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