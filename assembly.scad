include <modules.scad>
use <utils.scad>
use <support_guidages.scad>
use <bouchon.scad>
use <support_optoforce.scad>

translate([0, 0, 100])
rotate([0, 180, 0])
support_guidages();

translate([0, 0, 100+2+7])
rotate([0, 180, 0])
cap();

rotate([0, 0, 180])
foot_end();

pipes(150);

module pipes(length) {
  for (x_offset=[-15, 15]) {
    translate([x_offset, 0, 0])
    cylinder(h=length, d=12.03);
  }
}