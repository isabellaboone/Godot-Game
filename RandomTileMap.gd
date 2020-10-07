extends TileMap

class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
var borderss = Rect2(1, 1, 32, 17)

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
	var size = Vector2(randi() % 5 + 3, randi() % 5 + 3) # % 4 + 2
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






