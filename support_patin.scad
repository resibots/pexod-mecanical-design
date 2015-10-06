$fn=100;

//% translate([0, 20, 0])
difference() {
  union() {
    // base cylinders for the pipe holders
    for(x_offset=[15, -15]) {
      translate([x_offset, 0, 0]) cylinder(r=8, h=18);
    }
    // structure joining the cylinders together
    rotate([90, 0, 0])
      linear_extrude(height=16, center=true)
        polygon([[15, 0], [15, 18], [1, 4], [-1, 4], [-15, 18],
                 [-15, 0]]);

    // spring holder
    translate([0, 0, 9])
      rotate([90, 0, 90])
        difference() {
          linear_extrude(height=30, center=true)
            union() {
              circle(r=5);
              translate([-5, -8]) square([10, 8]);
            }
          cube([15, 20, 6], center=true);
       }

    // holder for the "patin"
    rotate([180, 0, 0])
      cylinder(h=8.5, r=2.75);

  }

  // holes for the spring holder
  translate([0, 0, 9])
    rotate([0, 90, 0])
      cylinder(h=30, r=3.2/2, center=true);
  for(x_offset=[-24, 5]) {
    translate([x_offset, 0, 9])
      rotate([0, 90, 0])
        cylinder(h=19, r=3.5);
  }

  for(x_offset=[-15, 15]) {
    // holes in the pipe holders
    //translate([x_offset, 0, -1])
    //  cylinder(h=20, r=4);
    translate([x_offset, 0, 2])
      cylinder(h=20, r=6);

    // holes to fix the holding pipes
    translate([x_offset, -9, 14])
      rotate([-90, 0, 0])
        cylinder(h=18, r=1);
  }
}