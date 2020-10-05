extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#Center Window
	OS.set_window_position(OS.get_screen_size(0) * 0.5 - OS.get_window_size() * 0.5)
	
	get_tree().change_scene("res://GameScene.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
