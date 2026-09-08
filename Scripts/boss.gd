extends RigidBody2D

const SPEED = 60
var direction: int = 1
@export var health: int
var attacking: bool
var can_attack_1: bool = true
var rng = RandomNumberGenerator.new()
var rngt = RandomNumberGenerator.new()
var boss_state: int
var bullet_path = preload("uid://cbrj7kijm1vtd")
var energy_path = preload("uid://bhwoh4xqxjmmw")
var shoot_unlock_path = preload("uid://croskcw4flerl")

@onready var ray_cast_right: RayCast2D = $"RayCast right"
@onready var ray_cast_left: RayCast2D = $"RayCast left"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_right: Node2D = $shoot_right
@onready var shoot_left: Node2D = $shoot_left
@onready var timer: Timer = $State_timer
@onready var attack_timer: Timer = $Attack_timer
@onready var boss_manager: Area2D = $"../all of map/Boss_Manager"
@onready var player: CharacterBody2D = %Player
@onready var slime: RigidBody2D = $"."
@onready var level = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boss_state = 0
	animated_sprite_2d.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	
	if boss_state == 0:
		attack_timer.stop()
		position.x += direction * SPEED * delta
		
		animated_sprite_2d.play("Move")
			
		if timer.is_stopped():
			timer.start(rng.randf_range(1, 10))
			
	elif boss_state == 1:
		
		animated_sprite_2d.play("Idle")
		
		if attack_timer.is_stopped():
			var side_x = player.global_position.x - global_position.x
			
			if side_x > 0:
				print("Player is to the right")
				animated_sprite_2d.flip_h = true
				animated_sprite_2d.play("Attack")
				fire(shoot_right.global_position, shoot_right.global_rotation)
			elif side_x < 0:
				print("Player is to the left")
				animated_sprite_2d.flip_h = false
				animated_sprite_2d.play("Attack")
				fire(shoot_left.global_position, shoot_left.global_rotation)
			else:
				if animated_sprite_2d.flip_h == false:
					animated_sprite_2d.play("Attack")
					fire(shoot_left.global_position, shoot_left.global_rotation)
				else:
					animated_sprite_2d.play("Attack")
					fire(shoot_right.global_position, shoot_right.global_rotation)
			
			attack_timer.start(rngt.randf_range(0.4, 1))
		
		if timer.is_stopped():
			timer.start(rng.randf_range(3, 10))
			
	elif boss_state == 2:
		attack_timer.stop()
		animated_sprite_2d.play("Idle")
		#if direction == -1:
			#direction = 1
			#animated_sprite_2d.flip_h = true
		#elif direction == 1:
			#direction = -1
			#animated_sprite_2d.flip_h = false
		if timer.is_stopped():
			timer.start(rng.randf_range(0.5, 2))
	
	if health <= 0:
		drop(1)
		boss_manager.boss_over()
		queue_free()
		
	

func getting_hit(hit: int):
	print("boss hit: " , str(hit))
	if hit >= health:
		health = 0
	else:
		health -= hit
	
	animated_sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.modulate = Color.WHITE
	
func drop(count: int):
	
	for n in count:
		var new_energy = energy_path.instantiate()
		new_energy.global_position = slime.global_position
		level.add_child(new_energy)
	
	var shoot_unlock = shoot_unlock_path.instantiate()
	shoot_unlock.global_position = slime.global_position
	level.add_child(shoot_unlock)
	
func fire(bulletPos,bulletRot) -> void:
	print("ebullet start")
	var new_bullet = bullet_path.instantiate()
	print("ebullet go")
	add_child(new_bullet)
	new_bullet.global_position = bulletPos
	new_bullet.global_rotation = bulletRot
	attacking = false

func _on_timer_timeout() -> void:
	print("b timer out")
	boss_state = rng.randf_range(0, 2)
	print("state:" , str(boss_state))


func _on_attack_timer_timeout() -> void:
	pass # Replace with function body.
