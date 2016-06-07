
zipHeight = 3;
camHeight = zipHeight+5;

ld=24;

difference() {
    cylinder(d=ld, h=camHeight);
        
    #translate([zipHeight, zipHeight, (camHeight-zipHeight)/2])
        rotate_extrude(angle=15, twist=15) {
        translate([ld/2-zipHeight/2, zipHeight/2]) circle(d=zipHeight, $fn=10);
    }
}