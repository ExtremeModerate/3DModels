w=97;
h=80;
hole=3;
bar=15;

module singleBar(barHeight=7) {
    linear_extrude(height=barHeight) 
        difference() {
            hull() {
                translate([w/2, h/2, 0]) circle(d=bar, center=true);
                translate([-w/2, -h/2, 0]) circle(d=bar, center=true);
            }
            translate([w/2, h/2, 0]) circle(d=hole, center=true);
            translate([-w/2, -h/2, 0]) circle(d=hole, center=true);
        }
}

union() {
    singleBar(7);
    translate([0,0,7]) rotate([180, 0, 0]) singleBar(7);
}
