extends Node2D

#var border_scene = preload("res://Map/Border.tscn")
#var backgroundtile_scene = preload("res://Map/BackgroundTiles.tscn")
var TileMap_scene = preload("res://TileMap.tscn")
var player_scene = preload("res://Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var tilemap = TileMap_scene.instance()
	add_child(tilemap)
	

	var player = player_scene.instance()
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
