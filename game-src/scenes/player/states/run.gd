extends State

@onready var player: Player = owner

@export var move_speed: float

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Run"
	

func physics_update(delta: float) -> void:
	
	if (player.is_on_floor() || !player.coyote_timer.is_stopped()) and Input.is_action_just_pressed("player_jump"):
		player.state_machine.transition_to("Jump")
	
	elif not player.is_on_floor() and player.coyote_timer.is_stopped():
		player.state_machine.transition_to("Fall")
	
	elif abs(player.velocity.x) <= 0:
		player.state_machine.transition_to("Idle")

	
	player.was_on_floor = player.is_on_floor()
	
	var direction = player.get_movement_direction()
	player.velocity.x = direction * move_speed
	
	# Apply Physics
	player.apply_gravity(delta)
	player.move_and_slide()
	
	# Coyote Timer
	if player.was_on_floor and !player.is_on_floor():
		player.label_vel.text = "started coyote"
		player.coyote_timer.start()
		
	player.face_movement_direction(direction)
