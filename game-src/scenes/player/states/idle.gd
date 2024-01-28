extends State

@onready var player: Player = owner



func enter(_msg: Dictionary = {}) -> void:
	
	player.label.text = "Idle"
	player.animated_sprite.play("idle")
	player.coyote_timer.stop()

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump"):
		player.change_state(player.PlayerState.Jump)
	elif abs(player.get_movement_direction()) > 0:
		player.change_state(player.PlayerState.Run)
		
	player.was_on_floor = player.is_on_floor()
	
	if player.state_machine.get_state_name() == player.States.Idle:
		player.apply_movement(0, delta)
	
	player.apply_gravity(delta)
	player.move_and_slide()
		

func exit(_msg: Dictionary = {}) -> void:
	pass
