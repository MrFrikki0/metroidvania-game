extends Area2D

var boss_on: bool
@onready var boss: RigidBody2D = $"../../Boss"
@onready var block_wall: StaticBody2D = $"../Block_wall"
@onready var block_wall_2: StaticBody2D = $"../Block_wall2"



func boss_over():
	block_wall.hide()
	block_wall.process_mode = 4
	block_wall_2.hide()
	block_wall_2.process_mode = 4
	
func _on_area_entered(area: Area2D) -> void:
	if not boss_on:
		boss.show()
		boss.process_mode = 1
		block_wall_2.show()
		block_wall_2.process_mode = 1
		boss_on = true


func _on_ready() -> void:
	#block_wall_2.hide()
	#block_wall_2.process_mode = 1
	pass
