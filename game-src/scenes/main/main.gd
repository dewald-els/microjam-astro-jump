extends Node

@onready var retry_scene: PackedScene = preload("res://scenes/retry/retry.tscn")

func _ready() -> void:
	SignalBus.connect("player_dead", on_player_dead)
	SignalBus.connect("restart_level", on_restart_level)

func on_player_dead() -> void:
	var retry_instance: RetryScreen = retry_scene.instantiate()
	add_child(retry_instance)


func on_restart_level() -> void:
	print("Restarting")
	get_tree().reload_current_scene()
