include <../../settings.scad>
use <modules.scad>
use <../../utils.scad>

use <support_guidages.scad>
use <bouchon.scad>
use <support_patin.scad>
use <patin.scad>

branch_length = 27; // from support_guidages in support_guidages.scad
base_width = 11.25; // from dynamixel_frames in support_guidages.scad
branch_width = 22; // from dynamixel_frame in modules.scad
entraxe = 26;
cap_thickness = 2;

color("orange")
translate([0, 0, -cap_thickness])
  rotate([0, 180, 0])
    support_guidages();

color("green")
  rotate([0, 180, 0])
    cap();

translate([0, -entraxe, 0])
  translate([0, 0, -94]) {
    color("purple")
      foot_end();
    color("SlateBlue")
      rotate([180, 0, 0])
        patin();
  }

translate([0, -entraxe, 0])
  translate([0, 0, -90])
    pipes(150);

module pipes(length) {
  for (x_offset=[-15, 15]) {
    translate([x_offset, 0, 0])
    cylinder(h=length, d=12.03);
  }
}