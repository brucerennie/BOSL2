//////////////////////////////////////////////////////////////////////
// LibFile: masks.scad
//   Masking shapes.
// Includes:
//   include <BOSL2/std.scad>
//////////////////////////////////////////////////////////////////////


// Section: Chamfer Masks


// Module: chamfer_edge_mask()
// Usage:
//   chamfer_edge_mask(l, chamfer, [excess]);
// Description:
//   Creates a shape that can be used to chamfer a 90 degree edge.
//   Difference it from the object to be chamfered.  The center of
//   the mask object should align exactly with the edge to be chamfered.
// Arguments:
//   l = Length of mask.
//   chamfer = Size of chamfer.
//   excess = The extra amount to add to the length of the mask so that it differences away from other shapes cleanly.  Default: `0.1`
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   chamfer_edge_mask(l=50, chamfer=10);
// Example:
//   difference() {
//       cube(50, anchor=BOTTOM+FRONT);
//       #chamfer_edge_mask(l=50, chamfer=10, orient=RIGHT);
//   }
// Example: Masking by Attachment
//   diff("mask")
//   cube(50, center=true) {
//       edge_mask(TOP+RIGHT)
//           #chamfer_edge_mask(l=50, chamfer=10);
//   }
module chamfer_edge_mask(l=1, chamfer=1, excess=0.1, anchor=CENTER, spin=0, orient=UP) {
    attachable(anchor,spin,orient, size=[chamfer*2, chamfer*2, l]) {
        cylinder(r=chamfer, h=l+excess, center=true, $fn=4);
        children();
    }
}


// Module: chamfer_corner_mask()
// Usage:
//   chamfer_corner_mask(chamfer);
// Description:
//   Creates a shape that can be used to chamfer a 90 degree corner.
//   Difference it from the object to be chamfered.  The center of
//   the mask object should align exactly with the corner to be chamfered.
// Arguments:
//   chamfer = Size of chamfer.
//   ---
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   chamfer_corner_mask(chamfer=10);
// Example:
//   difference() {
//       cuboid(50, chamfer=10, trimcorners=false);
//       move(25*[1,-1,1]) #chamfer_corner_mask(chamfer=10);
//   }
// Example: Masking by Attachment
//   diff("mask")
//   cuboid(100, chamfer=20, trimcorners=false) {
//       corner_mask(TOP+FWD+RIGHT)
//           chamfer_corner_mask(chamfer=20);
//   }
module chamfer_corner_mask(chamfer=1, anchor=CENTER, spin=0, orient=UP) {
    pts = 2 * chamfer * [
        [0,0,1], [1,0,0], [0,1,0], [-1,0,0], [0,-1,0], [0,0,-1]
    ];
    faces = [
        [0,2,1], [0,3,2], [0,4,3], [0,1,4], [5,1,2], [5,2,3], [5,3,4], [5,4,1]
    ];
    attachable(anchor,spin,orient, size=[4,4,4]*chamfer) {
        polyhedron(pts, faces, convexity=2);
        children();
    }
}


