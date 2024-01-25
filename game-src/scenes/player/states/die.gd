extends State

@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("die")
	player.jump()
	player.velocity.x = lerp(player.velocity.x, 0.0, 1.0)

func update(_delta: float) -> void:
	if not player.animated_sprite.is_playing():
		player.change_state(player.PlayerState.Dead)
