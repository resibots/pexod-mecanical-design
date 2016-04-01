include <settings.scad>
use <modules.scad>
use <utils.scad>

/*optoforce_plate(2, "cone");*/
foot_end();

/*rotate([0, 180, -90])
  optoforce();*/

//////////
// Modules
//////////

module foot_end() {
  optoforce_interface="cone";

  pipe_holders(wall_thickness);

  translate([0, 8+5, 5+4])
    rotate([90, 90, 90])
      spring_mounting();

  if (optoforce_interface != "none")
    optoforce_plate(base_thickness, optoforce_interface);

  translate([10, -8, 12])
    rotate([0, 25, 180])
      mirror([0, 0, 1])
        cable_holder();
}

// The base of this the foot_end part where the pipes go and on which are added
// the attachment for the spring and the sensor/foot tip.
//
// @param wall_thickness width of the wall between the pipe holders
// @param base_thickness how thick the base between the pipe holders is
module pipe_holders(wall_thickness = 4, base_thickness = 2) {
  difference() {
    // Base of the part we are modeling. It's the shape without the holes.
    union() {
      // Cylinders for the pipe holders
      for(x_offset=[15, -15]) {
        translate([x_offset, 0, 0]) cylinder(r=8, h=18);
      }

      // Structure joining the cylinders together
      difference() {
        translate([-15, -8, 0])
          cube([30, 16, 18]);

        // Make the linkage between the two cylinders hollow
        translate([-16, -(8-wall_thickness), base_thickness])
          cube([32, 16-2*wall_thickness, 20]);
      }
    }
    cylinders_digging(false);
  }
}

// This is a plate on which the optoforce should be attached.
// We designed three variants:
// - basic one, only the disk and two holes for screws
// - "pins", adding three pins to enter the screw holes in the sensor, in order
//   to keep it in place
// - "wall", one thin wall around the disk to help center the sensor
// - "cone", a conic shaped wall to make the design resilient to 3D printing inacuracy
//
// @param height how high the disk is going to be (excluding the optional extras)
// @param extra see the above description for the proposed extras (defaults to none)
module optoforce_plate(height, extra="none") {
  cone_base = 10.8;
  cone_shift = 1;
  difference() {
    union() {
      cylinder(h=height, r=cone_base+0.5+cone_shift);

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
      } else if (extra == "cone") {
        rotate([180, 0, 0])
          rotate_extrude()
            polygon([
              [cone_base, 0],
              [cone_base+cone_shift, 1],
              [cone_base+0.5+cone_shift, 1],
              [cone_base+0.5+cone_shift, 0],
              ]);
      }
    }

    // Holes to attach the sensor
    r_distribution = 9.5;
    holes_depth = 6;
    oblong = 0.5;
    for (angle=[90, 270]) {
      rotate([0, 0, angle])
        translate([r_distribution-oblong/2, 0, -1])
          hull() {
            cylinder(h=holes_depth, d=2);
            translate([oblong, 0, 0])
            cylinder(h=holes_depth, d=2);
          }
    }
  }
}

// Digging in the two pipe holders.
// This is the shape that must be removed from the piece to let the
//
// @param open_hole whether the pipe holders should be digged open on the low end
module cylinders_digging(open_hole=false) {
  for(x_offset=[-15, 15]) {
    // Opening the bottom of the part
    if (open_hole) {
    translate([x_offset, 0, -1])
      cylinder(h=20, r=4);
    }
    // Holes for the pipes
    translate([x_offset, 0, 2])
      cylinder(h=20, r=6);

    // Holes to fix the pipes
    translate([x_offset, -9, 14])
      rotate([-90, 0, 0])
        cylinder(h=18, r=1);
  }
}

// Spring mounting
module spring_mounting() {
  difference() {
    // Initial full shape (extruded circle + rectangle)
    linear_extrude(height=14, center=true)
      union() {
        circle(r=5);
        translate([-5, -6]) square([10, 6]);
      }
    // remove the middle of the shape
    cube([15, 20, 6], center=true);

    // holes for the spring's screw
    cylinder(h=17, r=3.2/2, center=true);
  }
}

// Experimental shape in which we wanted to cut an opening to slide the sensor in.
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