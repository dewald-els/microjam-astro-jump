extends Camera2D

@export_category("Player")
@export var follow: Node2D

@export_category("Camera Smoothing")
@export var enabled_smoothing: bool = true
@export_range(1, 10) var smoothing_distance: int = 8
@export_range(0.1, 1.0) var zoom_speed: float = 1.0


var zoom_to_finish: bool = false
var weight: float
var zoom_weight: float


func _ready() -> void:
	SignalBus.connect("player_reached_exit", on_player_reached_exit)
	
	weight = float(11 - smoothing_distance) / 100
	zoom_weight = zoom_speed * 2.0

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if zoom_to_finish:
		zoom = lerp(zoom, Vector2(2, 2), zoom_weight * delta)
		global_position = _get_camera_position()
	elif follow:
		global_position.y = _get_camera_position().y


func _get_camera_position() -> Vector2:
	var camera_position: Vector2
		
	if enabled_smoothing:
		camera_position = lerp(global_position, follow.global_position, weight)
	else:
		camera_position = follow.global_position
		
	return camera_position.floor()

func on_player_reached_exit() -> void:
	zoom_to_finish = true
	
