extends Node

var player
coins = 0

func pickup_coin():
	coin += 1
	
func pickup_coins(many)
	coin += many

func spend_coins(total)
 if(total > coins):
	print("cannot afford")
else:
	coins -= total
