extends Area2D

enum FanDirection {
	Up,
	Left,
	Right
}

@export var fan_power: float
@export var direction: FanDirection


@onready var particles: GPUParticles2D = %WindParticles


var direction_name: String

func _ready() -> void:
	connect("body_entered", on_body_entered)
	connect("body_exited", on_body_exited)
	particles.emitting = true


	match direction:
		FanDirection.Up:
			direction_name = "Up"
			
		FanDirection.Left:
			direction_name = "Left"
			
		FanDirection.Right:
			direction_name = "Right"
			
		_:
			direction_name = "Right"
			

func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_entered_fan_zone", fan_power, direction_name)
		

func on_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_exited_fan_zone", direction_name)
