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