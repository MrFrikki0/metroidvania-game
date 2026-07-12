extends Node

var abi_duable_jump: bool
var abi_shoot_fire: bool

@onready var energy_text: Label = $"../GUI/UI/Energy"
@onready var fire_icon: Sprite2D = $"../GUI/UI/Fire_icon"
@onready var jump_icon: Sprite2D = $"../GUI/UI/Jump_icon"
@onready var player: CharacterBody2D = %Player

func _process(delta: float) -> void:
	jump_icon.visible = false
	fire_icon.visible = false
	
	energy_text.text = "Energy: " + str(player.energy) + "/" + str(player.max_energy)
	
	if abi_duable_jump == true:
		jump_icon.visible = true
	else:
		jump_icon.visible = false
	
	if abi_shoot_fire == true:
		fire_icon.visible = true
	else:
		fire_icon.visible = false

func unlock_dj():
	abi_duable_jump = true
func unlock_sf():
	abi_shoot_fire = true
