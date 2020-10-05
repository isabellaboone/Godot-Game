extends KinematicBody2D

const GRAVITY = 4000
var velocity = Vector2()
export (int) var speed = 0
var max_speed = 300
var acceleration = 500
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	stand()
	pass # Replace with function body.

func get_input(delta): 
	velocity = Vector2()
	velocity.y += delta * GRAVITY
	
	#horizontal acceleration for smoother movement
	speed += acceleration * delta
	if speed > max_speed:
		speed = max_speed
	
	#moving check so stand() isnt called if another key is still being pressed
	moving = false
	
	# Move with WASD
	# Replace with input map eventually
	if Input.is_key_pressed(KEY_A): 
		run()
		velocity.x = -speed # 
		get_node("Run").flip_h = true
		get_node("Stand").flip_h = true
		get_node("dust_particle_left").emitting = true
	
	if Input.is_key_pressed(KEY_D):
		run()
		velocity.x = speed # 
		get_node("Run").flip_h = false
		get_node("Stand").flip_h = false
		get_node("dust_particle_right").emitting = true
	
	if Input.is_key_pressed(KEY_W):
		run()
		velocity.y = -speed*2 # 
	
	if Input.is_key_pressed(KEY_S):
		run()
		velocity.y += speed*2 # 
		
	if Input.is_action_just_released("ui_left"):
		if !moving:
			stand()
		
	if Input.is_action_just_released("ui_right"):
		if !moving:
			stand()
	
	if Input.is_action_just_released("ui_up"):
		if !moving:
			stand()
		
	if Input.is_action_just_released("ui_down"):
		if !moving: 
			stand()
	
	
	
func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

func run():
	moving = true
	get_node("Run").visible = true;
	get_node("Squat").visible = false;
	get_node("Stand").visible = false;
	get_node("Punch").visible = false;
	
func stand():
	moving = false
	speed = 0
	get_node("Run").visible = false;
	get_node("Squat").visible = false;
	get_node("Stand").visible = true;
	get_node("Punch").visible = false;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
