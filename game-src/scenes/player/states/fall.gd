extends State

@onready var player: Player = owner

const GRAVITY := 2000

func enter(msg: Dictionary = {}) -> void:
	player.label.text = "Fall"

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.state_machine.transition_to("Idle")
		
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("player_left", "player_right")

	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		
	if direction:
		player.scale.x = player.scale.y * direction
	else:
		player.scale.x = 1
