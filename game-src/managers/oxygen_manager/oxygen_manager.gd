class_name OxygenManager
extends Node

@export var total_oxygen: float

@onready var oxygen_label: Label = %OxygenLabel
@onready var oxygen_timer: Timer = %OxygenTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	oxygen_timer.wait_time = total_oxygen
	SignalBus.connect("oxygen_collect", on_oxygen_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	oxygen_label.text = "Oxygen: " + str(roundf(oxygen_timer.time_left / total_oxygen * 100)) + "%"


func on_oxygen_collected(oxygen_value: float) -> void:
	var current_time: float = oxygen_timer.time_left
	var new_time: float = current_time + oxygen_value
	if new_time > total_oxygen:
		new_time = total_oxygen
	oxygen_timer.stop()
	oxygen_timer.wait_time = new_time
	oxygen_timer.start()
