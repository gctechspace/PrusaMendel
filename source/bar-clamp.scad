// PRUSA Mendel  
// Bar clamp
// Used for joining 8mm rods
// GNU GPL v3
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 * @id bar-clamp
 * @name Bar clamp
 * @category Printed
 * @using 2 m8nut
 * @using 2 m8washer
 */ 

// Main adjustments - all assume mm.
Height = 25;	// Adjust for strength: 12 - 35, recommend 15 - 25
DonutThickness = 6; // Adjust for strength :recommend 5 - 7
JawTightness = 0.5; // Adjust: mm that the jaw reduces on the rod hole: 3 for new builds, 0.5 for replacements?
zHoleTightness = 0.5; // Adjust: mm (diameter) to reduce the hole to grip the threaded Rod. Old equivalent = 0.8

Faces = 20; // Adjust for smoothness

// These should not need changing for Prusas
CrossBarGap = 1.95; // Standard for Prusas
zHoleD = threaded_rod_diameter - zHoleTightness;
yHoleD = threaded_rod_diameter;

// Miscellaneous variables
yDim = (2 * DonutThickness) + zHoleD; // Total y dimension


module barClamp() {
//	translate([yDim / 2,0,Height / 2])
	difference(){
		union(){
			cylinder(h = Height, r = yDim / 2, center = true, $fn = Faces);
			translate([0, -yDim / 2, -Height / 2])
				cube([(zHoleD + yHoleD) / 2 + CrossBarGap,yDim,Height]);
			translate([zHoleD / 2 + CrossBarGap + (0.65 * yHoleD), yDim / 2, 0])
				rotate([90, 0, 0])
				nut(Height,yDim,true);
		}
		#cylinder(h = 2 * Xtra + Height, r = zHoleD / 2, center = true, $fn = Faces);
		translate([0, -(zHoleD - JawTightness) / 2, -Height / 2 - Xtra])
			cube([zHoleD + CrossBarGap + Height,zHoleD - JawTightness,2 * Xtra + Height], center=false);
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

