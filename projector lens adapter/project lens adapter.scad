use<efmount.scad>;

module plateHoles(size = 3) {
    for (a=[1 : mountHoles] ) {
        rotate([0,0,a*(360/mountHoles)]) 
        translate([outerGrip/2 + thickness, 0, -1]) 
        cylinder(h=thickness*2, d=size);
    }
}

module cameraMount() {
//this should be 12mm tall afterwards
    union() {
        translate([0,0,adapterHeight])
        difference() {
            EFmount(outerGrip);
            cylinder(h = 20, r = adapterLensMin/2);
        }
    
        difference() {
            union() {
                cylinder(h=thickness, r=outerGrip/2+2*thickness);
                cylinder(h=adapterHeight, r1=adapterDiameter/2, r2=(adapterDiameter)/2);
            }
            cylinder(h=adapterHeight, r1=adapterLensMin/2, r2=(adapterLensMin)/2);
            rotate([0,0,-33])  // line up holes so plate is square when lens is on
                plateHoles(2);
        }
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

thickness = 5;  //thickness of sides and plate
plateWidth = 97;    // width of plate
plateDepth = 80;    // depth of plate
lensDiameter = 74;  // diameter of the actual lens 
phWidth = 79;
phDepth=65;
hole = 3.5;

outerGrip = 60;   // diameter of outer grip
adapterHeight = 5; //height of the adapter NOT INCLUDING the mount
adapterLensMin = 41.5; //minimum diameter of the inner cylinder for the lens
adapterLensMax = outerGrip-thickness;   //large diameter of the innder cylinder for the lens
adapterDiameter = adapterLensMax+thickness;
mountHoles = 8;

cameraMount();
//color("red") translate([max(plateWidth, plateDepth), 0, 0]) 
//midSection();