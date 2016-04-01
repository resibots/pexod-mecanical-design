include <settings.scad>
use <modules.scad>
use <utils.scad>

support_guidages();

//////////
// Modules
//////////

module support_guidages() {
  difference() {
    union() {
      bearing_holders(plain_bearing_length, cap_depth)
        union() {
          base(wall_thickness, cap_depth, true);

          dynamixel_frames(branch_length = 27);
        }

      translate([0, -11.25-4, 4+24])
        rotate([90, 0, 0])
        spring_mounting(holder_thickness, base_length = 2, extra_length=6);
    }

    nut_holes(wall_thickness, nut_margin = 0.01);
  }
}

// Build the flat base
module base(wall_thickness, cap_depth, hollow=false) {
  if (!hollow) {
    translate([-15, -11.25, 0])
      cube([30, 2*11.25, wall_thickness]);
  }

  translate([-15, -11.25, 0])
    cube([30, wall_thickness, plain_bearing_length + cap_depth + 2]);
  translate([-15, 11.25-wall_thickness, 0])
    cube([30, wall_thickness, plain_bearing_length + cap_depth + 2]);
}

// This module adds two hollow cylinders where the bearing will be placed. Since
// the holes in the cylinders have to go through the base, this module has to be
// applied to the complete construction
module bearing_holders(plain_bearing_length, cap_depth) {
  difference () {
    // the two cylinders
    union() {
      translate([15, 0, 0]) cylinder(h=plain_bearing_length+cap_depth+2, r=11.25);
      mirror([1, 0, 0]) translate([15, 0, 0]) cylinder(h=plain_bearing_length+cap_depth+2, r=11.25);

      children();
    }
    // holes in the bearing mounting, also going through the base
    translate([15, 0, -10]) cylinder(h=plain_bearing_length+cap_depth+10, r=9.55);
    translate([15, 0, -10]) cylinder(h=plain_bearing_length+20, r=7);
    mirror([1, 0, 0]) {
      translate([15, 0, -10]) cylinder(h=plain_bearing_length+cap_depth+10, r=9.55);
      translate([15, 0, -10]) cylinder(h=plain_bearing_length+20, r=7);
    }
  }
}

module nut_holes(wall_thickness, nut_width = 4.95, nut_height = 2, nut_margin = 0.1) {
  nut_diameter = 2/sqrt(3)*nut_width;
  translate([0, 11.25-wall_thickness/2, 4]){
    cylinder(h=nut_height, d=nut_diameter + nut_margin, $fn=6);
    translate([-(nut_diameter+nut_margin)/2, 0, 0])
      cube([nut_diameter+nut_margin, nut_width/2+nut_margin/2, nut_height]);
  }
  mirror([0, 1, 0])
  translate([0, 11.25-wall_thickness/2, 4]){
    cylinder(h=nut_height, d=nut_diameter + nut_margin, $fn=6);
    translate([-(nut_diameter+nut_margin)/2, 0, 0])
      cube([nut_diameter+nut_margin, nut_width/2+nut_margin/2, nut_height]);
  }

  translate([0, 11.25-wall_thickness/2, -1])
    cylinder(h=9, d=2.7);
  mirror([0, 1, 0])
    translate([0, 11.25-wall_thickness/2, -1])
      cylinder(h=9, d=2.7);
}

// Attachment to the actuator
module dynamixel_frames(branch_thickness = 2.5, branch_length = 32,
    actuator_margin = 0, attachment_separation = 41, cylinder_compensation = 5) {
  // The two branches
  translate([-attachment_separation/2, 11.25-cylinder_compensation, 0])
    rotate([0, -90, 0])
      dynamixel_frame(branch_thickness, branch_length+cylinder_compensation, actuator_margin);
  mirror([1, 0, 0])
    translate([-attachment_separation/2, 11.25-cylinder_compensation, 0])
      rotate([0, -90, 0])
        dynamixel_frame(branch_thickness, branch_length+cylinder_compensation, actuator_margin);

  // Reinforcements
  cap_depth = 5;
  plain_bearing_length = 28;
  translate([-attachment_separation/2, 11.25-cylinder_compensation, 22])
  rotate([0, -90, 0])
  linear_extrude(branch_thickness)
    polygon([
    [0, 0],
    [plain_bearing_length+cap_depth+2 - 22, 0],
    [0, branch_length+cylinder_compensation]
    ]);
  mirror([1, 0, 0])
    translate([-attachment_separation/2, 11.25-cylinder_compensation, 22])
      rotate([0, -90, 0])
        linear_extrude(branch_thickness)
          polygon([
          [0, 0],
          [plain_bearing_length+cap_depth+2 - 22, 0],
          [0, branch_length+cylinder_compensation]
          ]);

  // Filet on the insides (second reinforcments)
  length = 30;
  translate([-attachment_separation/2, 11.25, length/2])
    rotate([0, 0, -180])
      custom_corner_rounder(5, length, 5, 5+3);
  mirror([1, 0, 0])
    translate([-attachment_separation/2, 11.25, length/2])
      rotate([0, 0, -180])
        custom_corner_rounder(5, length, 5, 5+3);
}

// Build a mounting for the spring attached to the foot
//
// @param thickness width of each half of the mounting
// @param extra_length you need to experiment with this to understand it
module spring_mounting(thickness, base_length=0, extra_length=2) {
  ext_r = 4;
  for (x_offset = [-4-thickness/2, 4+thickness/2]) {
    translate([x_offset-thickness/2, 0, 5])
      rotate([0, 90, 0])
        difference() {
          linear_extrude(thickness) {
            union() {
              circle(ext_r);
              translate([0, -ext_r, 0]) polygon([
                [0, 0],
                [ext_r+extra_length, -base_length],
                [ext_r+extra_length, ext_r*2+0],
                [0, ext_r*2]
                ]);
            }
          }
          translate([0, 0, -1]) cylinder(d=3.2, h=thickness+2);
        }
  }
}