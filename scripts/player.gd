extends CharacterBody2D


var SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var times_jumped = 0
var max_jumps = 2

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump = $Jump


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		times_jumped = 0

		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and times_jumped < 2:
		times_jumped += 1
		velocity.y = JUMP_VELOCITY
		jump.play()


	if Input.is_action_pressed("sprint"):
		SPEED = 180.0
	else:
		SPEED = 130.0
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	#Get the input direction : -1, 0, 1
	var direction = Input.get_axis("move left", "move right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")



	


	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
