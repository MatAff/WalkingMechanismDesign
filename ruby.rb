
# load "C:\\Users\\Mathijs\\Documents\\Projects\\2018 Walker design\\ruby.rb"

# Define useful global variables
$xaxis = Geom::Vector3d.new 1,0,0
$normVec = Geom::Vector3d.new(0,0,1)
$center = Geom::Point3d.new(0, 0, 0)

def draw_line(point1,point2)
    model = Sketchup.active_model    
    entities = model.active_entities   
    #point1 = Geom::Point3d.new(sx,sy,sz)
	#point2 = Geom::Point3d.new(ex,ey,ez)
	line = entities.add_line point1,point2
	if (!line)
        UI.messagebox "Line failure"
    end
end

def draw_circle(center,normVec,radius)
    entities = Sketchup.active_model.entities
    edgearray = entities.add_circle center, normVec, radius
    first_edge = edgearray[0]
    arccurve = first_edge.curve
end

def draw_curve(center,normVec,axisVec,radius,start_a,end_a)
    model = Sketchup.active_model
    entities = model.entities
    edge_array = entities.add_arc center, axisVec, normVec, radius, start_a, end_a
    edge = edge_array[0]
    arc_curve = edge.curve
    start_angle = arc_curve.start_angle
end 

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

def angle_between_point_xy(pts)
  # Return value 0-2
  
  # Split out points
  p0 = pts[0]
  p1 = pts[1]
  
  # Special cases
  if(p0[0] == p1[0] && p0[1] < p1[1] ) 
    angle = 0.5 
	return angle
  end
  if(p0[0] == p1[0] && p0[1] > p1[1] ) 
    angle = 1.5 
	return angle
  end
  
  # Compute delta and angle
  dy = p1[1] - p0[1]
  dx = p1[0] - p0[0]
  
  # Compute angle
  angle = Math.atan(dy.to_f/dx) / (Math::PI)
  
  # Adjust angle
  if (dx < 0)
    angle = angle + 1
  end 
  
  # return
  return angle

end

def mm(inchesIn)
    return inchesIn/2.54
end

def create_rod(sPoint, a)
  pts = []
  pts[0] = sPoint
  pts[1] = Geom::Point3d.new(sPoint[0] + a, sPoint[1], sPoint[2])
  return pts
end

# Test triangle
# pts = triangle_point($center,mm(10),mm(6),mm(6))
# draw_part(pts)

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






