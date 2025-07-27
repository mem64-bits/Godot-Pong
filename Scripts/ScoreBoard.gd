extends RichTextLabel

#connect update_score function to the GameState singleton global score_updated signal 
func _ready() -> void:
	GameState.score_updated.connect(update_score)
	#Sets initial score to 0 - 0
	update_score(10,10)
	
func update_score(new_player_score: int, new_enemy_score: int):
	#Updates score with String formatted text
	text = str(new_player_score)+" - "+str(new_enemy_score)
