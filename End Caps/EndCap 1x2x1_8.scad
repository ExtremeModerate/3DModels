in=25.4;

module roundedRect(size, radius) {
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
	hull() {
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}


module rounded_cube(sx,sy,sz,r) 
{
	$fn=20;
	union()
	{
		translate([r,r,0]) cube([sx-2*r,sy-2*r,sz],false);
		translate([r,0,r]) cube([sx-2*r,sy,sz-2*r],false);
		translate([0,r,r]) cube([sx,sy-2*r,sz-2*r],false);

		translate([r,r,r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);
		translate([r,sy-r,r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);
		translate([r,r,sz-r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);
		translate([r,sy-r,sz-r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false);

		translate([r,r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);
		translate([r,sy-r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);
		translate([sx-r,r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);
		translate([sx-r,sy-r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false);

		translate([r,r,r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);
		translate([r,r,sz-r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);
		translate([sx-r,r,r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);
		translate([sx-r,r,sz-r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false);

		translate([r,r,r]) sphere(r);
		translate([r,sy-r,r]) sphere(r);
		translate([r,r,sz-r]) sphere(r);
		translate([r,sy-r,sz-r]) sphere(r);

		translate([sx-r,r,r]) sphere(r);
		translate([sx-r,sy-r,r]) sphere(r);
		translate([sx-r,r,sz-r]) sphere(r);
		translate([sx-r,sy-r,sz-r]) sphere(r);
	}
}



module endCap(w=1*in, l=1*in, ih=in/2, wall=in/16, oh=in/4) {
	offset=wall;
	hole=3;		//mount hole diameter

	rotate([180, 0,0])
		difference() {
			union() {
				difference() {
					translate([wall,wall,0]) cube([w-wall*2,l-wall*2,ih]);
				#	translate([wall*2,wall*2,0]) cube([w-wall*4,l-wall*4,ih]);
				}
				#translate([offset,offset,ih]) linear_extrude(height=oh/2) {
						offset(offset) square([w-offset*2,l-offset*2], $fn=20);
				}
				translate([0,0,ih]) rounded_cube(w,l,oh, offset);
			}
		
		holeDepth = ih-min(0.5*in, ih/2);
			echo(holeDepth=holeDepth);
		translate([w/2, 0, holeDepth]) rotate([-90, 0, 0]) cylinder(d=hole, h=l, $fn=20);
		translate([0, l/2, holeDepth]) rotate([0, 90, 0]) cylinder(d=hole, h=w, $fn=20);
		
		}
}



*endCap(1*in, 1*in, 0.75*in, in/16, in/4);	// 1x1x1/16 tubing, 1/2" insert, 1/4" exterior
*endCap(1*in, 1*in, in/2, in/8, in/4);	// 1x1x1/8 tubing, 1/2" insert, 1/4" exterior
*endCap(1*in, 2*in, in/2, in/16, in/4);	// 1x2x1/16 tubing, 1/2" insert, 1/4" exterior
endCap(1*in, 2*in, 0.75*in, in/8, in/4);	// 1x2x1/8 tubing, 1/2" insert, 1/4" exterior
