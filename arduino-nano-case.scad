nano_width = 0.73*25.4;
nano_length = 1.7*25.4;
nano_height = 1.7;
hole = 1.6;
hole_ed = 0.6 + hole/2;
$fn=50;

module nano() {
    difference() {
	cube([nano_width, nano_length, nano_height]);
	translate([hole_ed, hole_ed, -5]) cylinder(10, d=hole);
	translate([nano_width - hole_ed, hole_ed, -5]) cylinder(10, d=hole);
	translate([hole_ed, nano_length - hole_ed, -5]) cylinder(10, d=hole);
	translate([nano_width - hole_ed, nano_length - hole_ed, -5]) cylinder(10, d=hole);
    }
    translate([(nano_width - 7.6)/2, -1.3, nano_height]) cube([7.6, 9.2, 3.86]);
}

module stand() {
    translate([0,0, -3]) cylinder(h=3, d=hole*1.5);
    translate([0,0, -1]) cylinder(h=3, d=hole*0.8);
}

module stands() {
    translate([hole_ed, hole_ed, 0]) stand();
    translate([nano_width - hole_ed, hole_ed, 0]) stand();
    translate([hole_ed, nano_length - hole_ed, 0]) stand();
    translate([nano_width - hole_ed, nano_length - hole_ed, 0]) stand();
}

module bottom_half() {
    stands();
    translate([-3, -3, -5]) difference() {
	cube([nano_width + 6, nano_length + 6, nano_height + 7 + 3]); // outer shell
	translate([2,2,2]) cube([nano_width + 2, nano_length + 2, nano_height + 7 + 10]); // inner space
	translate([1,1,nano_height+8]) cube([nano_width + 4, nano_length + 4, nano_height + 7 + 10]); // clip
	translate([(nano_width + 6 - 9)/2, -5, nano_height + 7 + 2 - 4.5]) cube([9, 10, 10]); // hole for usb
	translate([3 + hole_ed - hole*0.6, 3 + hole_ed + hole, -1]) cube([hole*1.2, nano_length - 2*hole - 2*hole_ed, 10]); // hole for pins left
	translate([nano_width + 3 - (hole_ed + hole*0.6), 3 + hole_ed + hole, -1]) cube([hole*1.2, nano_length - 2*hole - 2*hole_ed, 10]); // hole for pins right

    }
}

module top_half() {
    translate([-2, -2, nano_height + 3]) difference() {
	union() {
	    translate([-1, -1, 2]) cube([nano_width + 6, nano_length + 6, 2]);
	    cube([nano_width + 4, nano_length + 4, 3]);
	}
	translate([(nano_width+4-9)/2, -2, 0]) cube([9, 10, 2]);
	translate([1,1,0]) cube([nano_width + 2, nano_length + 2, 2]);
    }
    translate([hole_ed - hole/2, hole_ed - hole/2, 4-nano_height]) cube([hole, hole, nano_height + 4]);
    translate([nano_width - hole_ed - hole/2, hole_ed - hole/2, 4-nano_height]) cube([hole, hole, nano_height + 4]);
    translate([nano_width - hole_ed - hole/2, nano_length - hole_ed - hole/2, 4-nano_height]) cube([hole, hole, nano_height + 4]);
    translate([hole_ed - hole/2, nano_length - hole_ed - hole/2, 4-nano_height]) cube([hole, hole, nano_height + 4]);
}
