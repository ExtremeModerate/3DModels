in=25.4;
width=3.5*in;
depth=2.5*in;
n=6;
diam=in*1/4;
numWide = (width-diam)/(n-1);
numDeep = (depth-diam)/(n-1);


$fn=20;
rotate([90, 0, 0])
	union() {
		rotate([90,-90,90]) 
		for (x=[diam/2:numWide:width-diam/2]) {
			translate([x,0,diam/2]) cylinder(d=diam, h=depth-diam);
			translate([x, 0, diam/2]) sphere(diam/2);
			translate([x, 0, depth-diam/2]) sphere(diam/2);
		}
		
		for (x=[diam/2:numDeep:depth-diam/2]) {
			translate([x,0,diam/2]) cylinder(d=diam, h=width-diam);
			translate([x, 0, diam/2]) sphere(diam/2);
			translate([x, 0, width-diam/2]) sphere(diam/2);
		}
	
	}