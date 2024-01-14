class_name Player
extends CharacterBody2D

@onready var state_machine: StateMachine = %StateMachine
@onready var label: Label = %DebugLabel
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite


const SPEED = 95.0

func _physics_process(_delta: float):
	move_and_slide()
