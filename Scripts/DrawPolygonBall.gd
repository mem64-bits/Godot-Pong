extends Polygon2D

var points = []
const SEGMENTS = 256 # bigger number = more accurate circle
const RADIUS = 8

#function to draw circle from polygon with given num of points and radius
func _ready():
	for i in range(SEGMENTS):
		var angle = (TAU / SEGMENTS) * i
		points.append(Vector2(cos(angle), sin(angle)) * RADIUS)
	polygon = points
