class_name Player
extends CharacterBody2D

enum PlayerState {
	Idle,
	Run,
	Jump,
	Die,
	Fall,
	Pushed,
	Dead,
	Finish
}

const States: Dictionary = {
	Idle = "Idle",
	Run = "Run",
	Jump = "Jump",
	Die = "Die",
	Dead = "Dead",
	Fall = "Fall",
	Pushed = "Pushed",
	Finish = "Finish",
}

@onready var state_machine: StateMachine = %StateMachine
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var jump_buffer_timer: Timer = %JumpBufferTimer

# Debug
@export_category("Debug")
@onready var label: Label = %DebugLabel
@onready var label_vel: Label = %DebugVelLabel
@export var enabled_debug_labels: bool = false

@export_category("Jump")
# Jump Mechanics: https://www.youtube.com/watch?v=IOe1aGY6hXA
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export_range(0.0, 1.0) var jump_smoothing: float

@export_category("Move")
@export var acceleration: float
@export var deceleration: float 
@export var move_speed: float


@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
const jump_drag_multiplier: int = 3

var was_on_floor: bool = false
var motion: Vector2 = Vector2.ZERO



func _ready() -> void:
	SignalBus.connect("player_entered_fan_zone", on_player_entered_fan_zone)
	SignalBus.connect("player_exited_fan_zone", on_player_exited_fan_zone)
	SignalBus.connect("oxygen_depleted", on_oxygen_depleted)
	SignalBus.connect("player_reached_exit", on_player_reached_exit)
	if not enabled_debug_labels:
		label.visible = false
		label_vel.visible = false

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
			state_machine.transition_to(States.Idle, _msg)
		PlayerState.Run:
			state_machine.transition_to(States.Run, _msg)
		PlayerState.Jump:
			state_machine.transition_to(States.Jump, _msg)
		PlayerState.Die:
			state_machine.transition_to(States.Die, _msg)
		PlayerState.Fall:
			state_machine.transition_to(States.Fall, _msg)
		PlayerState.Pushed:
			state_machine.transition_to(States.Pushed, _msg)
		PlayerState.Dead:
			state_machine.transition_to(States.Dead, _msg)
		PlayerState.Finish:
			state_machine.transition_to(States.Finish, _msg)
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
	velocity.y = lerp(velocity.y, jump_velocity, jump_smoothing)

func apply_movement(direction: int = 0, delta: float = 0.0) -> void:
	if direction == 0:
		motion.x = lerp(velocity.x * delta, 0.0, deceleration / 100)
	elif direction == 1:
		motion.x = lerp(motion.x, min(motion.x + acceleration * delta, move_speed), 0.25)
	elif direction == -1:
		motion.x = lerp(motion.x, max(motion.x - acceleration * delta, -move_speed), 0.25)
	
	velocity.x = motion.x

# Events

func on_oxygen_depleted() -> void:
	change_state(PlayerState.Die)

func on_player_entered_fan_zone(force: float, force_direction: String) -> void:
	change_state(PlayerState.Pushed, { "force": force, "force_direction": force_direction })

func on_player_exited_fan_zone(direction: String) -> void:
	if direction == "Up": # Allow velocity to normalise
		await get_tree().create_timer(0.20).timeout
	
	change_state(PlayerState.Fall)
	

func on_player_reached_exit() -> void:
	change_state(PlayerState.Finish)
