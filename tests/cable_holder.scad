include <../settings.scad>
use <../modules.scad>
use <../utils.scad>

mirror=1;
translate([-10, -10, -2])
  cube([20, 20, 2]);
mirror([0, mirror, 0])
  rotate([90, 0, 0])
    cable_holder();