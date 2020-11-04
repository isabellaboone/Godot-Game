extends Node

var player
var coins = 0
var musicvol = 1.0
var soundvol = 1.0

func pickup_coin():
	coins += 1
	check_win()
	
func pickup_coins(many):
	coins += many
	check_win()

func spend_coins(total):
	if(total > coins):
		print("cannot afford")
	else:
		coins -= total

# 
func check_win():
	if(coins == 1):
		print("win")
		get_tree().change_scene("res://Scenes/WinScreen.tscn")
