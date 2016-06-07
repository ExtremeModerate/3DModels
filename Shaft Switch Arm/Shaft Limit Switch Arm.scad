// Hub and adjustable cam for hitting 

in = 25.4;  // makes it easier to read the measurements

// shaft diameter increased for hex shape and some extra play
nominalSize = 0.5 * in;
shaftDiam = 0.25 + nominalSize * 2 * tan(30); //nominal diameter of the shaft (flat to flat)

hubDiam = 1.5*in;

//size of nut
rNut_ac=5.5/2/cos(360/12)-0.1;
// height of the nut
hNut=3;
// hole for the screw to go through without touching
rNutFree=1.05*4/2;
// hight of nut trapp 90% of nut height
h1=hNut*.9;
// outer radius of nut trapp
r1=1.05*(rNut_ac+1.5);

hubHeight = hNut+2;  // how much larger than the nut catch

camDiam = hubDiam*0.95;
camHeight = 4;
armWidth = camDiam/8;
armLength = 2.5*in;
slotDiam = (shaftDiam+hubDiam)/2 - rNutFree/2;  // how far out on the cam the slot is
slotAngle = 75; //how much adjustability in the slots

//height of scale
hs=.5;
//width of scale
ws=.5;
// number of major ticks
nm=36;
// small number for overlapp
e=0.01;
e2=1.4;

module cam_body() {
    linear_extrude(height=camHeight) {
        difference() {
            hull() {
                circle(d=camDiam);
                translate([0, camDiam/2-armWidth]) square([armLength, armWidth]);
                translate([armLength, camDiam/2-armWidth/2]) circle(d=armWidth);
            }
            // slots for the nuts
            union() {
                for (c=[0, 180]) {
                    for (i=[c-slotAngle/2: 2 : c+slotAngle/2]) {
                        rotate(i) translate([0,slotDiam/2]) circle(r=rNutFree*.95, $fn=10);
                    }
                }
            }
            circle(d=shaftDiam);
        }
    }
}

module tickmarks(length=1, spacings=[1], unit=1, lineWidth=1) {
    //unit = conversion factor from mm to whatever unit you want
    //   units = 25.4 will give inch measurements
    for (i=[0 : len(spacings)-1]) {
        divs = length/(spacings[i]*unit);
        for (d=[0 : divs]) {
            x = spacings[i]*unit*d;
            translate([x, 0, 0]) square([lineWidth, lineWidth*2+i], center=true);
        }
    }
}

module Scale(outerDiam=1) {
    union() {
		for(i=[0:nm-1]) {
			rotate(360/nm*i)
	//            translate([shaftDiam-ws, -ws/2]) cube([shaftDiam, ws, hs]);
		#	translate([slotDiam/2+rNutFree, -ws/2]) cube([outerDiam/2-slotDiam/2-rNutFree, ws, hs]);
		}
		translate([0, outerDiam/2-ws, 0]) 
			#linear_extrude(hs) tickmarks(armLength, [1/4, 1/2, 1], 25.4, ws);
	}
}

module cam() {
    difference() {
        cam_body();
      * # translate([0,0,camHeight-hs]) Scale(camDiam);
    }
}

module hub() {
    difference() {
        cylinder(d=hubDiam, h=hubHeight);
        for (i=[0, 180]) {
            rotate(i) {
                translate([0,slotDiam/2,0]) cylinder(hubHeight,rNutFree,rNutFree,$fn=24);
                translate([0,slotDiam/2,hubHeight-hNut])cylinder(hNut,rNut_ac,rNut_ac,$fn=6);
            }
            cylinder(d=shaftDiam, h=hubHeight, $fn=6);	//this one gets the hex
        }
		translate([-ws, hubDiam/2-ws*2, 0]) cube([ws*2, ws*2, hubHeight]);	//notch for scale
    }
}


*hub();
//this puts the cam next to the hub for easy printing
translate([0,camDiam+5,0]) cam();

//animate the cam on the hub - NOTE: this won't e in the final rendering
%rotate(180+(slotAngle)*(0.5-$t)) translate([0,0,hubHeight]) cam();

