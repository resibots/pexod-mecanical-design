
// This makes a holow part useful to make rounded corners. Better than a long
// description, play with the parameters to see how you can use it for your parts.
module corner_rounder(radius, height) {
  difference() {
    translate([-radius/2, -radius/2, 0])
    cube([radius, radius, height], center=true);
    translate([-radius, -radius, 0])
      cylinder(h=height+2, r=radius, center=true);
  }
}

// These are the cylinders to dig holes in support_guidage and bouchon, to attach
// them together.
module mounting_holes(){
  // four mounting holes
  translate([7.77815, 7.77815, -1]) cylinder(h=10, r=1.25);
  translate([7.77815, -7.77815, -1]) cylinder(h=10, r=1.25);
  translate([-7.77815, 7.77815, -1]) cylinder(h=10, r=1.25);
  translate([-7.77815, -7.77815, -1]) cylinder(h=10, r=1.25);
  // a fith mounting hole between the two pipe holders
  translate([0, -26-11.25+3.78, -1]) cylinder(h=10, r=1.25);
}

// Builds a module to attach to a dynamixel actuator
// @param branch_thickness thickness of the part
// @param distance between base and motor's center
// @param margin margin on center hole's diameter (adjust for 3D printing
//  inaccuracies)
module actuator_attachment(branch_thickness, length, margin = 0) {
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
      corner_rounder(rounding_radius, branch_thickness);
    translate([(width+8+margin)/2, length+2, branch_thickness/2])
      rotate([0, 0, 90])
        corner_rounder(rounding_radius, branch_thickness);

    translate([0, length+2, branch_thickness/2])
      rotate([0, 0, 90])
        corner_rounder(rounding_radius, branch_thickness);
    translate([(width-8-margin)/2, length+2, branch_thickness/2])
      corner_rounder(rounding_radius, branch_thickness);

    screw_radius = 8;
    translate([width/2, length, 0])
      for (angle=[180:45:360]) {
        translate([screw_radius*cos(angle), screw_radius*sin(angle), -1])
          cylinder(h=branch_thickness+2, d=2);
      }
  }
}