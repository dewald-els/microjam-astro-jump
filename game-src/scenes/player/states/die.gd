extends State

@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("die")
	player.velocity = Vector2.ZERO
	SignalBus.emit_signal("camera_shake", 100.0)

func update(delta: float) -> void:
	if not player.animated_sprite.is_playing():
		player.change_state(player.PlayerState.Dead)
	
	player.apply_gravity(delta)
	player.move_and_slide()
