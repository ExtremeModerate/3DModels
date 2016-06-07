f=1.75;  //filament diameter
l=120;  //length of tube
w=f*3;
h=f*2;
tick = 0.2;
s=5;

difference() {
    translate([0,0,0]) cube([l,w,h]);
    translate([0,(w-f)/2,h-f]) cube([l,f,f]);
    for (a =[s:s:l-s]) {
       # translate([a-tick/2, 0, h-tick]) cube([tick, w, tick]);
    }
}
