extends Control


func _on_PlayButton_pressed():
	print("Play")
	get_tree().change_scene("res://GameScene.tscn")
	
func _on_HowToPlayButton_pressed():
	print("How to play")
	
func _on_ExitButton_pressed():
	print("Exit")
