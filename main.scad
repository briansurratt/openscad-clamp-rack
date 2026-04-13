$fn = $preview ? 32 : 128;

include <threads-scad/threads.scad>

bar_thickness = 7;
bar_width = 20;
back_depth = 18;

head_width = 21;

finger_width = head_width;
finger_length = bar_width + 10;
finger_thickness = 15;


plate_thickness = back_depth - 2;
plate_height = 35 + finger_thickness;



support_length = finger_length  + plate_thickness;
support_thickness = 5;

number_of_clamps = 2;
number_of_fingers = number_of_clamps + 1;

total_length = (number_of_fingers * finger_width) + (number_of_clamps * bar_thickness);


module horizontal_plane() {

    linear_extrude(height=finger_thickness) {
        difference() {
            
            union(){

                translate([-back_depth/2-0.5,total_length/2-finger_width/2,0]) {
                    square(size=[bar_width, total_length], center=true);
                }

                for (i=[0:number_of_fingers-1]) {
                    translate([0,i * (finger_width  + bar_thickness),  0]) {
                        finger();
                    }
                }
            }


            for (i=[0:number_of_clamps-1]) {
                translate([0,finger_width / 2 + bar_thickness / 2 + i * (finger_width  + bar_thickness),  0]) {
                    circle(r=bar_thickness / 2);
                }
                
            }


        }
    }

}


horizontal_plane();
supports();

module supports() {

    for (i=[0:number_of_fingers-1]) {
        translate([0, i * (finger_width  + bar_thickness), 0]) {
            support();
        }
    }

}

module finger() {

    translate([finger_length/2, 0, 0]) 

    square(size=[finger_length, finger_width], center=true);
    translate([finger_length, 0, 0]) {
        circle(r=finger_width/2);    
    }

}

module support() {
    
    translate([-plate_thickness, support_thickness/2, 0]) {
        rotate([90,0,0]) {
            
            linear_extrude(height=support_thickness) {
                polygon(points=[
                    [0,0],
                    [support_length,0],
                    [support_length, finger_thickness],
                    [plate_thickness-5,plate_height],
                    [0,plate_height]]);
                }

        }
    
    }
    
}



#CountersunkClearanceHole(5, 8, [7,7,0], [0,0,0]);