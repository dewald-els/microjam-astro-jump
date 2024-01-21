extends Area2D


@onready var animation_player: AnimationPlayer = %AnimationPlayer


@export var oxygen_value: float = 30.0

func _ready() -> void:
	connect("body_entered", on_body_entered)
	
func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("oxygen_collect", oxygen_value)
		animation_player.play("collect")
