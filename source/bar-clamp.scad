// Prusa Mendel
// bar clamp
// Used for joining 8mm threaded or unthreaded rods
// GNU GPL v3
// David Tangye
// DavidTangye@gmail.com
// http://DavidTangye.info
// http://github.com/DavidTangye/PrusaMendelDT

// Filament required: 782.1mm (5.5cm3)

include <PrusaMendelDT-global.scad>

// Main adjustments - all assume mm.
Height = 19;	// Adjust for strength: 12 - 35, recommend 15 - 25
DonutThickness = 4; // Adjust for strength :recommend 5 - 7
JawGap = 1.5; // Adjust: the wider the gap the more the jaw will be flexed/deformed by nuts
yHoleLoose = 0.4; // 0 = requires to be screwed in, 0.4 slides over threaded rod
zHoleLoose = 0.25; // 0 = needs to be prized open, 0.2 = firm

Faces = 40; // Adjust for smoothness
$fn = Faces;

// These should not need changing for Prusas
CrossBarGap = 2.0; // Standard for Prusas
zHoleD = M8Diam + zHoleLoose;
yHoleD = M8Diam + yHoleLoose;

// Miscellaneous variables
yDim = (2 * DonutThickness) + zHoleD; // Total y dimension


module barClamp() {
//	translate([yDim / 2,0,Height / 2])
	difference(){
		union(){
			cylinder(h = Height, r = yDim / 2, center = true);
			translate([0, -yDim / 2, -Height / 2])
				cube([(zHoleD + yHoleD) / 2 + CrossBarGap,yDim,Height]);
			translate([zHoleD / 2 + CrossBarGap + (0.65 * yHoleD), yDim / 2, 0])
				rotate([90, 0, 0])
				nut(Height,yDim,false);
		}
		cylinder(h = 2 * Xtra + Height, r = zHoleD / 2, center = true);
		translate([0, -(JawGap) / 2, -Height / 2 - Xtra])
			cube([zHoleD + CrossBarGap + Height,JawGap,2 * Xtra + Height], center=false);
		translate([(zHoleD + yHoleD) / 2 + CrossBarGap, -yDim / 2 - Xtra, 0])
			rotate([270, 0, 0])
			cylinder(h = 2 * Xtra + yDim, r = yHoleD / 2);
	}
}

module oldbarclamp(){
outer_diameter = (threaded_rod_diameter-0.0)/2+2.4;

difference(){
	union(){
		translate([outer_diameter, outer_diameter, 0])
			cylinder(h = outer_diameter*2, r = outer_diameter, $fn = 20);
		translate([outer_diameter, 0, 0])
			cube([outer_diameter+1.5,outer_diameter*2,outer_diameter*2]);
		translate([18, 2*outer_diameter, outer_diameter])
			rotate([90, 0, 0])
			nut(outer_diameter*2,outer_diameter*2,false);
	}
	translate([outer_diameter, outer_diameter, -1])
		%cylinder(h =20, r = threaded_rod_diameter/2-0.4, $fn = 18);
	translate([18, outer_diameter, 9])
		cube([18,05,20], center=true);
	translate([17, 17, 7.5])
		rotate([90, 0, 0])
		%cylinder(h = 17 + (1.5 * DonutThickness) + yDim, r = threaded_rod_diameter/2, $fn = 20);
}
}

translate([0,0,Height / 2]) barClamp();


/*
 TESTING: Turn this on to verify visually that the new barclamp
 has the same CrossBarGap as the old one.
*/
// translate([-6.75,0.5 * yDim + DonutThickness,Height / 2 - 7.6]) oldbarclamp(); 

