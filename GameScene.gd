extends Node2D

var TileMap_scene = preload("res://TileMap.tscn")
var player_scene = preload("res://Player.tscn")
var fireslime_scene = preload("res://FireSlime.tscn")
var ui_scene = preload("res://UI.tscn")
var red_book_scene = preload("res://Red_Book.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$BackgroundMusic.play()
	
	var tilemap = TileMap_scene.instance()
	add_child(tilemap)
	
	var player = player_scene.instance()
	add_child(player)
	
	var fireslime = fireslime_scene.instance()
	fireslime.position = Vector2(900, 531)
	add_child(fireslime)
	
	var fireslime2 = fireslime_scene.instance()
	fireslime2.position = Vector2(600, 531)
	add_child(fireslime2)
	
	var ui = ui_scene.instance()
	add_child(ui)
	
	# Add Books that give buffs eventually or whatever
	var red_book = red_book_scene.instance()
	red_book.position = Vector2(300, 525)
	add_child(red_book)
	
	

func _process(delta):
	pass;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
