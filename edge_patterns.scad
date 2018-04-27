
$fn = 512; // Resolution of curves

// Method to draw pattern on edge
module edge_circles(length, r, s=1) {
    
    // Adjust radius
    rCor = length/(2 * round(length/(2*r)));
    nr = length/rCor;
    echo(rCor);
    
    difference() {
        
        // Draw square
        square([length, rCor]);
        
        // Take out bites (circles)
        for (i = [0 : nr]){
            echo(i);
            translate([i * (2 * rCor), (rCor * s), 0])
            circle(r=(rCor * s));
        }
    }
}

edge_circles(20,3,1.05);
