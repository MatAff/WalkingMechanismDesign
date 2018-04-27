
# load "C:\\Users\\Mathijs\\Documents\\Projects\\2018 Walker design\\WalkingMechanismDesign\\support.rb"

# This file contains support functions for designs generated in Sketch-Up in Ruby

# Function to draw a line between two points
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

# Function to draw a circle
def draw_circle(center,normVec,radius)
    entities = Sketchup.active_model.entities
    edgearray = entities.add_circle center, normVec, radius
    first_edge = edgearray[0]
    arccurve = first_edge.curve
end

# Function to draw part of a circle
def draw_curve(center,normVec,axisVec,radius,start_a,end_a)
    model = Sketchup.active_model
    entities = model.entities
    edge_array = entities.add_arc center, axisVec, normVec, radius, start_a, end_a
    edge = edge_array[0]
    arc_curve = edge.curve
    start_angle = arc_curve.start_angle
end 

# Function the angle between two points the x-axis
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

# Function to convert mm to inches
def mm(inVal)
    return inVal/2.54
end

