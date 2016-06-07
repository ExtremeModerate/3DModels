# Designed for mounting onto 3/4" PVC pipe, but I forget the intended use case

$fn=50;
in=25.4;
difference() {
    union() {
        cylinder(h=in, d=in, center=true);
        cylinder(h=3*in, d=in*3/8, center=true);
        cylinder(h=.75*in, r1=in/2, r2=in*3/16);
        rotate([180, 0, 0])         cylinder(h=.75*in, r1=in/2, r2=in*3/16);
    }
    rotate([90, 0, 0]) cylinder(h=in, d=in*0.75, center=true);
}