extends KinematicBody2D

const GRAVITY = 3000
var velocity = Vector2()
export (int) var speed = 300
var moving = false
var damage = 5

onready var run = get_node("Run")
onready var stand = get_node("Stand")
onready var squat = get_node("Squat")
onready var punch = get_node("Punch")

var action = false

# Called when the node enters the scene tree for the first time.
func _ready():
	stand()
	$Punch_SFX.volume_db = linear2db(globals.soundvol)

func get_input(delta): 
	#velocity = Vector2()
	velocity.y += delta * GRAVITY
	

	# Move with WASD
	if action:
		pass
	elif Input.is_action_pressed("attack"):
			punch()
	else:
		#moving check so stand() isnt called if another key is still being pressed
		moving = false
		if Input.is_action_pressed("move_left"):
			run()
			flipLeft()
			velocity.x = -speed # 
			get_node("dust_particle_left").emitting = true
			
		if Input.is_action_pressed("move_right"):
			run()
			flipRight()
			velocity.x = speed # 
			get_node("dust_particle_right").emitting = true
			
		if Input.is_action_just_pressed("jump"):
			run()
			velocity.y = -speed*3 # 
		
		if Input.is_action_pressed(("down")):
			squat()
			#velocity.y += speed*2 # 
			
		if !moving: 
			stand()


func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

# Will look into animation trees to replace most of this implementation
####################
func run():
	moving = true
	run.visible = true;
	squat.visible = false;
	stand.visible = false;
	punch.visible = false;
	#action = true
	#run.play()
	#yield(run, "animation_finished")
	#action = false

func stand():
	moving = false
	velocity.x = 0
	run.visible = false;
	squat.visible = false;
	stand.visible = true;
	punch.visible = false;


func punch():
	velocity.x = velocity.x/3
	run.visible = false;
	squat.visible = false;
	stand .visible = false;
	punch.visible = true
	action = true
	get_node("Punch_HitBox/punch_collision").disabled = false
	# We could make this only play when it actually hits, but for now it works
	punch.play();
	yield(punch, "animation_finished")
	get_node("Punch_HitBox/punch_collision").disabled = true
	action = false

func flipLeft():
	run.flip_h = true
	stand.flip_h = true
	squat.flip_h = true
	punch.flip_h = true
	get_node("Punch_HitBox/punch_collision").position.x = 8

func flipRight():
	run.flip_h = false
	stand.flip_h = false
	squat.flip_h = false
	punch.flip_h = false
	get_node("Punch_HitBox/punch_collision").position.x = 38

func squat():
	moving = true
	run.visible = false;
	squat.visible = true;
	stand.visible = false;
	punch.visible = false;
#####################


func _on_Punch_HitBox_area_entered(area):
	pass # Replace with function body.


func _on_Punch_HitBox_area_shape_entered(area_id, area, area_shape, self_shape):
	if($Punch_SFX.playing == false):
		$Punch_SFX.play()
	print("attack!")
	print(area_id)
	print(area)

func pick_up_book():
	print("damage increased")
	damage += 1
