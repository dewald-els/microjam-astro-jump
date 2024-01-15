extends Node

@export var total_oxygen: float


@onready var oxygen_label: Label = %OxygenLabel
@onready var oxygen_timer: Timer = %OxygenTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	oxygen_timer.wait_time = total_oxygen


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	oxygen_label.text = "Oxygen: " + str(roundf(oxygen_timer.time_left / total_oxygen * 100)) + "%"
