class_name Player
extends CharacterBody2D

@onready var state_machine: StateMachine = %StateMachine
@onready var label: Label = %DebugLabel
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite


const SPEED = 75.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
