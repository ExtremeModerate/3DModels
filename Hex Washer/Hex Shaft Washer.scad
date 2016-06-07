// Aluminum tubing insert to support a 1/2" hex shaft
// Designed to work with the AndyMark am-0096a hub
// http://www.andymark.com/Hub-p/am-0096a.htm

// adjust the wallSize, shaft diameter and length as you see fit

use <Write.scad>

in = 25.4;  // makes it easier to read the measurements

shaftDiam = 1/2 * in; //nominal diameter of the shaft (flat to flat)
hexDiam = 2*tan(30)*shaftDiam;     //the diamiter of the points of the hex shaft, it's only 1/2" to the flat sides

washerDiam = 2*in;
thickness = in/8;
textCount = 3;

difference() {
    difference() {
        cylinder(d=washerDiam, h=thickness);
        cylinder(d=0.5+hexDiam, h=thickness, $fn=6);
    }
    // put our team numbers on it
    for (i=[0 : textCount]) {
        rotate([0,0,i*360/textCount]) # writecylinder(text="4026", face="top", where=[0,0,0], radius=washerDiam/2, height=thickness, h=washerDiam/(4+textCount));
    }
}