extends Node2D

# The _draw() function is a special Godot function.
# Anything inside it will be rendered visually for this node.
# In the NEW CenterLine.gd script

# ... (exported variables) ...
# By using @export, we can change these values directly in the Godot editor!
@export var line_color: Color = Color(1, 1, 1, 0.5) # White, 50% transparent
@export var line_width: float = 5.0
@export var dash_length: float = 20.0
@export var gap_length: float = 15.0
@export var antialiased: bool = true


# This _draw() function is filled with code and is essential
func _draw():
	var screen_size = get_viewport_rect().size
	var x_position = screen_size.x / 2.0
	var current_y = 0.0
	
	while current_y < screen_size.y:
		var start_point = Vector2(x_position, current_y)
		var end_point = Vector2(x_position, current_y + dash_length)
		draw_line(start_point, end_point, line_color, line_width, antialiased)
		current_y += dash_length + gap_length
