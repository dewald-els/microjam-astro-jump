extends State

@onready var player: Player = owner

@export var move_speed: float

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Run"
	

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.state_machine.transition_to("Fall")
	if abs(player.velocity.x) <= 0:
		player.state_machine.transition_to("Idle")
	if Input.is_action_just_pressed("player_jump"):
		player.state_machine.transition_to("Jump")
	
	var direction = player.get_movement_direction()
	player.velocity.x = lerp(player.velocity.x, direction * move_speed, 0.5)
	
	player.face_movement_direction(direction)
