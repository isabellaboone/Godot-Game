extends Control

func _on_PlayButton_pressed():
	print("Play")
	get_tree().change_scene("res://GameScene.tscn")
	if($BackgroundMusic.playing == true):
		$BackgroundMusic.playing = false
	
func _on_HowToPlayButton_pressed():
	print("How to play")
	get_tree().change_scene("res://TutorialScene.tscn")
	
func _on_ExitButton_pressed():
	print("Exit")
	get_tree().quit()

func _ready(): 
	$BackgroundMusic.play()


func _on_Music_value_changed(value):
	print(value)
	print(linear2db(value))
	globals.musicvol = value
	$BackgroundMusic.volume_db = linear2db(globals.musicvol)


func _on_Audio_value_changed(value):
	globals.soundvol = value


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Credits.tscn")
