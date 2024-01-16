extends State


@onready var player: Player = owner


@export var move_speed: float


func enter(_msg: Dictionary = {}) -> void:
	player.label.text = "Fall"
	

func physics_update(delta: float) -> void:
	if player.is_on_floor() and !player.jump_buffer_timer.is_stopped():
		player.change_state("Jump")
	elif player.is_on_floor():
		player.state_machine.transition_to("Idle")
	if Input.is_action_just_pressed("player_jump"):
		player.jump_buffer_timer.start()
		

	var direction = player.get_movement_direction()
	player.velocity.x = lerp(player.velocity.x, direction * move_speed, 0.5)
	
	player.apply_gravity(delta)
	player.move_and_slide()
