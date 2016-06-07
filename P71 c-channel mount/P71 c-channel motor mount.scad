//mount for a andymark p71 gear box to fit in a 2"x2"x1/8"wall c-channel

in=25.4;
wbox=1.75*in;
lmotor=1*in;
hfront = 0.25*in;
dmotor=1.772*in+2;
dshaft=1.04*in;
dholes=1.378*in;

$fn=50;
union() {
    translate([0, 0, hfront]) 
        difference() {
            cube([wbox, wbox, lmotor]);
            translate([wbox/2, wbox/2, 0]) cylinder(d=dmotor, h=lmotor);
        }
    difference() {
        cube([wbox, wbox, hfront]);
        translate([wbox/2, wbox/2, 0]) cylinder(d=dshaft, h=lmotor);
        for (i=[45, 135, 225, 315]) {
            translate([wbox/2, wbox/2, 0]) rotate([0, 0, i]) translate([dholes/2, 0, 0]) cylinder(d=4, h=lmotor);
        }
        for (i=[0.25*in, wbox-0.25*in]) {
            depth=wbox; //0.3*in;
            #translate([i, depth, hfront/2]) rotate([90, 0, 0]) cylinder(d=3, h=depth);
        }
    }
}
