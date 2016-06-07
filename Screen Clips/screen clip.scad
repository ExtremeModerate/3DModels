in=25.4;

w=in;
l=1.5*in;
h1=in*3/32;
h2=h1+(in*1/8);
gap=in*5/16;
d=in*1/8;

difference() {
    union() {
        cube([w, l, h1]);
        translate([0,h2/2,h2/2]) rotate([0,90,0]) cylinder(d=h2, h=w, $fn=20);
        cube([w, h2, h2/2]);
        translate([0, gap+h2, 0]) cube([w, h2, h2]);
        //translate([0,gap+h2/2,h2/2]) rotate([0,90,0]) cylinder(d=h2, h=w);
    }
    translate([w/2, l*.75, 0]) cylinder(d=d, h=w, $fn=30);
}