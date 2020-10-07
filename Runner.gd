extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#Center Window
	OS.set_window_position(OS.get_screen_size(0) * 0.5 - OS.get_window_size() * 0.5)
	
	# Change to Title Screen
	get_tree().change_scene("res://TitleScreen.tscn")
