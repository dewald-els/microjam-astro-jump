extends Area2D

enum FanDirection {
	Up,
	Left,
	Right
}

@export var fan_power: float
@export var direction: FanDirection

@onready var gpu_particles_scene: PackedScene = preload("res://scenes/particles/wind_particles.tscn")
var gpu_particles: GPUParticles2D

var direction_name: String

func _ready() -> void:
	gpu_particles = gpu_particles_scene.instantiate()
	add_child(gpu_particles)
	connect("body_entered", on_body_entered)
	connect("body_exited", on_body_exited)

	match direction:
		FanDirection.Up:
			direction_name = "Up"
			gpu_particles.process_material.set("gravity", Vector3(0, -98, 0))
		FanDirection.Left:
			direction_name = "Left"
			gpu_particles.process_material.set("gravity", Vector3(-98, 0, 0))
		FanDirection.Right:
			direction_name = "Right"
			gpu_particles.process_material.set("gravity", Vector3(98, 0, 0))
		_:
			direction_name = "Right"
			gpu_particles.process_material.set("gravity", Vector3(98, 0, 0))

func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_entered_fan_zone", fan_power, direction_name)
		

func on_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_exited_fan_zone")
