extends State

@onready var player: Player = owner
@export var move_speed: float

var force: Vector2

func enter(msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Pushed"
	force = msg.get("force", Vector2.ZERO)
	print("Force", force)
	print("Msg", msg)

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump") and player.is_on_floor():
		player.jump()
		
	var direction: int = player.get_movement_direction()
		
	player.label.text = "Pushed\nVeloctity: " + str(player.velocity.x)
	if direction == 0:
		player.velocity.x = lerp(player.velocity.x, force.x, 1)
	else:
		player.velocity.x = direction * force.x * 0.5 if direction < 0 else direction * force.x * 1.5
	
	player.apply_gravity(delta)
	player.move_and_slide()
	
	player.face_movement_direction(direction)
