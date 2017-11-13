use <modules.scad>

$fn = 10;

branch_thickness = 1.5;

rotate([90, 0, 0]) {
  color("blue")
    linear_extrude(3, center = true)
      square(39, true);

  /*color("green")
    for (i = [0 : 90 : 270]) {
      rotate([0, 0, i])
        translate([39/2+1.5/2, 0, 0])
          square([1.5, 22], true);
    }*/
}

color("orange")
for (i=[0,180]) {
  rotate([0, i, 0])
  translate([11+branch_thickness/2, 0, 39/2+branch_thickness/2])
  rotate([0, 45, 0])
  linear_extrude(height = branch_thickness, center = true)
  polygon([[0, 0], [12, -12], [12, 0], [0, 12]]);
}
for (i=[0,180]) {
  rotate([0, i, 0])
  translate([-11-branch_thickness/2, 0, 39/2+branch_thickness/2])
  rotate([0, 45+90, 0])
  linear_extrude(height = branch_thickness, center = true)
  polygon([[0, 0], [12, -12], [12, 0], [0, 12]]);
}

half(branch_thickness);
rotate([180, -90, 0])
half(branch_thickness);

module half(branch_thickness) {
  length = 30;
  margin = 0;
  inter_branch_distance = 39;

  translate ([-22/2, 0, -inter_branch_distance/2]) {
    mirror([0, 0, 1])
      dynamixel_frame(branch_thickness, length, margin);
    translate([0, 0, inter_branch_distance])
      dynamixel_frame(branch_thickness, length, margin);
  }
}