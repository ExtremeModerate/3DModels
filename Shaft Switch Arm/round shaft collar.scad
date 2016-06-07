
use <MCAD/nuts_and_bolts.scad>;

in=25.4;
shaft = .5*in;
screw = 3;
head = 5;
width = screw*2;
collar = shaft + max(.5*in, screw+4);
slot = 1;

difference() {
	cylinder(d=collar, h=width);
	translate([shaft/2+(collar-shaft)/4-screw/2, -screw/2, width/2]) rotate([90, 0, 0]) cylinder(d=screw, h=collar, center=true,$fn=20);
	cylinder(d=shaft, h=width);
	translate([0, -slot/2, 0]) cube([collar/2, slot, width]);
}

//screw("m5", 10, -1, false, -1);

//module boltHole(size, units=MM, length, tolerance = +0.0001, proj = -1)
