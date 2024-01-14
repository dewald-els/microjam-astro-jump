extends State

@onready var player: Player = owner

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.state_machine.transition_to("Idle")
		
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
