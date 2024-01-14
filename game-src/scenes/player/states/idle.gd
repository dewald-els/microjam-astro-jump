extends State

@onready var player: Player = owner


func enter(_msg: Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO
	player.label.text = "Idle"
	player.animated_sprite.play("idle")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		player.state_machine.transition_to("Fall")
	
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		print("direction", direction)
		player.state_machine.transition_to("Run")
	
	if Input.is_action_just_pressed("player_jump"):
		player.state_machine.transition_to("Jump")
