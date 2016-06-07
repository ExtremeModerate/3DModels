in=24.5;
width=2.5*in;
depth=3.25*in;
n=7;
diam=in*2/8;
numwidthide = (width-diam)/(n-1);
numDeep = (depth-diam)/(n-1);

$fn=50;
rotate([90,-90,90]) 
for (x=[diam/2:numwidthide:width-diam/2]) {
	echo(x);
	translate([x,0,diam/2]) cylinder(d=diam, h=depth-diam);
}

#for (x=[diam/2:numDeep:depth-diam/2]) {
	echo(x);
	translate([x,0,diam/2]) cylinder(d=diam, h=width-diam);
}

translate([diam/2, 0, diam/2]) sphere(diam/2);