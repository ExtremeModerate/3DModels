//Edge marking guides for aluminum tubing
// Ken Craig
// FRC Team 4026 http://DecaturRobotics.org
//

use <MCAD/boxes.scad>;

thick = 1;
edge_height = thick*4;
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

module multi_edge_guide(size=[25.4, 25.4, 1], position=[0.5*in], long=true, short="", lineWidth = 1) {
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
        
        leftShort = (short == "left" || short == "both");
        rightShort = (short == "right" || short == "both");
        longOffset = (leftShort ? thick : 0) + (rightShort ? thick : 0);
        shortOffset = long ? thick : 0;
        
        //now add the edge guide(s)
        if (long) {
            translate([leftShort ? -thick : 0, width, 0]) cube([length + longOffset, thick, edge_height]);
        }
        if (rightShort) {
     #        translate([length, 0, 0]) cube([thick, width+shortOffset, edge_height]);
        } 
        if (leftShort) {
     #        translate([-thick, 0, 0]) cube([thick, width+shortOffset, edge_height]);
        } 
    }
}

module edge_guide(size=[25.4, 25.4, 1], long=true, short="", lineWidth = 1) {
	multi_edge_guide(size=size, position=[size[1]/2], long=long, short=short, lineWidth=lineWidth);
}



module complete_set() {
// 4 inch for 1x tubing long edge - the original!
edge_guide([4*in, 1*in, 1], long=true, short="");

// 4 inch for 2x tubing long edge with marking at 1/2" from each end
translate([0, -2.2*in, 0]) 
    multi_edge_guide([4*in, 2*in, 1], position=[0.5*in, 1.5*in], long=true, short="");

// narrow 2 inch for cross marking 2x tubing
translate([3*in, 1.25*in, 0]) rotate([0,0,90]) {
    edge_guide([2*in, 1/2*in, 1], long=false, short="right"); 

    // 2 inch for 1x tubing, short original
    translate([0, .75*in, 0]) 
        edge_guide([2*in, 1*in, 1], long=true, short=""); 
    
    // 2 inch for end marking 3/4" tubing
    translate([0, 2*in, 0]) 
        edge_guide([2*in, 3/4*in, 1], long=false, short="right"); 
}
//tickmarks(length, [1/8, 1/4, 1/2, 1], in, 1);
}

edge_guide([4*in, 1*in, 1], long=true, short="right");
