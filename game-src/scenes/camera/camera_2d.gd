extends Camera2D

@export var follow: Node2D

@export var zoom_smoothing: float = 1.0

var zoom_to_finish: bool = false

func _ready() -> void:
	SignalBus.connect("player_reached_exit", on_player_reached_exit)

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if zoom_to_finish:
		offset = lerp(offset, Vector2.ZERO, zoom_smoothing * delta)
		zoom = lerp(zoom, Vector2(2, 2), zoom_smoothing * delta)
	elif follow:
		global_position = lerp(global_position, follow.global_position, 0.5)


func on_player_reached_exit() -> void:
	zoom_to_finish = true
	