// Module: chamfer_cylinder_mask()
// Usage:
//   chamfer_cylinder_mask(r|d, chamfer, [ang], [from_end])
// Description:
//   Create a mask that can be used to bevel/chamfer the end of a cylindrical region.
//   Difference it from the end of the region to be chamfered.  The center of the mask
//   object should align exactly with the center of the end of the cylindrical region
//   to be chamfered.
// Arguments:
//   r = Radius of cylinder to chamfer.
//   d = Diameter of cylinder to chamfer. Use instead of r.
//   chamfer = Size of the edge chamfered, inset from edge. (Default: 0.25)
//   ang = Angle of chamfer in degrees from vertical.  (Default: 45)
//   from_end = If true, chamfer size is measured from end of cylinder.  If false, chamfer is measured outset from the radius of the cylinder.  (Default: false)
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   difference() {
//       cylinder(r=50, h=100, center=true);
//       up(50) #chamfer_cylinder_mask(r=50, chamfer=10);
//   }
// Example:
//   difference() {
//       cylinder(r=50, h=100, center=true);
//       up(50) chamfer_cylinder_mask(r=50, chamfer=10);
//   }
// Example: Masking by Attachment
module chamfer_cylinder_mask(r, d, chamfer=0.25, ang=45, from_end=false, anchor=CENTER, spin=0, orient=UP)
{
    r = get_radius(r=r, d=d, dflt=1);
    ch = from_end? chamfer : opp_ang_to_adj(chamfer,ang);
    attachable(anchor,spin,orient, r=r, l=ch*2) {
        difference() {
            cyl(r=r+chamfer, l=ch*2, anchor=CENTER);
            cyl(r=r, l=ch*3, chamfer=chamfer, chamfang=ang, from_end=from_end, anchor=TOP);
        }
        children();
    }
}



// Section: Rounding Masks

// Module: rounding_edge_mask()
// Usage:
//   rounding_edge_mask(l|h, r|d)
//   rounding_edge_mask(l|h, r1|d1, r2|d2)
// Description:
//   Creates a shape that can be used to round a vertical 90 degree edge.
//   Difference it from the object to be rounded.  The center of the mask
//   object should align exactly with the edge to be rounded.
// Arguments:
//   l = Length of mask.
//   r = Radius of the rounding.
//   r1 = Bottom radius of rounding.
//   r2 = Top radius of rounding.
//   d = Diameter of the rounding.
//   d1 = Bottom diameter of rounding.
//   d2 = Top diameter of rounding.
//   excess = Extra size for the mask.  Defaults: 0.1
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example(VPD=200,VPR=[55,0,120]):
//   rounding_edge_mask(l=50, r1=10, r2=25);
// Example:
//   difference() {
//       cube(size=100, center=false);
//       #rounding_edge_mask(l=100, r=25, orient=UP, anchor=BOTTOM);
//   }
// Example: Varying Rounding Radius
//   difference() {
//       cube(size=50, center=false);
//       #rounding_edge_mask(l=50, r1=25, r2=10, orient=UP, anchor=BOTTOM);
//   }
// Example: Masking by Attachment
//   diff("mask")
//   cube(100, center=true)
//       edge_mask(FRONT+RIGHT)
//           #rounding_edge_mask(l=$parent_size.z+0.01, r=25);
// Example: Multiple Masking by Attachment
//   diff("mask")
//   cube([80,90,100], center=true) {
//       let(p = $parent_size*1.01) {
//           edge_mask(TOP)
//               rounding_edge_mask(l=p.z, r=25);
//       }
//   }
module rounding_edge_mask(l, r, r1, r2, d, d1, d2, excess=0.1, anchor=CENTER, spin=0, orient=UP, h=undef)
{
    l = first_defined([l, h, 1]);
    r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1);
    sides = quantup(segs(max(r1,r2)),4);
    attachable(anchor,spin,orient, size=[2*r1,2*r1,l], size2=[2*r2,2*r2]) {
        if (r1<r2) {
            zflip() {
                linear_extrude(height=l, convexity=4, center=true, scale=r1/r2) {
                    difference() {
                        translate(-excess*[1,1]) square(r2+excess);
                        translate([r2,r2]) circle(r=r2, $fn=sides);
                    }
                }
            }
        } else {
            linear_extrude(height=l, convexity=4, center=true, scale=r2/r1) {
                difference() {
                    translate(-excess*[1,1]) square(r1+excess);
                    translate([r1,r1]) circle(r=r1, $fn=sides);
                }
            }
        }
        children();
    }
}


// Module: rounding_corner_mask()
// Usage:
//   rounding_corner_mask(r|d, [excess=], [style=]);
// Description:
//   Creates a shape that you can use to round 90 degree corners.
//   Difference it from the object to be rounded.  The center of the mask
//   object should align exactly with the corner to be rounded.
// Arguments:
//   r = Radius of corner rounding.
//   d = Diameter of corner rounding.
//   ---
//   excess = Extra size for the mask.  Defaults: 0.1
//   style = The style of the sphere cutout's construction. One of "orig", "aligned", "stagger", "octa", or "icosa".  Default: "octa"
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   rounding_corner_mask(r=20.0);
// Example:
//   difference() {
//       cube(size=[50, 60, 70], center=true);
//       translate([-25, -30, 35])
//           #rounding_corner_mask(r=20, spin=90, orient=DOWN);
//       translate([25, -30, 35])
//           #rounding_corner_mask(r=20, orient=DOWN);
//       translate([25, -30, -35])
//           #rounding_corner_mask(r=20, spin=90);
//   }
// Example: Masking by Attachment
//   diff("mask")
//   cube(size=[50, 60, 70]) {
//       corner_mask(TOP)
//           #rounding_corner_mask(r=20);
//   }
module rounding_corner_mask(r, d, style="octa", excess=0.1, anchor=CENTER, spin=0, orient=UP)
{
    r = get_radius(r=r, d=d, dflt=1);
    attachable(anchor,spin,orient, size=[2,2,2]*r) {
        difference() {
            translate(-excess*[1,1,1])
                cube(size=r+excess, center=false);
            translate([r,r,r])
                sphere(r=r, style=style);
        }
        children();
    }
}


