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

module custom_corner_rounder(radius, height, l_x, l_y) {
  translate([-radius, -radius, 0])
    difference() {
      translate([0, 0, -height/2])
        cube([l_x, l_y, height], center=false);
      cylinder(h=height+2, r=radius, center=true);
    }
}