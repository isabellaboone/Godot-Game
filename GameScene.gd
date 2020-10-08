extends Node2D

#var TileMap_scene = preload("res://TileMap.tscn")

var tileMap = preload("res://RandomTileMap.tscn")
var RandomTileMap = preload("res://RandomTileMap.gd")

var player_scene = preload("res://Player.tscn")
var fireslime_scene = preload("res://FireSlime.tscn")
var ui_scene = preload("res://UI.tscn")
var red_book_scene = preload("res://Red_Book.tscn")
var rat_npc_scene = preload("res://Rat_NPC.tscn")

var player
var npc
var red_book

var starting_pos = Vector2(32, 64)
var borders = Rect2(starting_pos.x/32, starting_pos.y/32, 28, 15)

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.coins = 0 # reset coins
	$BackgroundMusic.volume_db = linear2db(globals.musicvol)
	$BackgroundMusic.play()
	
	red_book = red_book_scene.instance()
	player = player_scene.instance()
	
	randomize()
	var walker = Walker.new(starting_pos/32, borders)#(red_book_pos/32), borders) #19, 11
	var map = walker.walk(300) #200
	#generateMap(walker, map)
	
	# trying to add book as goal
	var red_book_end = red_book_scene.instance()
	red_book_end.position = walker.get_end_room().pos*32
	#add_child(red_book)
	
	walker = Walker.new(walker.get_end_room().pos, borders)
	map += walker.walk(100)
	var new_end = walker.get_end_room().pos
	generateMap(walker,map)
	
	npc = rat_npc_scene.instance()
	npc.position = Vector2(100, 515)
	add_child(npc)
	
#	player = player_scene.instance()
	player.position = starting_pos
	add_child(player)
	
	var fireslime = fireslime_scene.instance()
	fireslime.position = Vector2(900, 531)
	add_child(fireslime)
	
	var fireslime2 = fireslime_scene.instance()
	fireslime2.position = Vector2(900, 370)
	add_child(fireslime2)
	
	var ui = ui_scene.instance()
	add_child(ui)
	
	# Add Books that give buffs eventually or whatever
	#red_book = red_book_scene.instance()
	red_book.position = walker.get_end_room().pos*32#Vector2(925, 240)
	add_child(red_book)
	
	add_child(red_book_end)
	
func _process(delta):
	if(red_book != null):
		if(red_book.picked_up == true):
			player.pick_up_book()
			remove_child(red_book)
			red_book = null
			globals.pickup_coin()
	
func _input(event): 
	if(Input.is_action_just_pressed("interact")):
		pass
	pass

func generateMap(walker, map):
	var randomtilemap = tileMap.instance()
	for location in map:
		randomtilemap.set_cellv(location, 22)
		var temp = Vector2(location.x, location.y+1)
		randomtilemap.set_cellv(temp, 22)
		temp = Vector2(location.x, location.y-1)
		randomtilemap.set_cellv(temp, 22)
		temp = Vector2(location.x+1, location.y)
		randomtilemap.set_cellv(temp, 22)
	randomtilemap.update_bitmask_region(borders.position, borders.end)
	walker.cleanTileMap(randomtilemap)
	add_child(randomtilemap)
