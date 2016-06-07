//Edge marking guides for aluminum tubing
// Ken Craig
// FRC Team 4026 http://DecaturRobotics.org
//

use <MCAD/boxes.scad>;

thick = 1;
in = 25.4;
length = 2*in;
width = .5*in;
spacing = (1/8)*in;
crossSize = (1/4)*in;
lineWidth = 1;

module tickmarks(length=1, spacings=[1], unit=1, lineWidth=1) {
    //unit = conversion factor from mm to whatever unit you want
    //   units = 25.4 will give inch measurements
    for (i=[0 : len(spacings)-1]) {
        divs = length/(spacings[i]*unit);
        for (d=[1 : divs-1]) {
            x = spacings[i]*unit*d;
            translate([x, 0, 0]) square([lineWidth, lineWidth*2+i], center=true);
        }
    }
}

module multi_edge_guide(size=[25.4, 25.4, 1], position=[0.5*in], long=true, short=false, lineWidth = 1) {
    length = size[0];
    width = size[1];
    height = size[2];
	
	echo(position=position);
    union() {
        difference() {
            linear_extrude(height=height) {
            difference() {
                square([length, width]);
                for (i=[0:len(position)-1]) {
					translate([spacing, (position[i])-lineWidth/2]) square([length-2*spacing, lineWidth]);
					translate([0, position[i]]) tickmarks(length, [1/8, 1/4, 1/2, 1], 25.4, 1);
				}
            }
        }
        translate([0,0,height/2])
            linear_extrude(height=height/2) {
                translate([1, 1, 0]) text("4026", size=width/5);
            }
        }
        //now add the edge guide(s)
        if (long) {
            translate([0, width, 0]) cube([length, thick, thick*4]);
        }
        if (short) {
             translate([length, 0, 0]) cube([thick, width, thick*4]);
        }
    }
}

module edge_guide(size=[25.4, 25.4, 1], long=true, short=false, lineWidth = 1) {
	multi_edge_guide(size=size, position=[size[1]/2], long=long, short=short, lineWidth=lineWidth);
}



edge_guide([4*in, 1*in, 1], long=true, short=false);
translate([0, -2.2*in, 0]) multi_edge_guide([4*in, 2*in, 1], position=[0.5*in, 1.5*in], long=true, short=false);

translate([3*in, 1.25*in, 0]) rotate([0,0,90]) {
    edge_guide([2*in, 1/2*in, 1], long=false, short=true); 
    translate([0, .75*in, 0]) edge_guide([2*in, 1*in, 1], long=true, short=false); 
    translate([0, 2*in, 0]) edge_guide([2*in, 3/4*in, 1], long=false, short=true); 
}
//tickmarks(length, [1/8, 1/4, 1/2, 1], in, 1);