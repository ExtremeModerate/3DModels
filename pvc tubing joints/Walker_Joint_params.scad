use <regular_shapes.scad>;

in=25.4;
od=in*3/4;
id=od-in*1/8;
shaft=od*2;
$fn = 100;

difference()
{
	union()
	{
		difference()
		{
			#translate([0,0,28.5]) cylinder(h = 14, d = 24, center = true);		// Join to vertical bar.
			translate([0,0,37]) rotate ([90,0,0]) cylinder(h = 30, d = 26, center = true);		// Diameter of vertical bar.
		}
		translate([0,0,20.5]) cylinder(h = 2, d1 = 18, d2 = 24, center = true);	// Flange
		translate([0,0,10]) cylinder(h = 20, d = 19, center = true);		// Inside shaft.
		rotate(a=[0,0,45], v=[0,0,0]) rotate(a=[5,0,0], v=[0,20,0]) translate([0,-4,14]) 
			cube(size = [4,9,20], center = true);	// Wing
		rotate(a=[0,0,135], v=[0,0,0]) rotate(a=[5,0,0], v=[0,20,0]) translate([0,-4,14]) 
			cube(size = [4,9,20], center = true);	// Wing
		rotate(a=[0,0,225], v=[0,0,0]) rotate(a=[5,0,0], v=[0,20,0]) translate([0,-4,14]) 
			cube(size = [4,9,20], center = true);	// Wing
		rotate(a=[0,0,315], v=[0,0,0]) rotate(a=[5,0,0], v=[0,20,0]) translate([0,-4,14]) 
			cube(size = [4,9,20], center = true);	// Wing
	}
	cylinder(h = 80, d = 7, center = true);		// hole for large screw
	linear_extrude(height = 32, center = true, convexity = 10, twist = 0) hexagon(6);		// hole for nut
	translate([0,-20,9]) rotate ([90,0,0]) cylinder(h = 40, d = 3, center = true);		// hole for small screw

}

