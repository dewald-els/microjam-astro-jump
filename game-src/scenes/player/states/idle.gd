extends State

@onready var player: Player = owner



func enter(_msg: Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO
	player.label.text = "Idle"
	player.animated_sprite.play("idle")
	player.coyote_timer.stop()

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump"):
		player.change_state(player.PlayerState.Jump)
	elif abs(player.get_movement_direction()) > 0:
		player.change_state(player.PlayerState.Run)
		
	player.was_on_floor = player.is_on_floor()
	
	if player.state_machine.get_state_name() == "Idle":
		player.apply_movement(0, player.base_move_speed)
	
	player.apply_gravity(delta)
	player.move_and_slide()
		
