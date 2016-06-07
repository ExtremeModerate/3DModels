in=25.4;

w=in;
l=w;
h=w/2;
wall = in * 1/8;
base = in*1/8;
board = in*3/16;
grips = 2;
gripSize = board/8;
holeD = 4; 

difference() {
	union() {
		difference() {
			cube([l, w, h]);
			#translate([0, 0, base]) cube([l-wall, w-wall, h]);
			translate([holeD*2, holeD*2, 0]) cylinder(d=holeD, h=wall, $fn=20);
		}
		for (i=[0 : grips-1]) {
			translate([l-wall-gripSize, 0, wall*2+i*((h-wall)/grips)]) cube([gripSize, w, gripSize]);
			translate([0, w-wall-gripSize, wall*2+i*((h-wall)/grips)]) cube([l, gripSize, gripSize]);
			translate([l-wall-board, 0, wall*2+i*((h-wall)/grips)]) cube([gripSize, w-wall-board, gripSize]);
			translate([0, w-wall-board, wall*2+i*((h-wall)/grips)]) cube([l-wall-board, gripSize, gripSize]);
		}
		translate([l-2*wall-board, 0, 0]) cube([wall, w-wall-board, h]);
		translate([0, w-2*wall-board, 0]) cube([l-wall-board, wall, h]);
	}
}

