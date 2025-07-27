extends BasePaddle

# --- GET THE BALL ---
@onready var ball: BallPhysics = get_tree().get_first_node_in_group("ball_group")

# --- NEW: TUNEABLE AI BEHAVIOR ---
@export_category("AI Behavior")
# Controls how fast the AI glides to its target. Higher = faster.
@export var ai_responsiveness: float = 7.0
# Controls how fast the AI returns to the center.
@export var idle_speed: float = 2.0


# --- PHYSICS PROCESS (REFACTORED FOR LERP) ---
func _physics_process(delta: float):
	var target_y: float # A variable to hold our goal position
	var current_speed: float # A variable to hold our current speed factor

	# --- 1. DECIDE THE TARGET AND SPEED ---
	# The AI's "brain" simply decides what to do, it doesn't move yet.
	if ball.global_position.x > halfway_point:
		# ATTACK MODE: Target the ball and be responsive.
		target_y = ball.global_position.y
		current_speed = ai_responsiveness
	else:
		# IDLE MODE: Target the screen's center and be slow.
		target_y = get_viewport_rect().size.y / 2.0
		current_speed = idle_speed
	
	# --- 2. EXECUTE MOVEMENT ---
	# This single line of code replaces all the if/elif movement blocks.
	# It smoothly interpolates our current position towards the target position.
	global_position.y = lerp(global_position.y, target_y, current_speed * delta)
	
	# --- 3. FINAL CLAMPING ---
	# The lerp is powerful, but we must still make sure it never
	# pushes the paddle off-screen, especially at the start.
	global_position.y = clamp(global_position.y, half_height, getWinHeight() - half_height)
