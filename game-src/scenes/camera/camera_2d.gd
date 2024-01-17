extends Camera2D

@export var follow: Node2D

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if follow:
		global_position = lerp(global_position, follow.global_position, 0.5)
