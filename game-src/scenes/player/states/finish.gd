extends State


@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("idle")
	
	
func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(0, delta)
	player.move_and_slide()
