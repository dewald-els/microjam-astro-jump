extends State


@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("jump")
	player.label.text = "Jump"
	player.jump()
	player.coyote_timer.stop()
	
func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.change_state(player.PlayerState.Idle)
	if player.velocity.y > 0.0 and not player.is_on_floor():
		player.change_state(player.PlayerState.Fall)
	
	var direction: int = player.get_movement_direction()
	player.apply_movement(direction, delta)
	player.face_movement_direction(direction)
	
	player.apply_gravity(delta)
	player.move_and_slide()
