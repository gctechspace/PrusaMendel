// Prusa Mendel  
// Configuration file
// GNU GPL v3
// David Tangye

Xtra = 0.1; // A minimal value to project contained objects out past their containing objects

// Linear bearing version
linear = false;
// set false for LM-8UU, true for LM-E-8UU (ignore if linear is set to false)
lme8uu = false;

// Material

M8Diam = 8;

//==================================================================================
// Common modules

module nut(d,h,horizontal){
	cornerdiameter =  (d / 2) / cos (180 / 6);
	cylinder(h = h, r = cornerdiameter, $fn = 6);
	if(horizontal){
		for(i = [1:6]){
			rotate([0,0,60*i])
			translate([-cornerdiameter-0.2,0,0])
			rotate([0,0,-45])
				cube(size = [2,2,h]);
		}
	}
}

// Based on nophead research
module polyhole(d,h) {
	n = max(round(2 * d),3);
	rotate([0,0,180])
		cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module roundcorner(diameter){
	difference(){
		cube(size = [diameter,diameter,99], center = false);
		translate(v = [diameter, diameter, 0])
			cylinder(h = 100, r=diameter, center=true);
	}
}

//==================================================================================
// JUNK

// Nuts and bolts

m8_diameter = 9;
m8_nut_diameter = 14.1;

m4_diameter = 4.5;
m4_nut_diameter = 9;

m3_diameter = 3.6;
m3_nut_diameter = 5.3;
m3_nut_diameter_horizontal = 6.1;
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;


// Bushing holder

bushing_core_diameter = smooth_bar_diameter;
bushing_material_thickness = 1;

// Motors

motor_shaft = 5.5;

thin_wall = 3;

