extends Control

func _ready(): 
	$BackgroundMusic.play()

func _on_Music_value_changed(value):
	print(value)
	print(linear2db(value))
	globals.musicvol = value
	$BackgroundMusic.volume_db = linear2db(globals.musicvol)

func _on_Audio_value_changed(value):
	globals.soundvol = value
	
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	if($BackgroundMusic.playing == true):
		$BackgroundMusic.playing = false

func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://Scenes/TutorialScene.tscn")
	
func _on_ExitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/CreditsScene.tscn")


func _on_player_input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("clicked")
		get_node("Menu/VBoxContainer/player/player sprite").play(randanimation())
	pass # Replace with function body.

#definitely a dumb way to do this
func randanimation(): 
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rand = rng.randi_range(0, 3)
	var names = ["default", "duck punch", "run", "tippy toes"]
	print(rand)
	print(rand[names])
	return names[rand]
