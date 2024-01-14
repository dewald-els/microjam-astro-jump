extends State


@onready var player: Player = owner

var last_y_velocity := 0.0
var max_jump := 250.0
const JUMP_POWER := -3050.0


func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("jump")
	player.label.text = "Jump"
	
	
func physics_update(delta: float) -> void:
	if abs(player.velocity.y) >= max_jump and not player.is_on_floor():
		state_machine.transition_to("Fall")
		
	player.velocity.y += JUMP_POWER * delta
	
	print("VEL", player.velocity.y)
	
	var direction = Input.get_axis("player_left", "player_right")

	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		
	if direction:
		player.scale.x = player.scale.y * direction
	else:
		player.scale.x = 1
	
	last_y_velocity = player.velocity.y
	
