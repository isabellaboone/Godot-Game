extends Area2D

var picked_up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlap = get_overlapping_bodies()
	if len(overlap) > 0:
		if (picked_up == false):
			if ($Pick_Up_SFX.playing == false):
				$Pick_Up_SFX.play()
				picked_up = true
				
