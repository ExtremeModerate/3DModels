//Banebots P80 Gearbox
//Front mounting plate

use <MCAD/boxes.scad>;
use <crosshair.scad>;

plate = 62.5;
thick = 1;
mountInset = 2;
in = 25.4;
cornerRadius = (5/16) * in/2; 
sideRadius = (3/16) * in/2;
centerRadius = (3/4) * in/2;
lineWidth = 1;

//

sidePos = (plate/2) - mountInset - sideRadius;
cornerPos = (plate/2) - mountInset - cornerRadius;

difference() {
    roundedBox([plate, plate, thick], 5, true);
    linear_extrude(height=thick, center=true) {
        union() {
            //crosshair([0, 0, 0], centerRadius*2, lineWidth);
            rotate([0,0,45]) crosshair([0, 0, 0], centerRadius*2, lineWidth);
            crosshair([sidePos, 0, 0], sideRadius*2, lineWidth);
            crosshair([-sidePos, 0, 0], sideRadius*2, lineWidth);
            crosshair([0,sidePos, 0], sideRadius*2, lineWidth);
            crosshair([0,-sidePos, 0], sideRadius*2, lineWidth);
            for (x=[-cornerPos, cornerPos], y=[-cornerPos, cornerPos]) {
                crosshair([x, y, 0], cornerRadius*2, lineWidth);
            }
        }
    }
}

//2mm in from edge