
def add_outer_radius(p, outerRadius, angle)
  res = Geom::Point3d.new(p[0] + Math.cos(angle * Math::PI) * outerRadius, 
                          p[1] + Math.sin(angle * Math::PI) * outerRadius, 
					      0)
  return res
end 

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


def create_rod(sPoint, a)
  pts = []
  pts[0] = sPoint
  pts[1] = Geom::Point3d.new(sPoint[0] + a, sPoint[1], sPoint[2])
  return pts
end

# Part specifications
$holeRadius = mm(1)
$outerRadius = mm(5)


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

### TEST DATA BELOW ###

# Create rectangle
pts = []
sx = 0 
ex = 10
sy = 0
ey = 10
sz = 0

pts[0] = Geom::Point3d.new(sx, sy, sz)
pts[1] = Geom::Point3d.new(ex, sy, sz)
pts[2] = Geom::Point3d.new(ex, ey, sz)
#pts[3] = Geom::Point3d.new(sx, ey, sz)


