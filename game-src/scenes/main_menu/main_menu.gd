extends Node2D

@onready var play_button: Button = %PlayButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.connect("pressed", on_play_pressed)


func on_play_pressed() -> void:
	SceneTransition.transition_to("res://scenes/levels/level_001/level_001.tscn")
