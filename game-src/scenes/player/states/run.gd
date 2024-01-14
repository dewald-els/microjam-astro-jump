extends State

@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Run"
	

func physics_update(_delta: float) -> void:
	var direction = Input.get_axis("player_left", "player_right")

	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	
	#player.move_and_slide()
	
	print("Velocity", player.velocity)
	
	if direction:
		player.scale.x = player.scale.y * direction
	else:
		player.scale.x = 1
	
	if player.velocity == Vector2.ZERO:
		player.state_machine.transition_to("Idle")
		
	
