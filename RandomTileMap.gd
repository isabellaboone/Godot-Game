extends TileMap

class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
#var borderss = Rect2(1, 1, 32, 17)

var pos = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var steps_since_turn = 0
var rooms = []

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	pos = starting_position
	step_history.append(pos)
	borders = new_borders

func walk(steps):
	place_room(pos)
	for step in steps:
		if steps_since_turn >= 9: #6
			change_direction()
		
		if step():
			step_history.append(pos)
		else:
			change_direction()
	return step_history

func step():
	var target_position = pos + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		pos = target_position
		return true
	else:
		return false

func change_direction():
	place_room(pos)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(pos + direction):
		direction = directions.pop_front()

func create_room(pos, size):
	return {pos = pos, size = size}

func place_room(pos):
	var size = Vector2(randi() % 4 + 2, randi() % 4 + 2) # % 4 + 2
	var top_left_corner = (pos - size/2).ceil()
	rooms.append(create_room(pos, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)

func get_end_room():
	var end_room = rooms.pop_front()
	var starting_position = step_history.front()
	for room in rooms:
		if starting_position.distance_to(room.pos) > starting_position.distance_to(end_room.pos):
			end_room = room
	return end_room

var blankTile = 22
var dict = {"u": 10, "d" : 2, "l": 12, "r":15, "dl": 0, "ul": 8, "ur": 11,
"ulr": blankTile, "dlr": blankTile, "udlr":19, "udr": blankTile,
 "udl": blankTile, "ud": blankTile, "lr" : blankTile, "dr": 3}
var blanks = [blankTile, 19]

func cleanTileMap(tileMap):
	var used_cells = tileMap.get_used_cells()
	var check = 22
	for pos in used_cells:
		var x = pos.x
		var y = pos.y
		if x == 0 or x == 1:
			continue
		#print(tileMap.get_cell(x, y))
		if tileMap.get_cell(x, y) in blanks : 
			continue
		var temp = ""
		if(tileMap.get_cell(x, y-1) == check):
			temp += "u"
		if(tileMap.get_cell(x, y+1) == check):
			temp += "d"
		if(tileMap.get_cell(x-1, y) == check):
			temp += "l"
		if(tileMap.get_cell(x+1, y) == check):
			temp += "r"
		if temp != "":# and temp != "dr" and temp != "dl":
			tileMap.set_cellv(pos, dict[temp])
		print(temp)
		#var temp = Vector2(location.x, location.y+1)
		#randomtilemap.set_cellv(temp, 18)



