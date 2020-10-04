extends Node2D

var player = preload("res://Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Center Window
	OS.set_window_position(OS.get_screen_size(0) * 0.5 - OS.get_window_size() * 0.5)
	var player = player.instance()
	add_child(player)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
