mm=1;
cm=10;
in=24.5;
length=3*in;
diam=4.75*mm;
flat=0.5*mm;
module tetrix_shaft(length=10, orient=[0,0,0]) {
    //length = length of the shaft
    //orient = orientation of the shaft along the x, y , or z axis
    //         defaults to z axis, with flat on the positive x axis
    diam = 4.75; //diameter of the shaft
    flat = 0.5; //how big is the flat edge
    //translate([0, 0, diam/2-flat])
    rotate([0, 90*orient[1], 0])
    rotate([-90*orient[1],90*orient[0],0])
    difference() {
        cylinder(h=length, d=diam, center=false, $fn=50);
        translate([diam/2-flat, -diam/2, 0]) cube([flat, diam, length]);
    }
}

tetrix_shaft(length);
