extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var JUMP_COUNT = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		JUMP_COUNT = 0
	
	if Input.is_action_just_pressed("jump") and JUMP_COUNT < 2:
		velocity.y = JUMP_VELOCITY
		JUMP_COUNT += 1
		var air = "air %s"
		var air1 = air % JUMP_COUNT
		print(air1)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			animated_sprite.play("Jump")
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		if velocity.y < 0:
			animated_sprite.play("Jump")
		elif velocity.y > 0:
			animated_sprite.play("Idle")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	move_and_slide()
