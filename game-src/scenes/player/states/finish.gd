extends State


@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	print("Entered Finish")
	player.animated_sprite.play(player.States.Idle)
	
	
func physics_update(delta: float) -> void:		
	player.apply_gravity(delta)
	player.apply_movement(0, delta)