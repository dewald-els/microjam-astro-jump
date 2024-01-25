extends State


@onready var player: Player = owner

var emitted: bool = false


func enter(_msg: Dictionary = {}) -> void:
	print("Entered Dead Playing sprite")
	player.animated_sprite.play("dead")
	player.velocity.y = lerp(player.velocity.y, -100.0, 0.65)


func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()
	if not emitted and player.is_on_floor():
		emitted = true
		SignalBus.emit_signal("player_dead")
