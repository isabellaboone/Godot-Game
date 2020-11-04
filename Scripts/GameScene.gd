extends Node2D

#var TileMap_scene = preload("res://TileMap.tscn")

var tileMap = preload("res://Scenes/RandomTileMap.tscn")
var RandomTileMap = preload("res://Scripts/RandomTileMap.gd")

var player_scene = preload("res://Scenes/Player.tscn")
var fireslime_scene = preload("res://Scenes/FireSlime.tscn")
var ui_scene = preload("res://Scenes/UI.tscn")
var red_book_scene = preload("res://Scenes/Red_Book.tscn")
var rat_npc_scene = preload("res://Scenes/Rat_NPC.tscn")
var torch_scene = preload("res://Scenes/Torch.tscn")

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
	
	player = player_scene.instance()
	player.position = starting_pos
	
	randomize()
	var walker = Walker.new(starting_pos/32, borders)#(red_book_pos/32), borders) #19, 11
	var map = walker.walk(300) #200
	#generateMap(walker, map)
	
	# trying to add book as goal
	var red_book_end = red_book_scene.instance()
	red_book_end.position = walker.get_end_room().pos*32
	#add_child(red_book)
	
	walker = Walker.new(walker.get_end_room().pos, borders)
	map += walker.walk(20)
	#var new_end = walker.get_end_room().pos
	
	npc = rat_npc_scene.instance()
	npc.position = walker.get_end_room().pos*32
	npc.position.x += 16
	npc.position.y += 32
	
	walker = Walker.new(walker.get_end_room().pos, borders)
	map += walker.walk(100)
	
	var fireslime = fireslime_scene.instance()
	fireslime.position = walker.get_end_room().pos*32
	fireslime.position.x += 16
	fireslime.position.y += 16
	
	walker = Walker.new(walker.get_end_room().pos, borders)
	map += walker.walk(100)
	
	var fireslime2 = fireslime_scene.instance()
	fireslime2.position = walker.get_end_room().pos*32
	fireslime2.position.x += 16
	fireslime2.position.y += 16
	
	walker = Walker.new(walker.get_end_room().pos, borders)
	map += walker.walk(100)
	
	var ui = ui_scene.instance()
	
	# Add Books that give buffs eventually or whatever
	red_book = red_book_scene.instance()
	red_book.position = walker.get_end_room().pos*32#Vector2(925, 240)
	red_book.position.x += 16
	red_book.position.y += 48
	red_book_end.position.x += 16
	red_book_end.position.y += 48
	
	
	generateMap(walker,map)
	
	add_child(npc)
	add_child(player)
	add_child(fireslime)
	add_child(fireslime2)
	add_child(ui)
	add_child(red_book)
	add_child(red_book_end)
	
	var torch = torch_scene.instance()
	torch.position = Vector2(900, 200)
	add_child(torch)
	
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
