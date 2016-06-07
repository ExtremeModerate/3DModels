in=25.4;

flanged = 3.8*in; //diameter of the whole flange
holed = 2.7*in; //diameter of the circle of bolt holes
boltd = in*1/4;   //bolt hole size
angle = 23;     //tilt angle
barw = 3*in; //width of the base plate

h=holed*sin(angle);

module bolt_holes(d, boltd, h, start=45, tilt=0) {
    variance=10/100;
        for (a=[start:90:359+start]) {
            hull() {
                x=cos(a)*d/2;
                y=cos(tilt*(1-variance))*sin(a)*d/2;
                echo(x=x, y=y);
                translate([x, y, 0]) cylinder(d=boltd, h=h);
                y=cos(tilt*(1+variance))*sin(a)*d/2;
                translate([x, y, 0]) cylinder(d=boltd, h=h);
            }
        }
}

module main_body_square_base(d, a, base) {
        hull() {
           # rotate([a,0,0]) translate([0, d/2,0]) cylinder(d=d, h=1);
            translate([-d/2,0, 0]) cube([base[0], min(d, base[1]), 1]);
        }
}

module main_body_round_base(d, a) {
    hull() {
        rotate([a,0,0]) translate([0, d/2,0]) cylinder(d=d, h=1);
        translate([0, d/2, 0]) cylinder(d=d, h=1);
    }
}

module flange_shim(barw=3*in, flanged=4*in, angle=23) {    
   h=max(flanged,barw)*cos(90-angle);   //match the highest point at the angle given
   $fn=30;
    difference() {
        //color("green") main_body_round_base(flanged, angle);
        color("green") main_body_square_base(flanged, angle, [flanged, barw]);
        #translate([0, min(flanged, barw)/2, 0]) bolt_holes(holed, boltd, h, 45, angle);
        }
}


module bolt_shim(d=1*in, boltd=1+in*1/4, angle=23) {    
    h=d*cos(90-angle);  //match the higheste point at the angle given
    $fn=30;
    difference() {
        main_body_round_base(d, angle);
        #translate([0, d/2, 0]) cylinder(d=boltd, h=h);
    }
}

flange_shim(barw, flanged, angle);
//translate([flanged, 0, 0]) bolt_shim(.75*in, boltd, angle);
