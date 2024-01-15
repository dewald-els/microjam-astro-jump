extends State


@onready var player: Player = owner


@export var move_speed: float


func enter(_msg: Dictionary = {}) -> void:
	player.label.text = "Fall"
	

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.state_machine.transition_to("Idle")
