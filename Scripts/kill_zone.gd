extends Area2D

@onready var timer: Timer = $Timer
@export var hit: int

func _on_body_entered(body: Node2D) -> void:
	print(get_parent().get_name(), ": " , body.get_name())
	if body.get_name() == "Player":
		body.getting_hit(hit)
	if body.get_name() == "Slime":
		body.getting_hit(hit)
	if body.get_name() == "Boss":
		body.getting_hit(hit)
	if body.get_name() == "Wood_wall":
		body.break_wall()
