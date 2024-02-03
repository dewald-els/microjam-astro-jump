class_name State
extends Node

var state_machine: StateMachine

func _ready() -> void:
	pass

func handle_input(_input: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg: Dictionary = {}) -> void:
	print("Entered state: ", state_machine.get_state_name())
	pass


func exit() -> void:
	print("Exiting state: ", state_machine.get_state_name())
	pass

