extends Area2D

#Signals allow for special messages to be sent to purpose built functions when 
# signals are emitted reducing code logic
signal player_scored
signal enemy_scored
signal reset_positions


#These Area2D functions send signals to The GameStateManager.gd script to be handled
func ball_entered_player_goal(body: Node2D) -> void:
	if body.is_in_group("ball_group") and not body.ball_resetting:
		emit_signal("enemy_scored")
		emit_signal("reset_positions")


func ball_entered_enemy_goal(body: Node2D) -> void:
	if body.is_in_group("ball_group") and not body.ball_resetting:
		emit_signal("player_scored")
		emit_signal("reset_positions")
