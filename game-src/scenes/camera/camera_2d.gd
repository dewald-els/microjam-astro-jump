extends Camera2D


@export_category("Follow")
@export var follow_x: bool = true
@export var follow_y: bool = true


@export_category("Camera Smoothing")
@export var enabled_smoothing: bool = true
@export_range(1, 10) var smoothing_distance: int = 8
@export_range(0.1, 1.0) var zoom_speed: float = 1.0

@export_category("Camera Shake")
@export var shake_noise: Noise
@export var shake_decay: float = 3.0


var follow: Player

var x_noise_sample_vector: Vector2 = Vector2.RIGHT
var y_noise_sample_vector: Vector2 = Vector2.DOWN
var noise_sample_travel_rate: int = 500
var max_shake_offset: int = 10
var current_shake_percentage: float = 0
var x_noise_sample_position: Vector2 = Vector2.ZERO
var y_noise_sample_position: Vector2 = Vector2.ZERO

var zoom_to_finish: bool = false
var weight: float
var zoom_weight: float


func _ready() -> void:
	SignalBus.connect("player_reached_exit", on_player_reached_exit)
	SignalBus.connect("camera_shake", on_apply_shake)
	
	weight = float(11 - smoothing_distance) / 100
	zoom_weight = zoom_speed * 2.0

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if zoom_to_finish:
		zoom = lerp(zoom, Vector2(2, 2), zoom_weight * delta)
		global_position = _get_camera_position()
	elif follow:
		if follow_y:
			global_position.y = _get_camera_position().y
		if follow_x:
			global_position.x = _get_camera_position().x
		
	if (current_shake_percentage > 0):
		_process_shake(delta)


func _get_camera_position() -> Vector2:
	var camera_position: Vector2
		
	if enabled_smoothing:
		camera_position = lerp(global_position, follow.global_position, weight)
	else:
		camera_position = follow.global_position
		
	return camera_position.floor()

func on_player_reached_exit() -> void:
	zoom_to_finish = true
	

func _process_shake(delta: float) -> void:
	x_noise_sample_position += x_noise_sample_vector * noise_sample_travel_rate * delta
	y_noise_sample_position += y_noise_sample_vector * noise_sample_travel_rate * delta
	var x_sample: float = shake_noise.get_noise_2d(x_noise_sample_position.x, x_noise_sample_position.y)
	var y_sample: float = shake_noise.get_noise_2d(y_noise_sample_position.x, y_noise_sample_position.y)
	
	var shake_offset: Vector2 = Vector2(x_sample, y_sample) * max_shake_offset * pow(current_shake_percentage, 2)
	offset = shake_offset
	current_shake_percentage = clamp(current_shake_percentage - shake_decay * delta, 0, 1)
	if current_shake_percentage == 0:
		SignalBus.emit_signal("camera_shake_completed")

func apply_shake(percentage: float, decay: float = 3) -> void:
	shake_decay = decay
	current_shake_percentage = clamp(current_shake_percentage + percentage, 0, 1)
	
func on_apply_shake(percentage: float, decay: float) -> void:
	apply_shake(percentage, decay)
