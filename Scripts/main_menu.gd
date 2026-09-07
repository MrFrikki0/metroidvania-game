extends Node2D



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("uid://q43lwpstirfi")


func _on_exit_pressed() -> void:
	get_tree().quit()
