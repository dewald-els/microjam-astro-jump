extends Node2D


@onready var player: Player = owner
@onready var left_cast: RayCast2D = %HeadCastLeft
@onready var right_cast: RayCast2D = %HeadCastRight
@onready var center_cast: RayCast2D = %HeadCastCenter


func _ready() -> void:
	print("Player", player.name)

func _process(_delta: float) -> void:
	
	if not player.is_on_floor():
		
		print("left", left_cast.is_colliding())
		print("center", center_cast.is_colliding())
		print("right", right_cast.is_colliding())
		
		var direction: float = player.scale.y
		
		if left_cast.is_colliding() and not right_cast.is_colliding():
			print("Should push right")
			player.global_position.x = player.global_position.x + 2 * direction
		elif right_cast.is_colliding() and not left_cast.is_colliding():
			player.global_position.x = player.global_position.x - 2 * direction
			print("Should push left")
	
	

