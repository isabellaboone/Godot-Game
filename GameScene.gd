extends Node2D

var platform_scene = preload("res://Platform.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	print("here")
	var platform = platform_scene.instance()
	platform.position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	add_child(platform)
	print("done")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
