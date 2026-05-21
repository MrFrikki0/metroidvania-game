extends Node

var energy = 0

@onready var energy_text: Label = $"../GUI/UI/Energy"


func add_energy():
	energy += 1
	energy_text.text = "Energy: " + str(energy)
	print(energy)
