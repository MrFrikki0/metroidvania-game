extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var JUMP_COUNT: int = 0
var health: int = 100
var dead: bool = false
var jumping: bool
var attacking: bool
var can_attack_1: bool = true
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer: Timer = $DeathTimer
@onready var attack_1_timer: Timer = $Attack_1Timer
@onready var kill_zone: Area2D = $attack_1/KillZone
@onready var attack_1: Node2D = $attack_1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if health > 0:
		# Handle jump.
		if is_on_floor():
			JUMP_COUNT = 0
		if Input.is_action_just_pressed("attack_1") and can_attack_1:
			attacking = true
			can_attack_1 = false
			animated_sprite.play("Attack_2")
			kill_zone.set_monitoring(true)
			attack_1_timer.start()
		else:
			kill_zone.set_monitoring(false)
			
		if Input.is_action_just_pressed("jump") and JUMP_COUNT < 2:
			velocity.y = JUMP_VELOCITY
			animated_sprite.play("Jump")
			jumping = true
			JUMP_COUNT += 1


		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
	
		if direction > 0:
			animated_sprite.flip_h = false
			attack_1.position.x = 32
		elif direction < 0:
			animated_sprite.flip_h = true
			attack_1.position.x = -32
		if attacking:
			return
		if not jumping:
			if direction == 0:
				animated_sprite.play("Idle")
			else:
				animated_sprite.play("Run")
	
		if direction:
			velocity.x = direction * SPEED 
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	elif health <= 0:
		print("dead")
		Engine.time_scale = 0.5
		animated_sprite.play("Dead")
		
		if animated_sprite.frame == 5:
			print("ani end")
			animated_sprite.pause()
			if death_timer.time_left == 0:
				death_timer.start()
			
	
	move_and_slide()
func getting_hit(hit: int):
	print("player hit: " , str(hit))
	if hit >= health:
		health = 0
	else:
		health -= hit
	
func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Jump":
		jumping = false
	if animated_sprite.animation == "Attack_2":
		attacking = false
		can_attack_1 = true
