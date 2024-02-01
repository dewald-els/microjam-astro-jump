extends Area2D


var can_take_off: bool = false
var move_speed: float = 25.0

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func _ready() -> void:
	connect("body_entered", on_body_entered)
	SignalBus.connect("finish_can_take_off", on_finish_can_take_off)
	
	
func _process(delta: float) -> void:
	print("Sprite Position: ", sprite.position.y)
	if can_take_off and sprite.position.y > -1000:
		sprite.position.y = move_toward(sprite.position.y, -1000, delta * move_speed)

func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_reached_exit")


func on_finish_can_take_off() -> void:
	can_take_off = true
