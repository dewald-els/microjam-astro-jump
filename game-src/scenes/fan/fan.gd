extends Area2D

@export var fan_power: Vector2 = Vector2.ZERO


func _ready() -> void:
	connect("body_entered", on_body_entered)
	connect("body_exited", on_body_exited)

func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_entered_fan_zone", fan_power)
		

func on_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_exited_fan_zone")
