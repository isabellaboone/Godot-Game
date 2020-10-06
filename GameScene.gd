extends Node2D

var TileMap_scene = preload("res://TileMap.tscn")
var player_scene = preload("res://Player.tscn")
var fireslime_scene = preload("res://FireSlime.tscn")
var ui = preload("res://UI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var tilemap = TileMap_scene.instance()
	add_child(tilemap)
	
	var player = player_scene.instance()
	add_child(player)
	
	var fireslime = fireslime_scene.instance()
	fireslime.position = Vector2(900, 531)
	add_child(fireslime)
	
	var fireslime2 = fireslime_scene.instance()
	fireslime2.position = Vector2(800, 431)
	add_child(fireslime2)
	
	var uii = ui.instance()
	add_child(uii)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
