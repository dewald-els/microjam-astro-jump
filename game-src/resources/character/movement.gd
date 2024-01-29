class_name MovementStats
extends Resource

 
@export_category("Jump")
# Jump Mechanics: https://www.youtube.com/watch?v=IOe1aGY6hXA
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var low_jump_multiplier: float

@export_category("Move")
@export var move_distance: float # Number of Pixels in Move Time To Distance
@export var move_time_to_distance: float
@export var move_stop_distance: float
@export var move_time_to_stop_distance: float
@export var max_velocity: float

# Jump Calculations
var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

# Move Calculations
var move_velocity: float
var move_friction: float
var move_stop_friction: float

func _init() -> void:
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

	# Move Calculations
	move_velocity = 2.0 * move_distance / move_time_to_distance
	move_friction = 2.0 * move_distance / pow(2, move_time_to_distance)
	move_stop_friction = 2.0 * move_distance / pow(2, move_time_to_stop_distance)
	
