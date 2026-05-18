extends Node2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $"RayCast right"
@onready var ray_cast_left: RayCast2D = $"RayCast left"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("on enemy")
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
		
	position.x += direction * SPEED * delta
