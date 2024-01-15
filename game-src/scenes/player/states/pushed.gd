extends State


@onready var player: Player = owner

@export var move_speed: float


var force: float


func enter(msg: Dictionary = {}) -> void:
	player.label.text = "Pushed"
	force = msg.get("force", 0.0)
	print("Force", force)
	print("Msg", msg)

func physics_update(_delta: float) -> void:
	var direction = player.get_movement_direction()
	if abs(direction) > 0:
		player.velocity.x = lerp(player.velocity.x, direction * (move_speed - force), 1)
	else:
		player.velocity.x = force
	player.label.text = "Pushed\nVeloctity: " + str(player.velocity.x)
