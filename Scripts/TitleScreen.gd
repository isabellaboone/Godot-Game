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