// Module: rounding_angled_edge_mask()
// Usage:
//   rounding_angled_edge_mask(h, r|d, [ang]);
//   rounding_angled_edge_mask(h, r1|d1, r2|d2, [ang]);
// Description:
//   Creates a vertical mask that can be used to round the edge where two face meet, at any arbitrary
//   angle.  Difference it from the object to be rounded.  The center of the mask should align exactly
//   with the edge to be rounded.
// Arguments:
//   h = Height of vertical mask.
//   r = Radius of the rounding.
//   r1 = Bottom radius of rounding.
//   r2 = Top radius of rounding.
//   d = Diameter of the rounding.
//   d1 = Bottom diameter of rounding.
//   d2 = Top diameter of rounding.
//   ang = Angle that the planes meet at.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   difference() {
//       pie_slice(ang=70, h=50, d=100, center=true);
//       #rounding_angled_edge_mask(h=51, r=20.0, ang=70, $fn=32);
//   }
// Example: Varying Rounding Radius
//   difference() {
//       pie_slice(ang=70, h=50, d=100, center=true);
//       #rounding_angled_edge_mask(h=51, r1=10, r2=25, ang=70, $fn=32);
//   }
module rounding_angled_edge_mask(h=1.0, r, r1, r2, d, d1, d2, ang=90, anchor=CENTER, spin=0, orient=UP)
{
    function _mask_shape(r) = [
        for (i = [0:1:n]) let (a=90+ang+i*sweep/n) [r*cos(a)+x, r*sin(a)+r],
        for (i = [0:1:n]) let (a=90+i*sweep/n) [r*cos(a)+x, r*sin(a)-r],
        [min(-1, r*cos(270-ang)+x-1), r*sin(270-ang)-r],
        [min(-1, r*cos(90+ang)+x-1), r*sin(90+ang)+r],
    ];

    sweep = 180-ang;
    r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1);
    n = ceil(segs(max(r1,r2))*sweep/360);
    x = sin(90-(ang/2))/sin(ang/2) * (r1<r2? r2 : r1);
    if(r1<r2) {
        attachable(anchor,spin,orient, size=[2*x*r1/r2,2*r1,h], size2=[2*x,2*r2]) {
            zflip() {
                linear_extrude(height=h, convexity=4, center=true, scale=r1/r2) {
                    polygon(_mask_shape(r2));
                }
            }
            children();
        }
    } else {
        attachable(anchor,spin,orient, size=[2*x,2*r1,h], size2=[2*x*r2/r1,2*r2]) {
            linear_extrude(height=h, convexity=4, center=true, scale=r2/r1) {
                polygon(_mask_shape(r1));
            }
            children();
        }
    }
}


// Module: rounding_angled_corner_mask()
// Usage:
//   rounding_angled_corner_mask(r|d, ang);
// Description:
//   Creates a shape that can be used to round the corner of an angle.
//   Difference it from the object to be rounded.  The center of the mask
//   object should align exactly with the point of the corner to be rounded.
// Arguments:
//   r = Radius of the rounding.
//   d = Diameter of the rounding.
//   ang = Angle between planes that you need to round the corner of.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example(Med):
//   ang=60;
//   difference() {
//       pie_slice(ang=ang, h=50, r=200, center=true);
//       up(50/2) #rounding_angled_corner_mask(r=20, ang=ang);
//   }
module rounding_angled_corner_mask(r, ang=90, d, anchor=CENTER, spin=0, orient=UP)
{
    r = get_radius(r=r, d=d, dflt=1);
    dx = r / tan(ang/2);
    dx2 = dx / cos(ang/2) + 1;
    fn = quantup(segs(r), 4);
    attachable(anchor,spin,orient, d=dx2, l=2*r) {
        difference() {
            down(r) cylinder(r=dx2, h=r+1, center=false);
            yflip_copy() {
                translate([dx, r, -r]) {
                    hull() {
                        sphere(r=r, $fn=fn);
                        down(r*3) sphere(r=r, $fn=fn);
                        zrot_copies([0,ang]) {
                            right(r*3) sphere(r=r, $fn=fn);
                        }
                    }
                }
            }
        }
        children();
    }
}


// Module: rounding_cylinder_mask()
// Usage:
//   rounding_cylinder_mask(r|d, rounding);
// Description:
//   Create a mask that can be used to round the end of a cylinder.
//   Difference it from the cylinder to be rounded.  The center of the
//   mask object should align exactly with the center of the end of the
//   cylinder to be rounded.
// Arguments:
//   r = Radius of cylinder. (Default: 1.0)
//   d = Diameter of cylinder. (Default: 1.0)
//   rounding = Radius of the edge rounding. (Default: 0.25)
// Example:
//   difference() {
//     cylinder(r=50, h=50, center=false);
//     up(50) #rounding_cylinder_mask(r=50, rounding=10);
//   }
// Example:
//   difference() {
//     cylinder(r=50, h=50, center=false);
//     up(50) rounding_cylinder_mask(r=50, rounding=10);
//   }
// Example: Masking by Attachment
//   diff("mask")
//   cyl(h=30, d=30) {
//       attach(TOP)
//           #rounding_cylinder_mask(d=30, rounding=5, $tags="mask");
//   }
module rounding_cylinder_mask(r, rounding=0.25, d)
{
    r = get_radius(r=r, d=d, dflt=1);
    difference() {
        cyl(r=r+rounding, l=rounding*2, anchor=CENTER);
        cyl(r=r, l=rounding*3, rounding=rounding, anchor=TOP);
    }
}



