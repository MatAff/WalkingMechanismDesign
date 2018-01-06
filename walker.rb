
# load "C:\\Users\\Mathijs\\Documents\\Projects\\2018 Walker design\\WalkingMechanismDesign\\walker.rb"

# Define useful global variables
$xaxis = Geom::Vector3d.new 1,0,0
$normVec = Geom::Vector3d.new(0,0,1)
$center = Geom::Point3d.new(0, 0, 0)

# Function to get adjacent points from vector 
def GetAdjacentPts(pts, i)
    res = []
    if (i == 0) 
      res[0] = pts[pts.length-1]
    else 
      res[0]= pts[i-1]
    end    
    res[1] = pts[i]
    if (i == pts.length-1) 
        res[2]= pts[0]
    else 
        res[2] = pts[i+1]
    end    
    return res
end

# Function to compute point at a certain radius away from a point
def add_outer_radius(p, outerRadius, angle)
  res = Geom::Point3d.new(p[0] + Math.cos(angle * Math::PI) * outerRadius, 
                          p[1] + Math.sin(angle * Math::PI) * outerRadius, 
                          0)
  return res
end 

# Function to determin the position of points of a triangle based on the length of the sides
def triangle_point(sPoint, a, b, c)
    pts = []
    pts[0] = sPoint
    pts[1] = Geom::Point3d.new(sPoint[0] + a, sPoint[1], sPoint[2])
    a = a.to_f
    b = b.to_f
    c = c.to_f
    dx = (b*b - c*c + a*a) / (2*a)
    dy = Math.sqrt(b*b - dx*dx)
    pts[2] = Geom::Point3d.new(sPoint[0] + dx, sPoint[1] + dy, sPoint[2])
    return pts
end

# Function to determine the start and end position of a rod based on its length
def create_rod(sPoint, a)
  pts = []
  pts[0] = sPoint
  pts[1] = Geom::Point3d.new(sPoint[0] + a, sPoint[1], sPoint[2])
  return pts
end

# Draw part based on a series of points (draws holes, curves on the corners, and connecting lines)
def draw_part(pts)

    # Draw holes
    for i in 0..(pts.length-1)
        draw_circle(pts[i], $normVec, $holeRadius)
    end
    
    # Loop through points
    for i in 0..(pts.length-1)
    
        # Get adjacent points
        adjPts = GetAdjacentPts(pts, i)
      
        # Compute start and end angles
        sAngle = angle_between_point_xy([adjPts[0],adjPts[1]])
        eAngle = angle_between_point_xy([adjPts[1],adjPts[2]])
        
        # Make adjustments
        sAngle = sAngle - 0.5
        eAngle = eAngle - 0.5
        if(eAngle < sAngle) 
            eAngle = eAngle + 2 
        end

        # Draw curves
        draw_curve(adjPts[1], $normVec, $xaxis, $outerRadius, sAngle * Math::PI, eAngle * Math::PI)

        # Draw lines 
        draw_line(add_outer_radius(adjPts[0],$outerRadius,sAngle),add_outer_radius(adjPts[1],$outerRadius,sAngle))
        
    end
    
end

# Draw spacer
def draw_spacer(p)
    # Hole and outer edge
    draw_circle(p, $normVec, $holeRadius)
    draw_circle(p, $normVec, $outerRadius)
end 

# Function to draw the wheel that powers the motion
def draw_wheel(center, dist)
    
    draw_circle(center, $normVec, $axelRadius)
    draw_circle(center, $normVec, dist + $outerRadius)
    attachPoint = Geom::Point3d.new(center[0] + dist, center[1], center[2])
    UI.messagebox attachPoint
    draw_circle(attachPoint, $normVec, $axelRadius)

end

# Part specifications
$holeRadius = mm(1)
$outerRadius = mm(5)
$axelRadius = mm(1)
$wheelRadius = mm(15.0) # Distance between the center of the wheel and the attachment point

# Bottom triangle
bottom = triangle_point($center, mm(65.7), mm(36.7), mm(49.0))
draw_part(bottom)

# Top triangle
$start = Geom::Point3d.new(0, mm(40), 0)
top = triangle_point($start, mm(55.8), mm(41.5), mm(40.1))
draw_part(top)

# f, c, k, and j connectors
draw_part(create_rod(Geom::Point3d.new(0, mm(85), 0), mm(39.4)))
draw_part(create_rod(Geom::Point3d.new(0, mm(100), 0), mm(39.3)))
draw_part(create_rod(Geom::Point3d.new(0, mm(115), 0), mm(61.9)))
draw_part(create_rod(Geom::Point3d.new(0, mm(130), 0), mm(50.0)))

# Spacer
draw_spacer(Geom::Point3d.new(0, mm(145), 0))

# Wheel
draw_wheel(Geom::Point3d.new(0, mm(175), 0), $wheelRadius)



