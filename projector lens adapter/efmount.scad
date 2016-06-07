//Title: Canon EF Mount Body Cap
//Modified By: Robert Macgregor
//Date: March 29, 2014
//Original Author: Alex English - ProtoParadigm
//Original Date: 8-8-2011
//License: GPL2


//$fs = .1;
$fn = 50;
module EFmount(outerGrip=60) {
	//$fa = 1;
	translate([0,0,1])  // put the whole thing back to zero
    difference() {
        union() {
		translate([0,0,-1])
		#cylinder(h = 5.8, r = outerGrip/2);  //outer grip
		translate([0, 0, 6])
			cylinder(h = 5, r = 50.5/2);
		translate([0, 0, 4])
			cylinder(h = 3, r = 54/2);   //lip
		//color("red") translate([0, 0, 12.5])       //inner mounting hole
		//	cylinder(h = 3.2, r1 = 39.7/2, r2 = 39.5/2);
		translate([0, 0, 7])
			threads();
		rotate([0, 0, -33])
			translate([-(outerGrip+.5)/2, 0, 1.9])
				#cube(size=[1, 2, 5.8], center = true); //alignment mark
	}
    		rotate([0,0, -27])
            translate([-(outerGrip-3)/2, 0, 3])
                #cylinder(h=2, r=.9);
}
}

module threads() {
	difference() {
		cylinder(h = 4, r = 53.2/2);  //thread outer
		cylinder(h = 4, r = 50.4/2);  //thread cylinder
		cylinder(h = 2.5, r = 54/2);  //gap lip to thread (original 2.6)
		for(i = [ [0, 0, 0], [180, 0, -70], [0, 0, -120], [180, 0, -180], [0, 0, -230], [180, 0, -300] ])
		{
			rotate(i)	
				translate([-35, 0, -5])
					cube(size=[40, 18, 10]);
		}
	}
	intersection() {
		difference() {
			cylinder(h = 4, r = 54/2);
			cylinder(h = 4, r = 50.4/2);
		}
		translate([-54/2+.4, 0, 0])
			cube(size=[4, 1.9, 4], center = false);  //thread stopper
	}	
}

//outerGrip = 88;
//EFmount();

//threads();