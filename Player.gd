extends KinematicBody2D

const GRAVITY = 10;
var velocity = Vector2()
export (int) var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	stand()
	pass # Replace with function body.

func get_input(delta): 
	velocity = Vector2()
	velocity.y += delta * GRAVITY
	
	# Move with WASD
	if Input.is_key_pressed(KEY_A): 
		run()
		velocity.x = -speed # 
		get_node("Run").flip_h = true
		get_node("dust_particle_left").emitting = true
	
	if Input.is_key_pressed(KEY_D):
		run()
		velocity.x = speed # 
		get_node("Run").flip_h = false
		get_node("dust_particle_right").emitting = true
	
	if Input.is_key_pressed(KEY_W):
		run()
		velocity.y = -speed*2 # 
	
	if Input.is_key_pressed(KEY_S):
		run()
		velocity.y = speed*2 # 
		
	if Input.is_action_just_released("ui_left"):
		stand()
		
	if Input.is_action_just_released("ui_right"):
		stand()
	
	if Input.is_action_just_released("ui_up"):
		stand()
		
	if Input.is_action_just_released("ui_down"):
		stand()
	
	
	
func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

func run():
	get_node("Run").visible = true;
	get_node("Squat").visible = false;
	get_node("Stand").visible = false;
	get_node("Punch").visible = false;
	
func stand():
	get_node("Run").visible = false;
	get_node("Squat").visible = false;
	get_node("Stand").visible = true;
	get_node("Punch").visible = false;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
