
//$fn = 512; // Resolution of curves

scale = 3.7794; // scaling factor for SVG output (other numbers in millimeters)

// Margin 
margin = 10 * scale;

// Overall dimensions
length = 160 * scale;
width = 70 * scale;
height = 120 * scale;
thick = 3 * scale;

// Side dimensions
sideTopThick = 20 * scale;
sideSideThick = 20 * scale;
sideBottomThick = 20 * scale;

// Front dimensions
frontTopThick = 20 * scale;
frontSideThick = 20 * scale;
frontBottomThick = 20 * scale;

// Top panel dimensions
topLength = 40 * scale;
holeRadius = 5 / 2 * scale;

// Notches
notchDistCorner = 10 * scale;
notchWidth = 20 * scale;

// Side panel module
module side_panel() {
    difference() {
        
        // Main shape
        square([length,height]);
        
        // Middle cut out  
        translate([sideSideThick,sideBottomThick,0]) {
            square([length - 2 * sideSideThick,
            height - sideTopThick - sideBottomThick]);
        };
        
        // Notches
        translate([notchDistCorner, 0, 0]) { 
            square([notchWidth,thick]); 
        };
        translate([length - notchDistCorner - notchWidth, 0, 0]) { 
            square([notchWidth,thick]); 
        };
        translate([notchDistCorner, height - thick, 0]) { 
            square([notchWidth,thick]); 
        };
        translate([length - notchDistCorner - notchWidth, height - thick, 0]) { 
            square([notchWidth,thick]); 
        };
        translate([0,notchDistCorner,0]) {
            square([thick,notchWidth]);
        };
        translate([0,height - notchDistCorner - notchWidth,0]) {
            square([thick,notchWidth]);
        };
        translate([length-thick,notchDistCorner,0]) {
            square([thick,notchWidth]);
        };
        translate([length-thick,height - notchDistCorner - notchWidth,0]) {
            square([thick,notchWidth]);
        };
    }
}

//side_panel();

// Method to draw front and back panels
module front_panel() {
    union() {
        difference() {
        
            // Main shape
            square([width - 2* thick,height]);
        
            // Middle cut out  
            translate([frontSideThick,frontBottomThick,0]) {
                square([width - 2 * thick - 2 * frontSideThick,
                height - frontTopThick - frontBottomThick]);
            };
            
            // Subtrackt notches
            translate([width / 2 - thick - notchWidth / 2,0,0]) {
                square([notchWidth,thick]);  
            };
            translate([width / 2 - thick - notchWidth / 2,height - thick,0]) {
                square([notchWidth,thick]);  
            };
        }
        
        // Add notches
        translate([-thick,notchDistCorner,0]) {
            square([thick,notchWidth]);
        };
        translate([width - 2 * thick,notchDistCorner,0]) {
            square([thick,notchWidth]);
        };
        translate([-thick,height - notchDistCorner - notchWidth,0]) {
            square([thick,notchWidth]);
        };
        translate([width - 2 * thick,height - notchDistCorner - notchWidth,0]) {
            square([thick,notchWidth]);
        };
        
    }
}

// Method to draw top
module top_panel() {
    union() {
        difference() {
        
            // Main shape
            square([width - 2 * thick,topLength - thick]);
            
            // hole
            translate([width / 2 - thick, topLength /2 - thick,0]) {
               circle(r=holeRadius);
            };
        }
        
        // Add notches
        translate([width / 2 - thick - notchWidth / 2, -thick, 0]) {
            square([notchWidth,thick]);
        };
        translate([- thick, 0 - thick + notchDistCorner,0]) {
            square([thick,notchWidth]);
        };
        translate([ width - 2 * thick, 0 - thick + notchDistCorner,0]) {
            square([thick,notchWidth]);
        };
    }
}

// Method to draw pattern on edge
module motor_housing() {

    // Side panel 1
    translate([0,0,0]) {
        side_panel();
    };
    
    // Side panel 2
    translate([length + margin,0,0]) {
       side_panel();
    };

    // Front panel
    translate([0,height + margin,0]) {
        front_panel();
    };
    
    // Top panel
    translate([0,height * 2 + margin *2,0]) {
        top_panel();
    };
}    
 
motor_housing();

//top_panel();