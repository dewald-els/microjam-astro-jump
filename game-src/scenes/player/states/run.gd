extends State

@onready var player: Player = owner

@export var move_speed: float

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Run"
	

func physics_update(delta: float) -> void:
	if abs(player.velocity.x) <= 0:
		player.state_machine.transition_to("Idle")
	
	var direction = player.get_movement_direction()
	player.velocity.x = direction * move_speed
	
	face_running_direction(direction)
	

func face_running_direction(direction: float) -> void:
	if direction == 0:
		player.scale.x = 1
	else:
		player.scale.x = player.scale.y * direction 
		
