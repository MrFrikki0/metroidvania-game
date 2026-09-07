extends Control

@onready var resume: Button = $Resume

func sfocus():
	resume.grab_focus()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("uid://bc02155gtlnxa")


func _on_ready() -> void:
	print("ready menu")
