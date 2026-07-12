extends RigidBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		body.add_energyPlayer(1)
		queue_free()
