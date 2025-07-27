extends BasePaddle

#function to calculate physics
func _physics_process(delta: float) -> void:
	queue_redraw()
	var direction := 0
	# -speed * delta(time) paddle moves up
	# +speed * delta(time) paddle moves down
	if(Input.is_action_pressed("Move Paddle Up")):
		direction -= 1
	if(Input.is_action_pressed("Move Paddle Down")):
		direction += 1
	movePaddle(direction,delta)
