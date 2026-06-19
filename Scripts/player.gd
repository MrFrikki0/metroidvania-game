extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var JUMP_COUNT: int = 0
var health: int = 100
var dead: bool = false
var max_jump: int = 1

var jumping: bool
var attacking: bool
var can_attack_1: bool = true
var can_attack_2: bool = true
var direction = 1

var bullet_path = preload("uid://b47ea886o3o20")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer: Timer = $DeathTimer
@onready var attack_2_timer: Timer = $Attack_2Timer
@onready var kill_zone: Area2D = $attack_1/KillZone
@onready var attack_1: Node2D = $attack_1
@onready var shoot_right: Node2D = $shoot_right
@onready var shoot_left: Node2D = $shoot_left
@onready var health_text: Label = $"../GUI/UI/Health"
@onready var game_manager: Node = %GameManager




func _physics_process(delta: float) -> void:
	
	health_text.text = "Health: " + str(health)
	
	if game_manager.abi_duable_jump == true:
		max_jump = 2
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if health > 0:
		# Handle jump.
		if is_on_floor():
			JUMP_COUNT = 0
		if Input.is_action_just_pressed("attack_1") and attacking == false and can_attack_1:
			attacking = true
			can_attack_1 = false
			animated_sprite.play("Attack_2")
			kill_zone.set_monitoring(true)
		else:
			kill_zone.set_monitoring(false)
		
		if Input.is_action_just_pressed("attack_2") and attacking == false and can_attack_2 and game_manager.abi_shoot_fire:
			attacking = true
			can_attack_2 = false
			print("press fire")
			attack_2_timer.start()
			if animated_sprite.flip_h == false:
				print("riht :", str(shoot_right.global_position) , str(shoot_right.global_rotation))
				fire(shoot_right.global_position, shoot_right.global_rotation)
			else:
				print("left :", str(shoot_left.global_position) , str(shoot_left.global_rotation))
				fire(shoot_left.global_position, shoot_left.global_rotation)
		if Input.is_action_just_pressed("jump") and JUMP_COUNT < max_jump:
			velocity.y = JUMP_VELOCITY
			animated_sprite.play("Jump")
			jumping = true
			JUMP_COUNT += 1


		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("move_left", "move_right")
	
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
		
func fire(bulletPos,bulletRot) -> void:
	print("bullet start")
	var new_bullet = bullet_path.instantiate()
	print("bullet go")
	add_child(new_bullet)
	new_bullet.global_position = bulletPos
	new_bullet.global_rotation = bulletRot
	attacking = false
	
func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Jump":
		jumping = false
	if animated_sprite.animation == "Attack_2":
		attacking = false
		can_attack_1 = true
		



func _on_attack_2_timer_timeout() -> void:
	can_attack_2 = true
