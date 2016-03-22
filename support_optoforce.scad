$fn=100;

spring_mounting()
  pipe_holders(extra="none");
//rotate([0, 180, -90])
//optoforce();

module pipe_holders(extra="none") {
  wall_thickness = 4;
  base_thickness = 2;

  difference() {
    union() {
      // base cylinders for the pipe holders
      for(x_offset=[15, -15]) {
        translate([x_offset, 0, 0]) cylinder(r=8, h=18);
      }
      // structure joining the cylinders together
      difference() {
        union() {
          rotate([90, 0, 0])
            linear_extrude(height=16, center=true)
              polygon([[15, 0], [15, 18], [5, 10], [-5, 10], [-15, 18],
                       [-15, 0]]);
          // Holding the Optoforce sensor
          cylinder(h=base_thickness, d=24);

          if (extra == "pins") {
            r_distribution = 9.5;
            holes_depth = 1;
              translate([0, 0, -holes_depth])
              for (angle=[-17.5, 17.5, 180]) {
                translate([r_distribution*cos(angle), r_distribution*sin(angle), 0])
                  cylinder(h=holes_depth, d=2);
              }
          } else if (extra == "wall") {
            translate([0, 0, -1])
              rotate_extrude()
                translate([11.1, 0, 0])
                  square([0.9, 1]);
          }
        }

        translate([-16, -(8-wall_thickness), base_thickness])
          cube([32, 16-2*wall_thickness, 20]);

        // Holes to attach the sensor
        r_distribution = 9.5;
        holes_depth = 6;
        for (angle=[90, 270]) {
          translate([r_distribution*cos(angle), r_distribution*sin(angle), -1])
            cylinder(h=holes_depth, d=2);
        }
      }

      children();
    }

    for(x_offset=[-15, 15]) {
      // holes in the pipes
      //translate([x_offset, 0, -1])
      //  cylinder(h=20, r=4);
      translate([x_offset, 0, 2])
        cylinder(h=20, r=6);

      // holes to fix the pipes
      translate([x_offset, -9, 14])
        rotate([-90, 0, 0])
          cylinder(h=18, r=1);
    }
  }
}

// spring mounting
module spring_mounting() {
  difference() {
    union() {
      translate([0, 8+5, 5])
        rotate([90, 90, 90])
          difference() {
            linear_extrude(height=14, center=true)
              union() {
                circle(r=5);
                translate([-5, -6]) square([10, 6]);
              }
            cube([15, 20, 6], center=true);
          }

      children();
    }

    // holes for the spring mounting
    translate([0, 8+5, 5])
      rotate([0, 90, 0])
        cylinder(h=30, r=3.2/2, center=true);
  }
}

module optoforce_holder(margin_diameter=0, margin_height=0) {
  sensor_diameter = 22;
  difference() {
    cylinder(h=6+margin_height, d=sensor_diameter+margin_diameter+2);
    translate([0, 0, -1])
      cylinder(h=6+margin_height, d=sensor_diameter+margin_diameter);
    translate([0, 0, -1])
      cylinder(h=8, d=sensor_diameter+margin_diameter-1);
  }
}

module optoforce() {
  difference() {
    union() {
      // Base
      color("grey")
        cylinder(h=5, d=22);

      // Active surface
      color("black")
        translate([0, 0, 5])
          intersection() {
            translate([-12, -12, 0])
              cube([24, 24, 20]);
            sphere(10);
          }

      // Cable
      color([0.2, 0.2, 0.2])
        translate([0, 0, 2.35])
          rotate([-90, 0, 0])
            cylinder(h=50, d=2.7);
    }

    // Holes
    r_distribution = 9.5;
    rotate([0, 0, 90])
      for (angle=[-17.5, 17.5, 90, 180, 270]) {
        translate([r_distribution*cos(angle), r_distribution*sin(angle), -1])
          cylinder(h=3, d=2);
      }
  }
}