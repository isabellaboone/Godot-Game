extends Node2D

var BackgroundTile_scene = preload("res://BackgroundTiles.tscn")
var platform_scene = preload("res://Platform.tscn")
var player_scene = preload("res://Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in range(11):
		for j in range(19):
			var tile = BackgroundTile_scene.instance()
			tile.position = Vector2(96*i+48, 32*j+16)
			add_child(tile)	
	
	var platform = platform_scene.instance()
	#platform.position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	add_child(platform)
	
	var player = player_scene.instance()
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
