$fn=100;

//% translate([0, 20, 0])
difference() {
  union() {
    // base cylinders for the pipe holders
    for(x_offset=[15, -15]) {
      translate([x_offset, 0, 0]) cylinder(r=8, h=18);
    }
    // structure joining the cylinders together
    difference() {
      rotate([90, 0, 0])
        linear_extrude(height=16, center=true)
          polygon([[15, 0], [15, 18], [5, 10], [-5, 10], [-15, 18],
                   [-15, 0]]);
        wall_thickness = 4;
        translate([-16, -(8-wall_thickness), wall_thickness])
          cube([32, 16-2*wall_thickness, 20]);
      }

    // spring holder
    translate([0, 8+5, 5])
      rotate([90, 90, 90])
        difference() {
          linear_extrude(height=14, center=true)
            union() {
              circle(r=5);
              translate([-5, -6]) square([10, 6]);
            }
          cube([15, 20, 6], center=true);
       }

    // holder for the "patin"
    rotate([180, 0, 0])
      cylinder(h=8.5, r=2.75);
    translate([0, 0, -8.5])
      rotate([180, 0, 0])
        rotate_extrude()
            polygon(points=[[0,0], [3.5,0], [2.50,3], [0,3]]);

  }

  // holes for the spring holder
  translate([0, 8+5, 5])
    rotate([0, 90, 0])
      cylinder(h=30, r=3.2/2, center=true);

  for(x_offset=[-15, 15]) {
    // holes in the pipes
    //translate([x_offset, 0, -1])
    //  cylinder(h=20, r=4);
    translate([x_offset, 0, 2])
      cylinder(h=20, r=6);

    // holes to fix the pipes
    translate([x_offset, -9, 14])
      rotate([-90, 0, 0])
        cylinder(h=18, r=1);
  }
}

