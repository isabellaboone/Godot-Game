extends KinematicBody2D

const GRAVITY = 8000
var velocity = Vector2()
export (int) var speed = 0
var max_speed = 300
var acceleration = 500
var moving = false

onready var run = get_node("Run")
onready var stand = get_node("Stand")
onready var squat = get_node("Squat")
onready var punch = get_node("Punch")

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
	
	# Move with WASD
	# Replace with input map eventually
	if Input.is_mouse_button_pressed(2):
			punch()
	else:
		moving = false
		if Input.is_key_pressed(KEY_A): 
			run()
			flipLeft()
			velocity.x = -speed # 
			get_node("dust_particle_left").emitting = true
			
		if Input.is_key_pressed(KEY_D):
			run()
			flipRight()
			velocity.x = speed # 
			get_node("dust_particle_right").emitting = true
			
		if Input.is_key_pressed(KEY_W):
			run()
			velocity.y = -speed*2 # 
		
		if Input.is_key_pressed(KEY_S):
			squat()
			#velocity.y += speed*2 # 
			
		if !moving: 
			stand()


func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

func run():
	moving = true
	run.visible = true;
	squat.visible = false;
	stand.visible = false;
	punch.visible = false;

func stand():
	moving = false
	speed = 0
	run.visible = false;
	squat.visible = false;
	stand.visible = true;
	get_node("Punch").visible = false;

func punch():
	velocity = Vector2(0, 0)
	run.visible = false;
	squat.visible = false;
	stand .visible = false;
	punch.visible = true
	get_node("Punch_HitBox/punch_collision").disabled = false
	punch.play();
	yield(punch, "animation_finished")
	get_node("Punch_HitBox/punch_collision").disabled = true

func flipLeft():
	run.flip_h = true
	stand.flip_h = true
	squat.flip_h = true
	punch.flip_h = true	

func flipRight():
	run.flip_h = false
	stand.flip_h = false
	squat.flip_h = false
	punch.flip_h = false

func squat():
	moving = true
	run.visible = false;
	squat.visible = true;
	stand.visible = false;
	punch.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Punch_HitBox_area_entered(area):
	pass # Replace with function body.


func _on_Punch_HitBox_area_shape_entered(area_id, area, area_shape, self_shape):
	print("attack!")
	print(area_id)
	print(area)
	pass # Replace with function body.
