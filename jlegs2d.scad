$fn = 512; // resolution of curves

scale = 3.7794; // scaling factor for SVG output (other numbers in millimeters)

a = 38   * scale;
b = 41.5 * scale;
c = 39.3 * scale;
d = 40.1 * scale;
e = 55.8 * scale;
f = 39.4 * scale;
g = 36.7 * scale;
h = 65.7 * scale;
i = 49.0 * scale;
j = 50.0 * scale;
k = 61.9 * scale;
l = 7.8  * scale;
m = 15.0 * scale;

width = 10 * scale;
holeradius = 2.5 * scale;

module bar(length, width, holeradius) {
    difference() {
        union() {
            translate([0,-width/2,0]){square([length,width]);}
            
            translate([0,0,0])circle(r=width/2);
            
            translate([length,0,0])circle(r=width/2);
        }
        
        translate([0,0,0])circle(r=holeradius);
        
        translate([length,0,0])circle(r=holeradius);
    }
}

module triangle(lengths, width, holeradius) {
    a = lengths[1];
    b = lengths[2];
    c = lengths[0];
    ab = acos((pow(a,2) + pow(b,2) - pow(c,2)) / (2 * a * b));
    bc = acos((-pow(a,2) + pow(b,2) + pow(c,2)) / (2 * b * c));
    ac = acos((pow(a,2) - pow(b,2) + pow(c,2)) / (2 * a * c));
    
    bar(c, width, holeradius);
    
    translate([0,0,0]){rotate([0,0,bc]){bar(b, width, holeradius);}}
    
    translate([c,0,0]){rotate([0,0,ab+bc]){bar(a, width, holeradius);}}
}

module oneleg() {
    translate([0,0,0]){rotate([0,0,0]){
        triangle([b,e,d],width,holeradius);
    }}

    translate([60 * scale,40 * scale,0]){ rotate([0,0,180]) {
        triangle([g,h,i],width,holeradius);
    }}

    translate([0,55 * scale,0]){rotate([0,0,0]){
        bar(c, width, holeradius);
    }}
    translate([0,70 * scale,0]){rotate([0,0,0]){
        bar(f, width, holeradius);
    }}
    translate([0,85 * scale,0]){rotate([0,0,0]){
        bar(j, width, holeradius);
    }}
    translate([0,100 * scale,10]){rotate([0,0,0]){
        bar(k, width, holeradius);
    }}
    translate([50 * scale,55 * scale,10]){rotate([0,0,0]){
        bar(m, width, holeradius);
    }}
    translate([50 * scale,70 * scale,10]){rotate([0,0,0]){
        bar(0, width, holeradius);
    }}
}

module frame() {
    hyp = pow(pow(a,2) + pow(l,2),1/2);

    triangle([a*2,hyp,hyp], width, holeradius);
    rotate([0,0,90]){bar(b+width, width, holeradius);}
    translate([a*2,0,0]){rotate([0,0,90]){bar(b+width, width, holeradius);}}
    translate([0,b+width,0]){bar(a*2,width,holeradius);}
}

oneleg();
frame();