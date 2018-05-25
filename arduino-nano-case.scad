nano_width = 0.73*25.4;
nano_length = 1.7*25.4;
nano_height = 1.7;
hole = 1.6;
hole_ed = 0.6 + hole/2;
usb_hole_width = 12;
$fn=50;

module nano() {
    difference() {
	cube([nano_width, nano_length, nano_height], center=true);
	translate([nano_width/2, nano_length/2, -5]) {
	    translate([-nano_width + hole_ed, -nano_length + hole_ed, 0]) cylinder(10, d=hole);
	    translate([ - hole_ed, -nano_length + hole_ed, 0]) cylinder(10, d=hole);
	    translate([-nano_width + hole_ed,  - hole_ed, 0]) cylinder(10, d=hole);
	    translate([- hole_ed, - hole_ed, 0]) cylinder(10, d=hole);
	}
    }
    translate([-7.6/2,-nano_length/2 - 1.7,nano_height/2]) cube([7.6, 9.2, 3.86]);
}

module stand() {
    cylinder(h=3, d=hole*1.5);
    translate([0,0,2]) cylinder(h=3, d=hole*0.6);
}

module bottom_half() {
    difference() {
	cube([nano_width + 6, nano_length + 6, nano_height + 10], center=true); // outer shell
	union() {
	    translate([0,0,1]) cube([nano_width + 2, nano_length + 2, nano_height + 8], center=true); // inner space
	    translate([0,0,nano_height/2 + 4 + 0.25]) cube([nano_width + 4, nano_length + 4, 2.5], center=true); // clip
	}
	translate([0, -nano_length/2, 5 ]) cube([usb_hole_width, 10, 10], center=true); // hole for usb
	translate([-nano_width/2 + hole_ed, 0, -4]) cube([hole*1.2, nano_length - 2*hole - 2*hole_ed, 4], center=true);
	translate([nano_width/2 - hole_ed, 0, -4]) cube([hole*1.2, nano_length - 2*hole - 2*hole_ed, 4], center=true);
	
	for (i = [-nano_length/2:nano_length/10:nano_length/2]) {
	    translate([0,i,-4]) cube([nano_width - 2.5*hole - 2*hole_ed, nano_length/5/3, 4], center=true);
	}
    }

    translate([nano_width/2, nano_length/2, -5 + 1]) {
	translate([-nano_width + hole_ed, -nano_length + hole_ed, 0]) stand();
	translate([ - hole_ed, -nano_length + hole_ed, 0]) stand();
	translate([-nano_width + hole_ed,  - hole_ed, 0]) stand();
	translate([- hole_ed, - hole_ed, 0]) stand();
    }
}

module top_stand() {
    cube([hole, hole, nano_height + 3.5], center=true);
}

module top_half() {
    translate([0,0, nano_height/2 + 5]) {
	difference() {
	    cube([nano_width + 6, nano_length + 6, 2], center =true);
	    cube([nano_width, nano_length - 2 - hole, 2.5], center=true);
	}
	translate([0, 0, -2]) difference() {
	    cube([nano_width + 4, nano_length + 4, 3], center=true);
	    cube([nano_width + 2, nano_length + 2, 4], center=true);
	    translate([0, -nano_length/2, 0]) cube([usb_hole_width, 10, 4], center=true);
	}

	translate([nano_width/2 - 1, nano_length/2 -1, -2]) top_stand();
	translate([-nano_width/2 + 1, nano_length/2 -1, -2]) top_stand();
	translate([-nano_width/2 + 1, -nano_length/2 +1, -2]) top_stand();
	translate([nano_width/2 - 1, -nano_length/2 +1, -2]) top_stand();
    }
}
