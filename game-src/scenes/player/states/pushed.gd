extends State


@onready var player: Player = owner

@export var move_speed: float


var force: float


func enter(msg: Dictionary = {}) -> void:
	player.animated_sprite.play("run")
	player.label.text = "Pushed"
	force = msg.get("force", 0.0)
	print("Force", force)
	print("Msg", msg)

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("player_jump") and player.is_on_floor():
		player.jump()
		
	var direction = player.get_movement_direction()
	if direction > 0: # Right
		if force > 0: # Right
			player.velocity.x = direction * (move_speed + force * 0.5)
		else:
			player.velocity.x = direction * (move_speed - force)
	elif direction < 0: # Left
		if force > 0: # Right
			player.velocity.x = direction * (move_speed - force)
		else:
			player.velocity.x = direction * (move_speed + force * 0.5)
	else:
		player.velocity.x = force
		
	player.label.text = "Pushed\nVeloctity: " + str(player.velocity.x)
	
	player.apply_gravity(delta)
	player.move_and_slide()
	
	player.face_movement_direction(direction)
