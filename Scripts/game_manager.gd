extends Node

var energy: int = 0
var abi_duable_jump: bool
var abi_shoot_fire: bool

@onready var energy_text: Label = $"../GUI/UI/Energy"

func unlock_dj():
	abi_duable_jump = true
func unlock_sf():
	abi_shoot_fire = true
func add_energy():
	energy += 1
	energy_text.text = "Energy: " + str(energy)
	print(energy)
