extends State

@onready var player: Player = owner

@export var move_speed: float

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Run"
	

func physics_update(delta: float) -> void:
	
	if (player.is_on_floor() || !player.coyote_timer.is_stopped()) and Input.is_action_just_pressed("player_jump"):
		player.state_machine.transition_to(player.States.Jump)
	
	elif not player.is_on_floor() and player.coyote_timer.is_stopped():
		player.state_machine.transition_to(player.States.Fall)
	
	elif abs(player.velocity.x) <= 0:
		player.state_machine.transition_to(player.States.Idle)

	
	player.was_on_floor = player.is_on_floor()
	
	var direction: int = player.get_movement_direction()
	player.apply_movement(direction, delta)
	
	
	# Apply Physics
	player.apply_gravity(delta)
	player.move_and_slide()
	
	# Coyote Timer
	if player.was_on_floor and !player.is_on_floor():
		player.coyote_timer.start()
		
	player.face_movement_direction(direction)
