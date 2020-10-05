extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HurtBox_area_entered(area):
	print("ow")
	get_node("dead").visible = true
	get_node("standing").visible = false
	pass # Replace with function body.


func _on_HurtBox_area_shape_entered(area_id, area, area_shape, self_shape):
	print("oof")
	get_node("dead").visible = true
	get_node("standing").visible = false
	pass # Replace with function body.
