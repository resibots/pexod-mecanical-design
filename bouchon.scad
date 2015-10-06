// increase number of faces on rounded faces
$fn=50;

difference() {
  union() {
    difference() {
      hull() {
        translate([-22, -13, 0]) cube([44, 26, 2]);

        translate([15, -26, 0]) cylinder(h=2, r=11.25);
        mirror([1, 0, 0]) translate([15, -26, 0]) cylinder(h=2, r=11.25);
      }


      // four mounting holes
      translate([7.77815, 7.77815, -1]) cylinder(h=5, r=1.25);
      translate([7.77815, -7.77815, -1]) cylinder(h=5, r=1.25);
      translate([-7.77815, 7.77815, -1]) cylinder(h=5, r=1.25);
      translate([-7.77815, -7.77815, -1]) cylinder(h=5, r=1.25);
    }

    // caps over the pipe holders
    translate([15, -26, 1]) cylinder(h=6, r=9.5);
    mirror([1, 0, 0]) translate([15, -26, 1]) cylinder(h=6, r=9.5);
  }

  translate([15, -26, -1])
    cylinder(h=9, r=7);
  mirror([1, 0, 0])
    translate([15, -26, -1])
      cylinder(h=9, r=7);
}