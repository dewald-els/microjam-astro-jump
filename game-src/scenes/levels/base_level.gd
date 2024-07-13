class_name BaseLevel
extends Node

@export var main_camera: Camera2D


@onready var retry_scene: PackedScene = preload("res://scenes/retry/retry.tscn")
@onready var finish_scene: PackedScene = preload("res://scenes/finish_ui/finish_ui.tscn")

func _ready() -> void:
	SignalBus.connect("player_dead", on_player_dead)
	SignalBus.connect("player_reached_exit", on_player_reached_exit)
	SignalBus.connect("restart_level", on_restart_level)
	SignalBus.connect("camera_shake_completed", on_camera_shake_completed)
	SignalBus.connect("player_was_spawned", on_player_was_spawned)
	SignalBus.emit_signal("player_spawn")


func on_player_dead() -> void:
	var retry_instance: RetryScreen = retry_scene.instantiate()
	add_child(retry_instance)

func on_player_reached_exit() -> void:
	var finish_instance: FinishScreen = finish_scene.instantiate()
	await get_tree().create_timer(2.0).timeout
	add_child(finish_instance)

func on_restart_level() -> void:
	print("Restarting")
	get_tree().reload_current_scene()
	
func on_camera_shake_completed() -> void:
	pass


func on_player_was_spawned(player: Player) -> void:
	#main_camera.follow = player
	pass
