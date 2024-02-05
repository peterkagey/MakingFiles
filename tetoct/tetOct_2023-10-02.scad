size = 10;
x = size * 1.001;
b = size * 0.04;
oPts = [
    [ 0,  0,  x],
    [ 0,  0, -x],
    [ x,  0,  0],
    [-x,  0,  0],
    [ 0,  x,  0],
    [ 0, -x,  0]
];
octFaces = [
    [ 4 , 2, 0],
    [ 3 , 4, 0],
    [ 5 , 3, 0],
    [ 2 , 5, 0],
    [ 5 , 2, 1],
    [ 3 , 5, 1],
    [ 4 , 3, 1],
    [ 2 , 4, 1]
];
ltPts = [[x,0,x],[x,x,0],[0,x,x],[0,0,0]];
rtPts = [[0,x,0],[0,0,x],[x,0,0],[x,x,x]];
tetFaces = [
    [2,1,0],
    [3,0,1],
    [0,3,2],
    [1,2,3]
];
rtetFaces = [
    [0,1,2],
    [1,0,3],
    [2,3,0],
    [3,2,1]
];

module tube(v1,v2) {
    x1 = v1[0]; y1 = v1[1]; z1 = v1[2];
    x2 = v2[0]; y2 = v2[1]; z2 = v2[2];
    x3 = x2 - x1;
    y3 = y2 - y1;
    z3 = z2 - z1;
    rho = sqrt(x3^2 + y3^2 + z3^2);
    theta = atan2(y3, x3);
    phi = acos(z3 / rho);
    translate(v1)
    rotate([phi,0,theta+90]) cylinder(rho,b,b,$fn=30);
    translate(v1) sphere(b);
    translate(v2) sphere(b);
}



module octahedron(x,y,z) {
    translate([size*x/2,size*y/2,size*z/2]) 
    polyhedron(points=oPts, faces=octFaces);
}

module octahedronSkeleton(x,y,z) {
    points = oPts;
    translate([size*x/2,size*y/2,size*z/2]) {
        union() {
            tube(oPts[0],oPts[2]);
            tube(oPts[0],oPts[3]);
            tube(oPts[0],oPts[4]);
            tube(oPts[0],oPts[5]);
            tube(oPts[1],oPts[2]);
            tube(oPts[1],oPts[3]);
            tube(oPts[1],oPts[4]);
            tube(oPts[1],oPts[5]);
            tube(oPts[2],oPts[4]);
            tube(oPts[2],oPts[5]);
            tube(oPts[3],oPts[4]);
            tube(oPts[3],oPts[5]);
        }
    }
}

module bezeledOctahedron(x,y,z) {
    difference() {
        octahedron(x,y,z);
        octahedronSkeleton(x,y,z);
    }
}



module LTetrahedron(x, y, z) {
    translate([size*(x-1)/2,size*(y-1)/2,size*(z-1)/2])
    polyhedron(ltPts, tetFaces);
}

module RTetrahedron(x, y, z) {
    translate([size*(x-1)/2,size*(y-1)/2,size*(z-1)/2])
    polyhedron(rtPts, rtetFaces);
}

module LTetrahedronSkeleton(x, y, z) {
    translate([size*(x-1)/2,size*(y-1)/2,size*(z-1)/2]) {
        union() {
            tube(ltPts[0],ltPts[1]);
            tube(ltPts[0],ltPts[2]);
            tube(ltPts[0],ltPts[3]);
            tube(ltPts[1],ltPts[2]);
            tube(ltPts[1],ltPts[3]);
            tube(ltPts[2],ltPts[3]);
        }
    }
}

module RTetrahedronSkeleton(x, y, z) {
    translate([size*(x-1)/2,size*(y-1)/2,size*(z-1)/2]) {
        union() {
            tube(rtPts[0],rtPts[1]);
            tube(rtPts[0],rtPts[2]);
            tube(rtPts[0],rtPts[3]);
            tube(rtPts[1],rtPts[2]);
            tube(rtPts[1],rtPts[3]);
            tube(rtPts[2],rtPts[3]);
        }
    }
}

module bezeledLTetrahedron(x,y,z) {
    difference() {
        LTetrahedron(x,y,z);
        LTetrahedronSkeleton(x,y,z);
    }
}

module bezeledRTetrahedron(x,y,z) {
    difference() {
        RTetrahedron(x,y,z);
        RTetrahedronSkeleton(x,y,z);
    }
}

//bezeledOctahedron(0,0,0); bezeledOctahedron(0,2,2); bezeledOctahedron(2,0,2); bezeledRTetrahedron(1,1,1); // 1
//bezeledOctahedron(0,0,0); bezeledOctahedron(0,2,2); bezeledRTetrahedron(1,1,1); bezeledRTetrahedron(1,3,3); // 2
//bezeledOctahedron(0,0,0); bezeledOctahedron(0,2,2); bezeledRTetrahedron(1,1,1); bezeledLTetrahedron(1,1,3); // 3
// bezeledOctahedron(0,0,2); bezeledOctahedron(2,2,2); bezeledRTetrahedron(1,1,3); bezeledRTetrahedron(1,3,1); // 4
//bezeledOctahedron(0,0,2); bezeledOctahedron(2,2,2); bezeledRTetrahedron(1,1,3); bezeledLTetrahedron(1,1,1); // 5
//bezeledOctahedron(0,0,2); bezeledOctahedron(2,2,2); bezeledRTetrahedron(1,1,3); bezeledLTetrahedron(3,3,1); // 6
//bezeledOctahedron(0,2,2); bezeledRTetrahedron(1,1,1); bezeledRTetrahedron(1,3,3); bezeledLTetrahedron(1,1,3); // 7
//bezeledOctahedron(2,2,2); bezeledRTetrahedron(1,1,3); bezeledRTetrahedron(1,3,1); bezeledRTetrahedron(3,1,1); // 8
bezeledOctahedron(2,2,2); bezeledRTetrahedron(1,1,3); bezeledRTetrahedron(1,3,1); bezeledLTetrahedron(3,1,3); // 9


//mirror([1,0,0]) {bezeledOctahedron(0,0,0); bezeledOctahedron(0,2,2); bezeledRTetrahedron(1,1,1); bezeledLTetrahedron(1,1,3);} // 3 flipped
//mirror([1,0,0]) {bezeledOctahedron(0,0,2); bezeledOctahedron(2,2,2); bezeledRTetrahedron(1,1,3); bezeledRTetrahedron(1,3,1);} // 4 flipped