extends State


@onready var player: Player = owner

func enter(_msg: Dictionary = {}) -> void:
	player.animated_sprite.play("idle")
	player.animation_player.play("finish")
	await get_tree().create_timer(0.5).timeout
	SignalBus.connect("camera_shake_completed", on_shake_completed)
	SignalBus.emit_signal("camera_shake", 100, 0.25)
	SignalBus.emit_signal("finish_can_take_off")
	
func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(0, delta)
	player.move_and_slide()


func on_shake_completed() -> void:
	pass
