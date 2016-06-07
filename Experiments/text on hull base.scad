default_font = "Brush Script MT:style=Italic";
//default_font = "Chalkboard:style=Regular" ;
default_font = "Nanum Brush Script:style=Regular";

module text_on_base(txt="text", bh=1, th=2, f=default_font) {
	union() {
		linear_extrude(bh) hull() offset(r=1) text(txt, font=f);
		linear_extrude(bh+th) text(txt, font=f);
	}
}


module text_through_base(txt="text", bh=1, th=2, f=default_font) {
	difference() {
		linear_extrude(bh) hull() offset(r=1) text(txt, font=f);
		linear_extrude(bh+1) text(txt, font=f);
	}
}

text_on_base("Living Room");
//text_through_base("LIVING ROOM");