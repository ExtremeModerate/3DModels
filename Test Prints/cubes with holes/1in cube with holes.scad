in=25.4;
l=in/2;
d=0.5+l/2;

echo(l=l);
echo(d=d);

$fn=30;
difference() {
    cube(l,l,l, center=true);
    cylinder(d=d, h=l*2, center=true);
    rotate([90, 0, 0])     cylinder(d=d, h=l*2, center=true);
    rotate([0, 90, 0])     cylinder(d=d, h=l*2, center=true);
}
