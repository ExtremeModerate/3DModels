in=25.4;
width=3.5*in;
depth=2.5*in+10;
height=0.15*in; //maximum height
base=2;   //height of base
cycles=5;   //how many full cos cycles in the space
slice=0.4; //desired resolution of each slice

//45, 10

module wavesolid(size=[1,1,1], cycles=1, base=0,  slice=0.4) {
    width=size[0];
    depth=size[1];
    height=size[2];
    xRes=width/slice;

    translate([0, depth, 0])
    rotate([90, 0, 0])
    linear_extrude(depth, scale=[1,0.25]) {
        union() {
            square([width, base+.2]);
            polygon([ for (i = [0 : 1 : xRes]) [ i*slice, base+height-height*cos((360*cycles)*i/xRes) ] ]);
            }
    }
}

difference() {
    wavesolid([width, depth, height], cycles=cycles, base=base, slice=slice);
    for (i=[(width-35)/2, (width+35)/2]) {
        #rotate([-30,0,0]) translate([i, 0]) cylinder(d=10, h=height*4);
        echo(i=i);
    }
}

*intersection() {
    wavesolid([width, width, height], 5);
    translate([width, 0, 0]) rotate([0,0,45]) wavesolid([width, width, height], 5);
}

