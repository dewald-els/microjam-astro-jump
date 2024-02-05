extends Node2D


@onready var player: Player = owner
@onready var left_cast: RayCast2D = %HeadCastLeft
@onready var right_cast: RayCast2D = %HeadCastRight
@onready var center_cast: RayCast2D = %HeadCastCenter


@export var correct_amount_in_pixels: int = 4


func _ready() -> void:
	print("Player", player.name)

func _physics_process(_delta: float) -> void:
	
	if not player.is_on_floor():
		
		var direction: float = player.scale.y
		
		if left_cast.is_colliding() and not center_cast.is_colliding() and not right_cast.is_colliding():
			player.global_position.x = player.global_position.x + correct_amount_in_pixels * direction
		elif right_cast.is_colliding() and not center_cast.is_colliding() and not left_cast.is_colliding():
			player.global_position.x = player.global_position.x - correct_amount_in_pixels * direction
	
	

