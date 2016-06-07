in=25.4;
id=in*3/8;
wall=in*3/16;
od=id+wall;
h=in*1/2;

pin=in*1/4;
clip=1.5*pin/2;

$fn=30;

union() {
    rotate([0,0,45])
        union() {
            difference() {
                cylinder(d=od, h=h, center=true);
                cylinder(d=id, h=h, center=true);
                translate([od/2, od/2, 0]) cylinder(d=od, h=h, center=true);
            }
            
            translate([od/2, 0, 0]) cylinder(d=wall,h=h, center=true);
            translate([0, od/2, 0]) cylinder(d=wall,h=h, center=true);
        }
    
    plate=wall/2;
    translate([0, -od/2, 0]) {
        cube([h, plate, h], center=true);
    }
    
    #translate([0, -od/2-plate]) {
        difference() {
            union() {
                cube(pin, center=true);
                translate([0, 0, -pin/2]) linear_extrude(height=pin) polygon(points=[[-clip, -pin/4], [clip, -pin/4], [0, -pin], [-clip, -pin/4]]);
            }
            translate([-pin/8, -pin, -pin/2]) cube([pin/4, pin, pin]);
        }
    }
}