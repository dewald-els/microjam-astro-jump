class_name Player
extends CharacterBody2D

@onready var state_machine: StateMachine = %StateMachine
@onready var label: Label = %DebugLabel
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var coyote_timer: Timer = %CoyoteTimer

# Jump Mechanics: https://www.youtube.com/watch?v=IOe1aGY6hXA
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


func _physics_process(delta) -> void:
	apply_gravity(delta)
	move_and_slide()


func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func is_coyote_timer_running() -> bool:
	return !coyote_timer.is_stopped()


func apply_gravity(delta: float) -> void:
	velocity.y += get_gravity() * delta


func get_movement_direction() -> float:
	return Input.get_axis("player_right", "player_left") * -1.0
