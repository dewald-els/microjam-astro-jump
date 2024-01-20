extends State

@onready var player: Player = owner
@export var move_speed: float

var force: float
var force_direction: String

func enter(msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Pushed"
	force = msg.get("force", 0.0)
	force_direction = msg.get("force_direction", "Right")
	print("Force", force)
	print("Msg", msg)

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump") and player.is_on_floor():
		player.jump()
		
	var direction: int = player.get_movement_direction()
		
	player.label.text = "Pushed\nVeloctity: " + str(player.velocity.x)
	if force_direction == "Left" or force_direction == "Right":
		if direction == 0:
			player.velocity.x = lerp(player.velocity.x, force, 1)
		else:
			player.velocity.x = direction * (force * 0.5) if direction < 0 else direction * (force * 1.75)
	elif force_direction == "Up":
		player.velocity.y = lerp(player.velocity.y, -force, 0.7)
		player.apply_movement(direction, player.base_move_speed)
	
	
	
	
	player.apply_gravity(delta)
	player.move_and_slide()
	
	player.face_movement_direction(direction)
