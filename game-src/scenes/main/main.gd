extends Node

@onready var retry_scene: PackedScene = preload("res://scenes/retry/retry.tscn")
@onready var finish_scene: PackedScene = preload("res://scenes/finish_ui/finish_ui.tscn")

func _ready() -> void:
	SignalBus.connect("player_dead", on_player_dead)
	SignalBus.connect("player_reached_exit", on_player_reached_exit)
	SignalBus.connect("restart_level", on_restart_level)


func on_player_dead() -> void:
	var retry_instance: RetryScreen = retry_scene.instantiate()
	add_child(retry_instance)

func on_player_reached_exit() -> void:
	var finish_instance: FinishScreen = finish_scene.instantiate()
	add_child(finish_instance)

func on_restart_level() -> void:
	print("Restarting")
	get_tree().reload_current_scene()
