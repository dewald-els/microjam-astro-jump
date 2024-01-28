extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_killed")
