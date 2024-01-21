class_name Player
extends CharacterBody2D
@onready var state_machine: StateMachine = %StateMachine
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var jump_buffer_timer: Timer = %JumpBufferTimer
@onready var label: Label = %DebugLabel
@onready var label_vel: Label = %DebugVelLabel

# Jump Mechanics: https://www.youtube.com/watch?v=IOe1aGY6hXA
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var base_move_speed: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
const jump_drag_multiplier: int = 3

var was_on_floor: bool = false

enum PlayerState {
	Idle,
	Run,
	Jump,
	Die,
	Fall,
	Pushed
}

const States: Dictionary = {
	Idle = "Idle",
	Run = "Run",
	Jump = "Jump",
	Die = "Die",
	Fall = "Fall",
	Pushed = "Pushed"
}

func _ready() -> void:
	SignalBus.connect("player_entered_fan_zone", on_player_entered_fan_zone)
	SignalBus.connect("player_exited_fan_zone", on_player_exited_fan_zone)

func _process(_delta: float) -> void:
	label_vel.text = str(velocity)
	label.text = str(state_machine.state)

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func is_coyote_timer_running() -> bool:
	return !coyote_timer.is_stopped()

func change_state(state: PlayerState, _msg: Dictionary = {}) -> void:
	match state:
		PlayerState.Idle:
			state_machine.transition_to("Idle", _msg)
		PlayerState.Run:
			state_machine.transition_to("Run", _msg)
		PlayerState.Jump:
			state_machine.transition_to("Jump", _msg)
		PlayerState.Die:
			state_machine.transition_to("Die", _msg)
		PlayerState.Fall:
			state_machine.transition_to("Fall", _msg)
		PlayerState.Pushed:
			state_machine.transition_to("Pushed", _msg)
		_:
			state_machine.transition_to("Idle", _msg)

# Common actions
func apply_gravity(delta: float) -> void:
	if velocity.y < 0 && !Input.is_action_pressed("player_jump"): # Low Jump
		velocity.y += get_gravity() * jump_drag_multiplier * delta
	else: # Regular Jump
		velocity.y += get_gravity() * delta


func get_movement_direction() -> int:
	var axis: float = Input.get_axis("player_left", "player_right")
	if axis > ControllerConfig.AnalogueBuffer:
		return 1
	elif axis < -ControllerConfig.AnalogueBuffer:
		return -1
	else:
		return 0
		
		
func face_movement_direction(direction: float) -> void:
	if direction == 0:
		scale.x = 1
	elif direction > 0.0:
		scale.x = scale.y * 1
	elif direction < 0.0:
		scale.x = scale.y * -1
		
func jump() -> void:
	velocity.y = jump_velocity

func apply_movement(direction: int = 0, move_speed: float = 0.0) -> void:
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	else:
		velocity.x = direction * move_speed

# Events

func on_player_entered_fan_zone(force: float, force_direction: String) -> void:
	
	change_state(PlayerState.Pushed, { "force": force, "force_direction": force_direction })

func on_player_exited_fan_zone() -> void:
	await get_tree().create_timer(0.20).timeout
	change_state(PlayerState.Fall)
