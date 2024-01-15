extends State

@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO
	player.label.text = "Idle"
	player.animated_sprite.play("idle")

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump"):
		player.state_machine.transition_to("Jump")
		
	if abs(player.get_movement_direction()) > 0:
		player.state_machine.transition_to("Run")
		
