extends Node2D
@export var speed :int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("bullet start go")
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	move_local_x(delta * speed)

func is_outside_view_bounds():
	return position.x > get_window().get_size().x or position.x < 0.0 \
	or position.y > get_window().get_size().y or position.y


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hit")
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("gone")
	queue_free()
