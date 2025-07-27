extends CharacterBody2D
class_name BallPhysics

var target_speed = GameState.ball_start_speed
var bounce_count = 0
var ball_speed = GameState.ball_start_speed

#Flag to ensure no weird behaviour happens when resetting ball
var ball_resetting = false 

# Tracks how long ball has been offscreen to reset in the event of the ball being lost
var ball_offscreen: float = 0.0
const MAX_OFFSCREEN_TIME = 2.0

func getBounceCount():
	return bounce_count	
	
func increaseBounceCount():
	bounce_count += 1

func resetBall():
	ball_resetting = true
	ball_speed = GameState.ball_start_speed
	target_speed = GameState.ball_start_speed
	bounce_count = 0
	#Makes sure ball can't move no speed + direction = no movement (dx, dy)
	velocity = Vector2.ZERO
	#Puts ball in starting pos in the middle of the screen
	global_position = get_viewport_rect().size / 2
	
	#pauses the game loop for 0.5 seconds
	await get_tree().create_timer(0.5).timeout
	moveBall()
	ball_resetting = false

#Moves the ball on the scene loading
func _ready() -> void:
	moveBall()
	
func moveBall():
	#Calls new Godot 4 randomiser like Random rd = new Random(); in java
	var rng = RandomNumberGenerator.new()
	
	#Randomises velocity vector for the ball
	var x_dir = 1.0 if rng.randf() < 0.5 else -1.0 # ball can go left or right
	var y_dir = rng.randf_range(-1.0, 1.0)
	
	#Sets ball of in a random starting direction going at set speed 
	velocity = Vector2(x_dir, y_dir).normalized() * GameState.ball_start_speed
		

func _physics_process(delta: float) -> void:
	# Flag to make sure ball can only interact with collision once per frame
	var touched_collision: bool = false
	if ball_resetting:
		return # Don't do anything while the ball is resetting
		
	# --- Handle Continuous Acceleration ---
	# On every frame, smoothly move the current_speed toward the target_speed.
	# we can use the in built function move_toward(from, to, delta).
	
	if ball_speed < target_speed:
		ball_speed = move_toward(ball_speed, target_speed, GameState.ball_acceleration * delta)

	#Updates velocity to use current_speed
	velocity = velocity.normalized() * ball_speed
	var collision = move_and_collide(velocity * delta)
	
	# --- Handle Collisions ---
	if collision:
		touched_collision = true
		print("touched_collision = ",touched_collision)
		#Gets class name of colliding object
		var collider = collision.get_collider()
	
		# Check if the collider is a Wall
		if collider.is_in_group("Walls") and touched_collision: # Using groups is better than using names
			print("Ball Bounced off a wall")
			# Use the collision normal to get a perfect bounce angle (better than reversing x velocity)
			velocity = velocity.bounce(collision.get_normal())

		# Check if the collider is a Paddle
		if collider is BasePaddle and touched_collision:
			increaseBounceCount()
			collider.deflectBall(self)
			
			# If we hit a paddle and have enough bounces, set a new target speed.
			if bounce_count >= 3:
				bounce_count = 0 
				# Set the new target, but don't go over the max speed.
				#Handy godot in bulit function to stop target_speed from going over limit
				target_speed = min(ball_speed + GameState.ball_speed_step, GameState.ball_max_speed)
				print("New target speed set to: ", target_speed)
