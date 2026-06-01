extends Area2D

@onready var timer: Timer = $Timer
@export var hit: int


func _on_body_entered(body: Node2D) -> void:
	print("hit")
	body.health -= hit
	timer.start()


func _on_timer_timeout() -> void:
	pass
