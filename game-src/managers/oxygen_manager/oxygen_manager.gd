class_name OxygenManager
extends Node

@export var total_oxygen: float

@onready var oxygen_label: Label = %OxygenLabel
@onready var oxygen_timer: Timer = %OxygenTimer

var player_reached_exit: bool = false


func _ready() -> void:
	oxygen_timer.connect("timeout", on_oxygen_depleted)
	oxygen_timer.wait_time = total_oxygen
	SignalBus.connect("oxygen_collect", on_oxygen_collected)
	SignalBus.connect("player_reached_exit", on_player_reached_exit)



func _process(_delta: float) -> void:
	if player_reached_exit:
		oxygen_timer.stop()
		return
		
	var oxygen_level:float = roundf(oxygen_timer.time_left / total_oxygen * 100)
	oxygen_label.text = "Oxygen: " + str(oxygen_level) + "%"
	if oxygen_level == 0:
		pass
	elif (oxygen_level < 20): 
		pass
	elif oxygen_level < 40:
		pass
	


func on_oxygen_depleted() -> void:
	SignalBus.emit_signal("oxygen_depleted")

# Events

func on_player_reached_exit() -> void:
	player_reached_exit = true

func on_oxygen_collected(oxygen_value: float) -> void:
	var current_time: float = oxygen_timer.time_left
	var new_time: float = current_time + oxygen_value
	if new_time > total_oxygen:
		new_time = total_oxygen
	oxygen_timer.stop()
	oxygen_timer.wait_time = new_time
	oxygen_timer.start()
