extends Area2D


@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_detection_area: Area2D = %PlayerDetection
@onready var light: PointLight2D = %PointLight2D
@onready var visibility_notifier: VisibleOnScreenNotifier2D = %VisibilityNotifier
@onready var particles: CPUParticles2D = %CPUParticles2D

@export var oxygen_value: float = 30.0
@export_range(0.0, 1.0) var float_to_player_speed: float = 0.0

var player: Player = null


func _ready() -> void:
	connect("body_entered", on_body_entered)
	visibility_notifier.connect("screen_entered", on_screen_entered)
	visibility_notifier.connect("screen_exited", on_screen_exited)
	player_detection_area.connect("body_entered", on_player_detected)
	

func _physics_process(delta: float) -> void:
	if player != null:
		global_position = global_position.move_toward(
			player.global_position, 
			float_to_player_speed * 1000 * delta)
	
func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("oxygen_collect", oxygen_value)
		animation_player.play("collect")


func on_player_detected(body: Node2D) -> void:
	if "Player" in body.name:
		player = body as Player
		light.enabled = false
		particles.emitting = false
		

func on_screen_entered() -> void:
	toggle_effects()


func on_screen_exited() -> void:
	toggle_effects()
	
func toggle_effects() -> void:
	particles.emitting = !particles.emitting
	light.enabled = !light.enabled
