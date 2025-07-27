extends Node2D

#Loads next scene in advance for smoother transition
const gameScreen = preload("res://Scenes/GameWindow.tscn")
#Gets scene nodes to be controlled and manipulated
@onready var fade_anim = $CanvasLayer/TransitionPanel/FadeTransition
@onready var transition_panel = $CanvasLayer/TransitionPanel

func _ready() -> void:
	#Blocks input to stop user from pressing quit button
	transition_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_start_button_pressed() -> void:
	print("Start Button Pressed")
	#Blocks input to stop user from pressing quit button
	transition_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	
	#Loads custom animation on ColorRect
	fade_anim.play("FadeToBlack")
	
	#Runs a connecting function on function completion
	fade_anim.animation_finished.connect(_on_fade_complete)

	
func _on_fade_complete(anim_name: String) -> void:
	#Checks if ani finsihed is FadeToBlack
	if anim_name == "FadeToBlack":
		#Changes to main preloaded game scene
		get_tree().change_scene_to_packed(gameScreen)

#Listens for signal from Quit Button and ends game if press signal is sent
func _on_quit_button_pressed() -> void:
	print("Quit Button Pressed")
	#Quits game
	get_tree().quit()
