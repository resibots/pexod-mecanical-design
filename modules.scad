$fn=10;

holder_thickness = 3;
wall_thickness = 4;
plain_bearing_length = 28;
cap_depth = 5;

// Builds a module to attach to a dynamixel actuator
// @param branch_thickness thickness of the part
// @param distance between base and motor's center
// @param margin margin on center hole's diameter (adjust for 3D printing
//  inaccuracies)
module dynamixel_frame(branch_thickness, length, margin = 0) {
  width = 22;
  difference() {
    cube([width, length+2, branch_thickness]);

    // cylindrical hole
    translate([width/2, length, -1])
      cylinder(h=branch_thickness+2, d=8+margin);
    // opening of the hole
    translate([width/2-(8+margin)/2, length, -1])
      cube([8+margin, 8, branch_thickness+2]);

    // round cornerd
    rounding_radius = 2;
    translate([width, length+2, branch_thickness/2])
      custom_corner_rounder(rounding_radius, branch_thickness+2, rounding_radius+5, rounding_radius+5);
    translate([(width+8+margin)/2, length+2, branch_thickness/2])
      rotate([0, 0, 90])
        custom_corner_rounder(rounding_radius, branch_thickness+2, rounding_radius+5, rounding_radius+5);

    translate([0, length+2, branch_thickness/2])
      rotate([0, 0, 90])
        custom_corner_rounder(rounding_radius, branch_thickness+2, rounding_radius+5, rounding_radius+5);
    translate([(width-8-margin)/2, length+2, branch_thickness/2])
      custom_corner_rounder(rounding_radius, branch_thickness+2, rounding_radius+5, rounding_radius+5);

    screw_radius = 8;
    translate([width/2, length, 0])
      for (angle=[180:45:360]) {
        translate([screw_radius*cos(angle), screw_radius*sin(angle), -1])
          cylinder(h=branch_thickness+2, d=2);
      }
  }
}

// Create a model of an optoforce sensor, including a part of its cable
module optoforce() {
  difference() {
    union() {
      // Base
      color("grey")
        cylinder(h=5, d=22);

      // Active surface
      color("black")
        translate([0, 0, 5])
          intersection() {
            translate([-12, -12, 0])
              cube([24, 24, 20]);
            sphere(10);
          }

      // Cable
      color([0.2, 0.2, 0.2])
        translate([0, 0, 2.35])
          rotate([-90, 0, 0])
            cylinder(h=50, d=2.7);
    }

    // Holes
    r_distribution = 9.5;
    rotate([0, 0, 90])
      for (angle=[-17.5, 17.5, 90, 180, 270]) {
        translate([r_distribution*cos(angle), r_distribution*sin(angle), -1])
          cylinder(h=3, d=2);
      }
  }
}

/** Build one half of a cable holder for the Optoforce sensor.

    This device is intended to be paired with a copy of itself, with the opening
    facing the opposite direction. The distance between the two halves has to be
    at least one diameter of the cable.

    @param thickness
    @param radius radius of the circular hollow space
    @param y_shift how much the circle (which radius is the former parameter) is
      shifted downwards
**/
module half_cable_holder(thickness=2, radius=2, y_shift=0.5) {
  x_shift = sqrt(pow(radius, 2) - pow(y_shift, 2));

  linear_extrude(thickness)
    difference() {
      // basic shape
      square([9, 6]);

      // Opening
      translate([4.5-x_shift, 0-1])
        square([6+x_shift+1, 3+1]);

      // Circular hole
      translate([3+1.5, 3])
        intersection() {
          translate([0, -y_shift])
            circle(radius);
          translate([-radius, 0])
            square([2*radius, 2*radius]);
        }
    }
}

module cable_holder() {
  translate([-4.5, 0, 2])
    half_cable_holder();
  translate([9-4.5, 0, -2])
    rotate([0, 180, 0])
      half_cable_holder();
}