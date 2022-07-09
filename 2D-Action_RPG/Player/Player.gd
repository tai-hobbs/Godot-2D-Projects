extends KinematicBody2D

const ACCELERATION = 200
const MAX_SPEED = 75
const FRICTION = 800

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")

func _ready():
	animTree.active = true

func _physics_process(delta):
	match state:
		MOVE: 
			move_state(delta)
			
		ROLL: pass
		
		ATTACK: 
			attack_state(delta)
	
	
#Controls the movement for the player
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#Ensures that the player moves at the same speed as they do when traveling left and right
	input_vector = input_vector.normalized() 
	
	if input_vector != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", input_vector)
		animTree.set("parameters/Run/blend_position", input_vector)
		animTree.set("parameters/Attack/blend_position", input_vector)
		animState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	velocity = Vector2.ZERO
	animState.travel("Attack") 

func attack_anim_finished():
	state = MOVE
		
