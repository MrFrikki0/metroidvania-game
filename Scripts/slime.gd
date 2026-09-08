extends Node2D

const SPEED = 60
var direction: int = 1
var health: int = 10
var energy_path = preload("uid://cs2ery6egholb")

@onready var ray_cast_right: RayCast2D = $"RayCast right"
@onready var ray_cast_left: RayCast2D = $"RayCast left"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slime: RigidBody2D = $"."
@onready var level = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	position.x += direction * SPEED * delta
	if health <= 0:
		drop(2)
		queue_free()
	
func getting_hit(hit: int):
	print("slime hit: " , str(hit))
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
