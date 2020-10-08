extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	move_and_slide(Vector2(0, 20))



func _on_HurtBox_area_shape_entered(area_id, area, area_shape, self_shape):
	print("from slime ", area_id)
	print("from slime ", area)
	print("from slime ", area_shape)
	get_node("dead").visible = true
	get_node("standing").visible = false
	get_node("CollisionShape2D").disabled = true
