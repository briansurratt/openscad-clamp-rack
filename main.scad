$fn = $preview ? 32 : 128;

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

bar_thickness = 7;
bar_width = 20;
back_depth = 18;

head_width = 21;

finger_width = head_width;
finger_length = bar_width + 10;
finger_thickness = 15;


// this is the part that touches the wall
plate_thickness = back_depth - 2;
plate_height = 35 + finger_thickness;



support_length = finger_length  + plate_thickness;
support_thickness = 5;

number_of_clamps = 15;
number_of_fingers = number_of_clamps + 1;

total_length = (number_of_fingers * finger_width) + (number_of_clamps * bar_thickness);

echo(str("total_length: ", total_length /25.4, " inches"));

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

module vertical_plane() {
    translate([-back_depth-bar_thickness/2,-finger_width/2,0]) {
        cube(size=[plate_thickness, total_length, plate_height], center=false);
    }
}

module supports() {
    for (i=[0:number_of_fingers-1]) {
        translate([0, i * (finger_width  + bar_thickness), 0]) {
            support();
        }
    }
}

module clamp_rack() {
    horizontal_plane();
    vertical_plane();
    supports();
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


module screw_holes() {

    xTranslate = -back_depth-bar_thickness/2 + plate_thickness;
    zTranslate = plate_height/2;

    for (i=[0:number_of_clamps-1]) {
        translate([xTranslate,finger_width / 2 + bar_thickness / 2 + i * (finger_width  + bar_thickness),  zTranslate]) {
            rotate([0, 90, 0])             
            screw_hole(spec="#8-32", length=plate_thickness + 2 ,head="flat",counterbore=0,anchor=TOP);
        }
        
    }

}


difference() {
    clamp_rack();
    screw_holes();
}
