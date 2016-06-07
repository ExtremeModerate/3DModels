in=25.4;
width=3.5*in;
depth=2.5*in;
height=0.15*in; //maximum height
base=2;   //height of base
cycles=5;   //how many full cos cycles in the space
slice=2; //desired resolution of each slice

union() {
         for (x=[0 : cycles]) {
            for (y=[0 : cycles]) {
                translate([x*((width-slice)/cycles), y*((depth-slice)/cycles), height]) cube([slice, slice, height]);
            }
        }
   *intersection() {
        for (i=[0 : cycles]) {
            translate([i*((width-slice)/cycles), 0, 0]) cube([slice, depth, height]);
            echo(i=i);
        }
        for (i=[0 : cycles]) {
            translate([0, i*((depth-slice)/cycles), 0]) cube([width, slice, height]);
            echo(i=i);
        }
    }
    for (i=[0 : cycles]) {
        translate([i*((width-slice)/cycles), 0, 0]) cube([slice, depth, height]);
        echo(i=i);
    }
    for (i=[0 : cycles]) {
        translate([0, i*((depth-slice)/cycles), 0]) cube([width, slice, height]);
        echo(i=i);
    }
}