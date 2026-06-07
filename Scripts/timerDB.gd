extends Node

var time :float
@onready var death_timer: Timer = $DeathTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time = self.time_left
	print(str(time))
