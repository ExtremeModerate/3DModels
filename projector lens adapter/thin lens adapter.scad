//Title: Canon EF Mount Body Cap
//Modified By: Robert Macgregor
//Date: March 29, 2014
//Original Author: Alex English - ProtoParadigm
//Original Date: 8-8-2011
//License: GPL2
use<text_on_cylinder.scad>;

//$fs = .1;
$fn = 50;
module EFmount() {
	//$fa = 1;
    difference() {
        translate([0,0,(bevelHeight-4.8)])  // put the whole thing back to zero
        union() {
            translate([0,0,-(bevelHeight-4.8)])
                cylinder(h = bevelHeight, r2 = outerGrip/2, r1=thickness+lensDiameter/2);  //outer grip
            translate([0, 0, 6])
                cylinder(h = 5, r = 50.5/2);
            translate([0, 0, 4])
                cylinder(h = 3, r = 54/2);   //lip
            //color("red") translate([0, 0, 12.5])       //inner mounting hole
            //	cylinder(h = 3.2, r1 = 39.7/2, r2 = 39.5/2);
            translate([0, 0, 7])
                threads();
            rotate([0, 0, -33])
                translate([-(outerGrip+.5)/2, 0, bevelHeight-.3])
                    cube(size=[5, 2, bevelHeight-1.2], center = true); //alignment mark
        }
        cylinder(h=20, r=adapterLensMin/2);   //cut out the center 40mm hole
        // Now the locking pin hole
        rotate([0, 0, -26])
            translate([-outerGrip/2+2, 0, bevelHeight-1]) 
                linear_extrude(h=10) {
                    hull() {
                        circle(r=2);
                        translate([1, 0, 0])
                            circle(r=2);
                    }
                }
    }
}

module threads() {
	difference() {
		cylinder(h = 4, r = 53.2/2);  //thread outer
		cylinder(h = 4, r = 50.4/2);  //thread cylinder
		cylinder(h = 2.6, r = 54/2);  //gap lip to thread
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


module plateHoles(size = 3) {
    for (a=[1 : mountHoles] ) {
        rotate([0,0,a*(360/mountHoles)]) 
        translate([outerGrip/2 + thickness, 0, -1]) 
        cylinder(h=thickness*2, d=size);
    }
}

module cameraMount() {
//this should be 12mm tall afterwards
    difference() {
        union() {
        rotate([0,0,28])  //rotate the lens around to try to get the plate straight
        difference() {
            translate([0,0,adapterHeight])    
                EFmount();
            translate([0,0,adapterHeight])
                cylinder(h = bevelHeight, r1=outerGrip/2, r2 = adapterLensMin/2);    //remove conical center
            cylinder(h=adapterHeight+bevelHeight+5, r=adapterLensMin/2);  //ensure center minimum clear (redundant)
        }
            
       difference() {
            union() {
                cylinder(h=adapterHeight, r=thickness+lensDiameter/2);
                rectBase(plateWidth, plateDepth, thickness, 5);
            }
            cylinder(h=adapterHeight, r=lensDiameter/2);
        }
    }
        translate([0, 0, adapterHeight/2]) text_on_cylinder(t="Ken Craig, EF 50-90mm 1:1.8", depth=2, size=5, r=thickness+lensDiameter/2-1, a1=270, a2=450, font="Lucida Sans Typewriter:style=Bold", valign="baseline");

    }
}

module rectBase(w, d, h, r) {
    xOffset=w/2-r;
    yOffset=d/2-r;
    
    linear_extrude(h) {
        difference() {
        hull() {
        translate([-xOffset, yOffset, 0]) circle(r);
        translate([xOffset, yOffset, 0]) circle(r);
        translate([xOffset, -yOffset, 0]) circle(r);
        translate([-xOffset, -yOffset, 0]) circle(r);
    }
        translate([-phWidth/2, phDepth/2, 0]) circle(d=hole);
        translate([phWidth/2, phDepth/2, 0]) circle(d=hole);
        translate([phWidth/2, -phDepth/2, 0]) circle(d=hole);
        translate([-phWidth/2, -phDepth/2, 0]) circle(d=hole);
}
}
}

module midSection() {
    midHeight = 30;
       difference() {
           union() {
               rectBase(plateWidth, plateDepth, thickness, 5);
               cylinder(h=midHeight, r=lensDiameter/2+thickness+1);
           }
           cylinder(h=midHeight, r=lensDiameter/2+1);
           plateHoles(1);
       }
}


// mount plate is 80x97mmx5mm
// outer dimension of lens 74mm(d)x22mm(h) 

/*
Focal plane to lens = 54mm
Focal plane to start of adapter = 46mm
lens depth = 22mm
*/

thickness = 4;  //thickness of sides and plate
plateWidth = 97;    // width of plate
plateDepth = 80;    // depth of plate
lensDiameter = 74;  // diameter of the actual lens 
phWidth = 79;
phDepth=65;
hole = 3.5;
bevelHeight = 4;

outerGrip = 64.7;   // diameter of outer grip
adapterHeight = 22; //height of the adapter NOT INCLUDING the mount
adapterLensMin = 41.5; //minimum diameter of the inner cylinder for the lens
adapterLensMax = outerGrip-thickness;   //large diameter of the innder cylinder for the lens
adapterDiameter = adapterLensMax+thickness;
mountHoles = 8;

difference() {
    cameraMount();
    *cube([100, 100, 100]);
}
//color("red") translate([max(plateWidth, plateDepth), 0, 0]) 
//midSection();