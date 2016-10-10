use <../support_guidages.scad>

branch_length = 27; // from support_guidages in support_guidages.scad
base_width = 11.25; // from dynamixel_frames in support_guidages.scad
branch_width = 22; // from dynamixel_frame in modules.scad

translate([0, branch_length+base_width, branch_width/2])
  rotate([180, 0, 0])
    support_guidages();