// Module: rounding_hole_mask()
// Usage:
//   rounding_hole_mask(r|d, rounding, [excess]);
// Description:
//   Create a mask that can be used to round the edge of a circular hole.
//   Difference it from the hole to be rounded.  The center of the
//   mask object should align exactly with the center of the end of the
//   hole to be rounded.
// Arguments:
//   r = Radius of hole.
//   d = Diameter of hole to rounding.
//   rounding = Radius of the rounding. (Default: 0.25)
//   excess = The extra thickness of the mask.  Default: `0.1`.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   rounding_hole_mask(r=40, rounding=20, $fa=2, $fs=2);
// Example(Med):
//   difference() {
//     cube([150,150,100], center=true);
//     cylinder(r=50, h=100.1, center=true);
//     up(50) #rounding_hole_mask(r=50, rounding=10);
//   }
// Example(Med):
//   difference() {
//     cube([150,150,100], center=true);
//     cylinder(r=50, h=100.1, center=true);
//     up(50) rounding_hole_mask(r=50, rounding=10);
//   }
module rounding_hole_mask(r, rounding=0.25, excess=0.1, d, anchor=CENTER, spin=0, orient=UP)
{
    r = get_radius(r=r, d=d, dflt=1);
    attachable(anchor,spin,orient, r=r+rounding, l=2*rounding) {
        rotate_extrude(convexity=4) {
            difference() {
                right(r-excess) fwd(rounding) square(rounding+excess, center=false);
                right(r+rounding) fwd(rounding) circle(r=rounding);
            }
        }
        children();
    }
}


// Section: Teardrop Masking

// Module: teardrop_edge_mask()
// Usage:
//   teardrop_edge_mask(r|d, [angle], [excess]);
// Description:
//   Makes an apropriate 3D corner rounding mask that keeps within `angle` degrees of vertical.
// Arguments:
//   r = Radius of the mask rounding.
//   d = Diameter of the mask rounding.
//   angle = Maximum angle from vertical. Default: 45
//   excess = Excess mask size.  Default: 0.1
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example(VPD=50,VPR=[55,0,120]):
//   teardrop_edge_mask(l=20, r=10, angle=40);
// Example(VPD=300,VPR=[75,0,25]):
//   diff("mask")
//   cuboid([50,60,70],rounding=10,edges="Z",anchor=CENTER) {
//       edge_mask(BOT)
//           teardrop_edge_mask(l=max($parent_size)+1, r=10, angle=40);
//       corner_mask(BOT)
//           teardrop_corner_mask(r=10, angle=40);
//   }
module teardrop_edge_mask(l, r, angle, excess=0.1, d, anchor=CENTER, spin=0, orient=UP) {
    assert(is_num(l));
    assert(is_num(angle));
    assert(is_num(excess));
    assert(angle>0 && angle<90);
    r = get_radius(r=r, d=d, dflt=1);
    difference() {
        translate(-[1,1,0]*excess) cube([r+excess,r+excess,l], anchor=FWD+LEFT);
        translate([r,r,0]) teardrop(r=r, l=l+1, cap_h=r, ang=angle, orient=FWD);
    }
}


// Module: teardrop_corner_mask()
// Usage:
//   teardrop_corner_mask(r|d, [angle], [excess]);
// Description:
//   Makes an apropriate 3D corner rounding mask that keeps within `angle` degrees of vertical.
// Arguments:
//   r = Radius of the mask rounding.
//   d = Diameter of the mask rounding.
//   angle = Maximum angle from vertical. Default: 45
//   excess = Excess mask size.  Default: 0.1
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   teardrop_corner_mask(r=20, angle=40);
// Example:
//   diff("mask")
//   cuboid([50,60,70],rounding=10,edges="Z",anchor=CENTER) {
//       edge_profile(BOT)
//           mask2d_teardrop(r=10, angle=40);
//       corner_mask(BOT)
//           teardrop_corner_mask(r=10, angle=40);
//   }
module teardrop_corner_mask(r, angle, excess=0.1, d, anchor=CENTER, spin=0, orient=UP) {
    assert(is_num(angle));
    assert(is_num(excess));
    assert(angle>0 && angle<90);
    r = get_radius(r=r, d=d, dflt=1);
    difference() {
        translate(-[1,1,1]*excess) cube(r+excess, center=false);
        translate([1,1,1]*r) onion(r=r, ang=angle, orient=DOWN);
    }
}



// vim: expandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
