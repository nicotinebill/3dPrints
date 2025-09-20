$fn = 200;
cube_size = 5;
num_magnets = 16;
spiral_radius = 40;
spiral_pitch = 1;

module cube_magnet() {
    cube(cube_size, center=true);
}

module magnet_track(side) {
    for(i = [0 : num_magnets-1]) {
        theta = 360 * i / num_magnets * pow(-1, side);  // Change in angle around the sphere (latitude)
        phi = 180 * i / num_magnets + 180 * side;  // Change in angle from top to bottom of the sphere (longitude)

        x = (spiral_radius-2.5) * cos(theta) * sin(phi);
        y = (spiral_radius-2.5) * sin(theta) * sin(phi);
        z = (spiral_radius-2.5) * cos(phi);
        
        // Now apply rotation in order to have a cube face pointing towards the sphere center
        // First, rotate around the Y axis, then Z, then X.
        translate([x, y, z])
        rotate([0, phi-90, theta])
        cube(cube_size + 0.1, center = true);
    }
}

difference() {
    sphere(r = spiral_radius);
    sphere(r = spiral_radius - 7);
    magnet_track(0);
    magnet_track(1);
}