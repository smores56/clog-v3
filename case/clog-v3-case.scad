accuracy = 10;
pcb_offset = [-120, 65, 0];

case_thickness = 2;
pcb_thickness = 1.6;
switch_plate_thickness = 1.2;

case_hole_locations = [
    [24.5, -11.5],
    [60.3, -21.9],
    [67.5, -54.2],
    [-12.8, -48.9]
];
puck_hole_locations = [
    [23.3, 1.8],
    [4.2, -17.2],
    [23.3, -36.3],
    [42.3, -17.2]
];
all_hole_locations = concat(
    case_hole_locations, 
    puck_hole_locations
);

module pcb() {
    translate(pcb_offset)
    import("clog-v3-4-B_Cu.dxf", $fn=accuracy);
}

module holes() {
    translate(pcb_offset)
    import("clog-v3-B_Cu-2.dxf", $fn=accuracy);
}

module test_holes() {
    for (location =    all_hole_locations) {
        %
        translate([location[0],     location[1], 0])
        cylinder(10, r=0.1, $fn=accuracy);
    }
}

difference() {
    linear_extrude(2, center=true)
    offset(5)
    pcb();
    linear_extrude(4, center=true)
    offset(3)
    pcb();
}
