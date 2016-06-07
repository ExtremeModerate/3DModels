module hex_shaft(diam=1, length=1, orientation=[0,0,0]){
    hexDiam = 2*tan(30)*diam;     //the diamiter of the points of the hex shaft, it's only 1/2" to the flat sides
    cylinder(d=hexDiam, h=length, $fn=6);
}

in=25.4;
shaft=0.5*in;
length=4*in;
depth=3;
difference() {
rotate([0,0,90]) rotate([90,0,0]) hex_shaft(shaft, length); //99% of actual shaft diameter
translate([length/2,0,shaft/2-depth]) 
    # linear_extrude(height=depth) {
        text("Team 4026 Breakaway Shaft!", size=shaft/3, halign="center", valign="center");
    }
}
