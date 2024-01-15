extends State


@onready var player: Player = owner

@export var move_speed: float


func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("jump")
	player.label.text = "Jump"
	player.velocity.y = player.jump_velocity
	
	
func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.state_machine.transition_to("Idle")
	if player.velocity.y > 0.0 and not player.is_on_floor():
		player.state_machine.transition_to("Fall")
	
	var direction = player.get_movement_direction()
	player.velocity.x = lerp(player.velocity.x, direction * move_speed, 0.5)
		
