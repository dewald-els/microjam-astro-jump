extends State


@onready var player: Player = owner

@export var move_speed: float


func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("jump")
	player.label.text = "Jump"
	player.velocity.y = player.jump_velocity
	player.coyote_timer.stop()
	
func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.change_state(player.PlayerState.Idle)
	if player.velocity.y > 0.0 and not player.is_on_floor():
		player.change_state(player.PlayerState.Fall)
	
	var direction = player.get_movement_direction()
	player.velocity.x = lerp(player.velocity.x, direction * move_speed, 0.5)
	player.face_movement_direction(direction)
	
	player.apply_gravity(delta)
	player.move_and_slide()
