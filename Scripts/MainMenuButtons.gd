extends Button

#Switches from main menu to the Main Game scene if start button is pressed
func _on_pressed() -> void:
	print("Start Button Pressed")

#Method Listening for signal sent by quit button if pressed
func _on_quit_button_pressed() -> void:
	print("Quitting Game.....")
	get_tree().quit() # quits the game
