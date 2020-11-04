extends Node2D

var picked_up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Pick_Up_SFX.volume_db = linear2db(globals.soundvol)

func _input(event):
	if Input.is_action_just_pressed("pickup"):
		var bodies = $Area2D.get_overlapping_bodies()
		for b in bodies:
			if b.name == "Player" and picked_up == false:
				picked_up = true
				print("Player picked up book")
				if($Pick_Up_SFX.playing == false):
					$Pick_Up_SFX.play()
					
				$Explosion.emitting = true
				
