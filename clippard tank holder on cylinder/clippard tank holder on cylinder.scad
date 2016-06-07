//bracket that slips over a pneumatic cylinder of size cyl_od
// and attaches 6 clippard tanks to it
// print 2, slip over cylinder 
in=25.4;
cyl_od = (2+1/4)*in;    //add extra for foam tape
h=.5*in;

tank_od = 2.5*in + in*1/8;  //add extra for foam tape
tank_space = .25*in;

zip=.25*in;
lip=2; // lip to hold on zip tie

$fn=50;
difference() {
union() {
    // create a spot for a zip tie
difference() {
    union() {
        cylinder(d=cyl_od+tank_space, h=h+zip);
        translate([0,0,h+zip]) cylinder(d=cyl_od+tank_space+lip, h=lip);
    }
    cylinder(d=cyl_od, h=h+zip+lip);
}

linear_extrude(h) {
    difference() {
        circle(d=cyl_od+tank_space+1.5*tank_od); // chop the whole thing
        
        circle(d=cyl_od);   //main cylinder
        
        for (a=[0:60:359]) {
            rotate([0,0,a]) 
                translate([(tank_od+tank_space), 0, 0])
                    circle(d=tank_od, h=h);
        }
    }
}
}
*translate([-(cyl_od+tank_od+tank_space)/2, -0.5, 0])
   # cube([(cyl_od+tank_od+tank_space), 1, h+zip+lip]);
}