extends Node
#Singleton Global Class for game

# --- Global Game Settings ---
@export_category("Game Rules")
@export var is_paused: bool = false

# changes games difficulty by tweaking ai, ball and paddle settings
enum DIFFICULTY_LVL {EASY, NORMAL, HARD }
@export var difficulty: DIFFICULTY_LVL = DIFFICULTY_LVL.NORMAL

# --- Ball RULEBOOK ---
# These variables define HOW the ball should behave.
# They are the "factory settings."
@export_category("Ball Rules")
@export var ball_start_speed: int = 400
@export var ball_speed_step: int = 100 # How much speed is added
@export var ball_max_speed: int = 1200
@export var ball_acceleration: int = 500

# We can add paddle settings here later too!
@export_category("Paddle Rules")
@export var paddle_speed: int = 500

# --- Signals ---
# These are special signals here for managing the game state.
signal pause_game
signal game_over
signal game_won

#This section controls the updating of the scoreboard
var player_score: int = 0
var enemy_score: int = 0
signal score_updated(player_score,enemy_score)


func printScore():
	print("Score: ",player_score," - ",enemy_score)
	
