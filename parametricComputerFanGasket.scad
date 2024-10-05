$fn = 100;
module roundedCornersCube(x ,y ,z,r)
{
	hull()
	{
		translate([r,r,0])
			cylinder(h=z,r=r);
		
		translate([x-r,r,0])
			cylinder(h=z,r=r);

		translate([r,y-r,0])
			cylinder(h=z,r=r);
		
		translate([x-r,y-r,0])
			cylinder(h=z,r=r);
	}
}
//-----------IMPORTANT-----------
buffer=0.02; //to help with removing skin effects openSCAD previews, set to 0 when rendering and/or exporting the STL file.
//--------------------------------

screw_hole_size = 4.9; //diameter of the screw hole
hole_distance = 7.5; //distance of the screw hole's center from the edge of the fan chassis

thickness = 2; //thickness of the parts
fan_size = 140.1; //size of the fan
fan_inner_diameter = 136; //diameter of the inside of fan, used to calculate fan_wall_thickness
fan_wall_thickness=fan_size-fan_inner_diameter; //we need this measurement to create a slight "lip" over the fan chassis, it improves the gasket's fitting in my experience. Set fan_inner_diam=fan_size to remove.

insert_length = 5; //how tall the walls around the main body of the gasket should be

curving_radius = 3; //radius of the curved borders on the edges, arctic P14s have a 3mm curve radius


difference()
{
	union()
	{
		//create block
		translate([0,0,0])
			roundedCornersCube(fan_size+thickness*2, fan_size+thickness*2, thickness+insert_length, curving_radius);
		
		
		
	}
	
	//carve hole for putting fan in
	translate([thickness,thickness,thickness-buffer])
		roundedCornersCube(fan_size,fan_size,insert_length+2*buffer,curving_radius);
	
	//carve round hole for fan blade to push air
	translate([(thickness*2+fan_wall_thickness+fan_inner_diameter)/2,(thickness*2+fan_wall_thickness+fan_inner_diameter)/2,-buffer])
		cylinder(h=thickness+2*buffer,d=fan_inner_diameter);
	
	//create mounting holes
	translate([hole_distance+thickness,hole_distance+thickness,-buffer])
		cylinder(h=thickness+2*buffer,d=screw_hole_size);
	
	translate([(fan_size)-(hole_distance-thickness),hole_distance+thickness,-buffer])
		cylinder(h=thickness+2*buffer,d=screw_hole_size);
	
	translate([hole_distance+thickness,(fan_size)-(hole_distance-thickness),-buffer])
		cylinder(h=thickness+2*buffer,d=screw_hole_size);
	
	translate([(fan_size)-(hole_distance-thickness),(fan_size)-(hole_distance-thickness),-buffer])
		cylinder(h=thickness+2*buffer,d=screw_hole_size);
}
