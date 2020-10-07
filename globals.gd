extends Node

var player
var coins = 0
var musicvol = 1.0
var soundvol = 1.0

func pickup_coin():
	coins += 1
	
func pickup_coins(many):
	coins += many

func spend_coins(total):
	if(total > coins):
		print("cannot afford")
	else:
		coins -= total
