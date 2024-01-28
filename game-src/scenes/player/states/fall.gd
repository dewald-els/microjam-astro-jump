extends State


@onready var player: Player = owner


func enter(_msg: Dictionary = {}) -> void:
	player.label.text = "Fall"
	

func physics_update(delta: float) -> void:
	if player.is_on_floor() and !player.jump_buffer_timer.is_stopped():
		player.change_state(player.PlayerState.Jump)
	elif player.is_on_floor():
		player.change_state(player.PlayerState.Idle)
	if Input.is_action_just_pressed("player_jump"):
		player.jump_buffer_timer.start()
		

	var direction: int = player.get_movement_direction()
	player.apply_movement(direction, delta)
	
	player.apply_gravity(delta)
	player.move_and_slide()
