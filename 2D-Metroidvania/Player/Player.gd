extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 250
var maxSpeed = 500
var jump = 150
var gravity = 300


func _ready():
	pass # Replace with function body.

func _process(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if movement != 0:
		velocity.x += movement * speed * delta
		$AnimatedSprite.flip_h = movement < 0
		$AnimatedSprite.play("Walk")
	elif velocity.x == 0 && velocity.y < 0:
		$AnimatedSprite.play("Jump")
	elif velocity.x == 0 && velocity.y > 50:
		$AnimatedSprite.play("Fall")
	else:
		velocity.x = 0
		$AnimatedSprite.play("Idle")
	
	if is_on_floor() && Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jump
		$AnimatedSprite.play("Jump")
	elif velocity.y < 0 && velocity.x != 0:
		$AnimatedSprite.play("Jump")
	elif velocity.y > 50 && velocity.x !=0:
		$AnimatedSprite.play("Fall")
	
	#Implements a gravity effect
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)

