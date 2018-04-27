
$fn = 512; // Resolution of curves

// Method to draw rod with hex holes
module draw_rod_hex(length, width, holeradius) {
    difference() {
        union() {
            translate([0,-width/2,0]){square([length,width]);}
            translate([0,0,0])circle(r=width/2);
            translate([length,0,0])circle(r=width/2);
        }
        
        translate([0,0,0])hex(r=holeradius);
        translate([length,0,0])hex(r=holeradius);
    }
    
}

// Test draw rod with hex holes
draw_rod_hex(40,20,5);

// Method to draw rod with hex holes
module draw_rod_flat(length, width, holeradius, flat) {
    difference() {
        union() {
            translate([0,-width/2,0]){square([length,width]);}
            translate([0,0,0])circle(r=width/2);
            translate([length,0,0])circle(r=width/2);
        }
        
        translate([0,0,0])flat_circle(r=holeradius, flat=flat);
        translate([length,0,0])flat_circle(r=holeradius, flat=flat);
    }
    
}

// Test draw rod with flat circle holes
translate([0,30,0]) {
    draw_rod_flat(40,20,4,1);
}

// Method to draw a circle with a flat edge
module flat_circle(r, flat) {
  difference(r) {
    circle(r);
    translate([-r,r-flat,0]){
      square([r*2,r*2]);
    }
  }
}

// Test draw circle with a flat edge
translate([-30,30,0]) { flat_circle(10, 2); }

// Method to draw hex
module hex(r) {
    dx = sin(30);
    dy = cos(30);
    polygon(points=[[-r,0],[-dx*r,dy*r],[dx*r,dy*r],
                    [r,0],[dx*r,-dy*r],[-dx*r,-dy*r]]);
}

// Test draw hex
translate([-30,0,0]) { hex(10); }
