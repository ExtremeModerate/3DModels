//mount for a andymark p71 gear box to fit in a 2"x2"x1/8"wall c-channel

in=25.4;
wbox=1.75*in;
lmotor=4*in;
face = in*1/8;
dmotor=1.772*in+2;
dshaft=1.15*in;  //large hole for the shaft surround
dholes=1.41*in; // diameter of mount holes in face
motorBoltDiam=4.25;  //diameter of the motor mount holes 
riser=in*1/4; //riser height
faceMountDiam = 4; //diameter of holes for mounting faceplate
faceMountDepth = face+0.5*in; //depth of holes for mounting faceplate.

module bolt_slots(inset=1*in, slot=1*in) {
        //bolt slots for mounting to c-channel
    bolt=0.19*in; //size of the bolt
    //#10 screw is 0.19in
    //#12 screw is 0.21in
    bolthead=0.44*in; //head size is .437", washer is .625"
    headheight=in*1/8;
    for (i=[-0.5*in, 0.5*in]) {
    translate([i+wbox/2, inset, riser-headheight]) 
        linear_extrude(h=wbox) {
            hull() {
                circle(d=bolthead);
                translate([0, slot]) circle(d=bolthead);
            }
        }
    translate([i+wbox/2, inset, 0]) 
        linear_extrude(h=riser) {
            hull() {
                circle(d=bolt);
                translate([0, slot]) circle(d=bolt);
            }
        }
    }

}


$fn=50;
*difference() {
    union() {
        #translate([-riser, 0, 0]) cube([riser, wbox, lmotor+face]);  //riser
        cube([wbox, wbox, lmotor+face]);  //faceplate plus upper sides
    }
        translate([wbox/2, 0, face]) cube([wbox/2, wbox, lmotor]); //remove upper extensions
        translate([wbox/2, wbox/2, face]) cylinder(d=dmotor, h=lmotor);
        translate([wbox/2, wbox/2, 0]) cylinder(d=dshaft, h=lmotor);
        for (i=[45, 135, 225, 315]) {
            translate([wbox/2, wbox/2, 0]) rotate([0, 0, i]) translate([dholes/2, 0, 0]) cylinder(d=4, h=lmotor);
        }
        for (i=[0.25*in, wbox-0.25*in]) {
            depth=wbox; //0.3*in;
            #translate([i, depth, face/2]) rotate([90, 0, 0]) cylinder(d=3, h=depth);
        }
}

rotate([90, 0, 0])
difference() {
    cube([wbox, face+lmotor, riser+wbox]); 
    translate([0, face, wbox/2]) cube([wbox, lmotor, riser+wbox/2]); //remove the upper box half
    translate([wbox/2, face, riser+wbox/2]) rotate([-90, 0, 0]) cylinder(d=dmotor, h=lmotor); //make room for the motor
    translate([wbox/2, 0, riser+wbox/2]) rotate([-90, 0, 0]) cylinder(d=dshaft, h=face*2); //cut out the shaft hole
    for (i=[45, 135, 225, 315]) {
        translate([wbox/2, 0, riser+wbox/2]) rotate([-90, i, 0])  translate([dholes/2, 0, 0]) cylinder(d=motorBoltDiam, h=lmotor);
    }
    //faceplate base mount holes
    base_holes=4;
    translate([0.25*in, 0, 0.25*in]) rotate([-90, 0, 0]) cylinder(d=faceMountDiam, h=faceMountDepth);
    translate([wbox-0.25*in, 0, 0.25*in]) rotate([-90, 0, 0]) cylinder(d=faceMountDiam, h=faceMountDepth);
    
    //original was 1.5 and 1
    //bolt_slots(inset=1.5*in, slot=1*in);
  *  bolt_slots(inset=2.25*in, slot=0.75*in);
    inset=2*in;
    slot=1*in;
    
    // this puts tappable holes on the sides for mounting
    inset=face+0.5*in;
    depth=wbox;
    //diameters : in*13/64 = 1/4
    //              in*5/32 = #10
    //              3.4544mm = #8
    diam=3.4544;
    height=in*1/4;
  *  #translate([wbox-depth, face+inset, height]) rotate([0, 90, 0]) cylinder(d=diam, h=depth);
  *  #translate([wbox-depth, face+lmotor-inset, height]) rotate([0, 90, 0]) cylinder(d=diam, h=depth);
    
    //chop off the whole riser and just keep the faceplate
  #  translate([0, face, 0]) cube([wbox, lmotor, riser+wbox]);
}
