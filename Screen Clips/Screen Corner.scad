//window screen corners
in=25.4;

// long sides 19/32 x 5/64 x 2"
lsW = in*19/32;
lsH = in*5/64;
lsL = in*2;
lsCorner = lsW/4;

//corner square 3/4" x 3/4"
cW = in * 9/16;
cL = cW;
cH = in * 21/64;

//holding pins
pinBlockW = in * 33/64;    //width of pin block
pinGapW = in * 23/64;
pinL = .*(lsL-lsCorner);
pinH = in * 17/64;
pinStart = in * 7/8; //where do the pins start
pinW = in * 5/64;

// inner corner bit is 5/32" square 
icW = in*5/32;
icL = icW;
icH = lsH;
icD = 2*(cW-pinBlockW);

module long_sides() {
    linear_extrude(height=lsH) {
        polygon(points=[[0,0], 
            [lsL-lsCorner, 0], 
            [lsL, lsCorner], 
            [lsL, lsW-lsCorner],
            [lsL-lsCorner, lsW],
            [0, lsW],
            [0,0]],
            convexity=1);
    }
}

module pins() {
   difference() {
       cube([pinL, pinBlockW, pinH]);
       translate([pinStart, (pinBlockW-pinGapW)/2, 0]) cube([pinL-pinStart, pinGapW, pinH]);
      # translate([pinL-pinH, 0, pinH]) rotate([0, 30, 0]) cube([pinBlockW, pinBlockW, pinBlockW]);
   }
}

module corner() {
    union() {
        cube([cW, cL, cH]);
        cube([cW+icW, cL+icL, icH]);
    }
}

difference() {
    union() {
        long_sides();
        translate([lsW, 0, 0]) rotate([0,0,90]) long_sides();
        pins();
        translate([lsW-(pinBlockW-pinGapW)/2, 0, 0]) rotate([0,0,90]) pins();
        corner();
    }
    translate([cW, cL, lsH]) cylinder(d=icD, h=cH, $fn=30);  
}
