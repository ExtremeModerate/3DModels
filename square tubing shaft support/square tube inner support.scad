// Aluminum tubing insert to support a 1/2" hex shaft
// Designed to work with the AndyMark am-0096a hub
// http://www.andymark.com/Hub-p/am-0096a.htm

// adjust the wallSize, shaft diameter and length as you see fit

use <MCAD/regular_shapes.scad>

in = 25.4;  // makes it easier to read the measurements

tubeSize = 1*in;   //outer size of the tube
wallSize = 1/16*in; //wall thickness
shaftDiam = 1/2 * in; //nominal diameter of the shaft (flat to flat)
holes = (1.875)*in;  //distance between bolt holes
length = 3*in;     //overall length of the shaft

module hex_shaft_support(tubeSize=[in,in], wallSize, shaftDiam, holes, length, shift=0) {
	innerW = tubeSize[0]-(2*wallSize)-0.5; //make it .5mm smaller
	innerH = tubeSize[1]-(2*wallSize)-0.5; //make it .5mm smaller
	hexDiam = 2*tan(30)*shaftDiam;     //the diamiter of the points of the hex shaft, it's only 1/2" to the flat sides
	difference() {
		cube([innerW, length, innerH], center=true);
		translate([0, shift, 0]) {
			rotate([0, 0, 0]) cylinder(d=0.5+hexDiam, h=innerH, center=true, $fn=26);
			translate([0, holes/2, 0]) cylinder(d=5, h=innerH, center=true);
			translate([0, -holes/2, 0]) cylinder(d=5, h=innerH, center=true);
		}
	}
}


module scissor_center(tubeSize=[in,in], wallSize, shaftDiam, holes, length, shift=0) {
	innerW = tubeSize[0]-(2*wallSize)-0.5; //make it .5mm smaller
	innerH = tubeSize[1]-(2*wallSize)-0.5; //make it .5mm smaller
	hexDiam = 2*tan(30)*shaftDiam;     //the diamiter of the points of the hex shaft, it's only 1/2" to the flat sides
	difference() {
		cube([innerW, length, innerH], center=true);
		translate([0, shift, 0]) {
			rotate([0, 0, 0]) cylinder(d=.25*in, h=innerH, center=true, $fn=26);
		//	translate([0, holes/2, 0]) cylinder(d=5, h=innerH, center=true);
		//	translate([0, -holes/2, 0]) cylinder(d=5, h=innerH, center=true);
		}
	}
}

//hex_shaft_support(1*in, in*1/16, in*1/2, in*1.875, 3*in);

hex_shaft_support([1*in, in*1/2], in*1/16, 1+in*1/2, in*1.875, 4*in, .75*in);
//scissor_center([1*in, in*1/2], in*1/16, 1+in*1/2, in*1.875, 1*in, 0*in);
