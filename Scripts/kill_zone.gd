extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("dead")
	Engine.time_scale = 0.5
	body.dead = true
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	
