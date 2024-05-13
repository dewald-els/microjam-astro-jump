extends State

@onready var player: Player = owner


func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("land")
	
func update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump"):
		player.change_state(player.PlayerState.Jump)
	if not player.animated_sprite.is_playing():
		player.change_state(player.PlayerState.Idle)
		
	player.apply_gravity(delta)
	player.apply_movement(player.get_movement_direction(), delta)
	player.move_and_slide()
