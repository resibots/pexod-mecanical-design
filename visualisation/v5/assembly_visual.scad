include <settings.scad>
use <modules.scad>
use <utils.scad>

use <support_guidages.scad>
use <bouchon.scad>
use <support_optoforce.scad>

branch_length = 27; // from support_guidages in support_guidages.scad
base_width = 11.25; // from dynamixel_frames in support_guidages.scad
branch_width = 22; // from dynamixel_frame in modules.scad

translate([0, -branch_length-base_width, branch_width/2])
  rotate([0, 180, 0])
    support_guidages();

translate([0, -branch_length-base_width, branch_width/2+2])
  rotate([0, 180, 0])
    cap();

translate([0, -branch_length-base_width, 0])
  translate([0, 0, -102])
    rotate([0, 0, 180])
      foot_end();

translate([0, -branch_length-base_width, 0])
  translate([0, 0, -101])
    pipes(120);

translate([0, -branch_length-base_width, 0])
  translate([0, 0, -102])
    rotate([0, 180, 90])
      optoforce(length_cable=10);

module pipes(length) {
  for (x_offset=[-15, 15]) {
    translate([x_offset, 0, 0])
    cylinder(h=length, d=12.03);
  }
}