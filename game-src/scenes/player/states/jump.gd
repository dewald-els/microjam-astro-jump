extends State


@onready var player: Player = owner


func enter(msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	

