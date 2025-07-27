extends Node2D
#This is a scene specific version of the GameStateManager to control things only accessible from a scene

# --- References to Objects in GameWindow --- #
@onready var player_paddle = $PlayerPaddle/Paddle
@onready var enemy_paddle = $EnemyPaddle/Paddle
@onready var ball = $Ball/BallPhysics


#Resets game objects using references to the objects
func on_reset_positions() -> void:
	print("Reseting Game State....")
	player_paddle.resetPaddlePos()
	enemy_paddle.resetPaddlePos()
	ball.resetBall()
	
func on_player_scored() -> void:
	GameState.player_score += 1
	GameState.printScore()
	GameState.score_updated.emit(GameState.player_score,GameState.enemy_score)
	
func on_enemy_scored() -> void:
	GameState.enemy_score += 1
	GameState.printScore()
	GameState.score_updated.emit(GameState.player_score,GameState.enemy_score)
