extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = 25

var velocity = Vector2.ZERO

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
		velocity += input_vector * ACCELERATION * delta
		#Sets a speed limit for the player
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_collide(velocity)
		
