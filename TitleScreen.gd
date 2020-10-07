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


func _on_HSlider_value_changed(value):
	$BackgroundMusic.volume_db = linear2db(value)
