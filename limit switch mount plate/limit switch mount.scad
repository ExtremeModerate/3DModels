//Base plate for mounting a limit switch to 1" alumunum tubing (or whatever)
// switch we use is https://www.omron.com/ecb/products/sw/11/v.html
// we're just tapping the switch holes for an m3 bolt

in=24.5;

//base that attaches to frame
bl=1*in;
bw=2*in;
bh=in/8;	//thickness
bhl=bl/2;
bhw=1.5*in;
bhd = 5;		//hole diameter

//switch mount
sl=38;
sw=19;
sh=in/16;		//make this > 0 if the switch should sit higher than the base plate

//switch mount holes
//change these to match your switch hole positions
//these are in mm width and will be from the center of the plate
shl=22.2;
shw=10.3;
shd=2.85;

difference() {
	union() {
		cube([bl, bw, bh]);
		translate([bl/2-sl/2, bw/2-sw/2, 0]) cube([sl, sw, bh+sh]);
	}
	$fn=20;
	translate([bl/2, bw/2-bhw/2, 0]) cylinder(d=bhd, h=bh);
	translate([bl/2, bw/2+bhw/2, 0]) cylinder(d=bhd, h=bh);
	translate([bl/2-sl/2, bw/2-sw/2, 0])	
		union() {
			for (i=[[sl/2-shl/2, sw/2-shw/2], [sl/2+shl/2, sw/2-shw/2], [sl/2-shl/2, sw/2+shw/2], [sl/2+shl/2, sw/2+shw/2]]){
				translate(i) cylinder(d=shd, h=bh+sh);
			}
		}
}
