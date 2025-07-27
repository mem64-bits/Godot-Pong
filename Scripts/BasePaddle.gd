# Java / C++ style of base class to inherit from
extends CharacterBody2D
class_name BasePaddle  #gives custom class name that can be accessed in editor

#Bool flag for detecting ball collision
var ball_touched  = false

#Offset height used to clamp paddle y pos to the screen
@onready var half_height = $PaddleCollision.shape.extents.y

#imaginary line to determine what paddle side to calculate from
var halfway_point  = getWinWidth() / 2.0

#moves paddle in a (+ / -) y postion for a specifed time eg 60fps
#alsos adds in built in paddle restriction

func movePaddle(direction: int, delta: float):
	position.y += direction * GameState.paddle_speed * delta
	# Clamp Y position so the paddle stays inside screen bounds
	global_position.y = clamp(global_position.y, half_height, getWinHeight() - half_height)


# Uses vector math to calculate the angle at which the ball should reflect.
func deflectBall(ball: CharacterBody2D): # Using CharacterBody2D is often more flexible.
	# Get the position of the ball relative to the paddle's center.
	var paddle_center = global_position
	var ball_center = ball.global_position

	# This breaks down the paddle into sections from -1 (bottom) to 1 (top).
	var relative = (paddle_center.y - ball_center.y) / half_height
	# Ensure that relative can never exceed the limits.
	relative = clamp(relative, -1.0, 1.0)

	# Determine the angle of reflection (max of 75°).
	# A negative angle is used here to correctly map the Y-direction in Godot's coordinate system.
	var angle = relative * -deg_to_rad(75)

	# The direction is determined by which paddle is hit.
	var direction = Vector2()
	if global_position.x < halfway_point:
		# Left paddle: Ball should go right.
		direction = Vector2(cos(angle), sin(angle))
	else:
		# Right paddle: Ball should go left.
		direction = Vector2(-cos(angle), sin(angle))
	print("Paddle deflected ball at an angle of: ",round(rad_to_deg(angle)),"°")


	# Apply the new velocity to the ball to create the "reflection" effect.
	ball.velocity = direction.normalized() * GameState.ball_start_speed

func resetPaddlePos():
	await get_tree().create_timer(0.5).timeout
	if global_position.x < halfway_point:
		global_position = Vector2(13.0,getWinHeight() / 2)
	else:
		global_position = Vector2(1187.0,getWinHeight() /2)
	

func getWinSize() -> Vector2:
	return DisplayServer.window_get_size()
			
func getWinHeight():
	return DisplayServer.window_get_size().y
	
func getWinWidth():
	return DisplayServer.window_get_size().x
