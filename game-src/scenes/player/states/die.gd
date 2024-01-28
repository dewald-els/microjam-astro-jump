extends State

@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("die")
	player.motion = Vector2.ZERO

func update(_delta: float) -> void:
	if not player.animated_sprite.is_playing():
		player.change_state(player.PlayerState.Dead)
