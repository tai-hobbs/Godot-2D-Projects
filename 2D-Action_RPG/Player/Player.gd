extends KinematicBody2D

const ACCELERATION = 200
const MAX_SPEED = 75
const FRICTION = 800

var velocity = Vector2.ZERO

onready var animPlayer = $AnimationPlayer

func _physics_process(delta):
	move_player(delta)

# controls the movement for the player
func move_player(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#Ensures that the player moves at the same speed as they do when traveling left and right
	input_vector = input_vector.normalized() 
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animPlayer.play("runRight")
		else:
			animPlayer.play("runLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animPlayer.play("idleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

		
