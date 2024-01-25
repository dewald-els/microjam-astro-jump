class_name RetryScreen
extends CanvasLayer

@onready var retry_button: Button = %RetryButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Entered retry")
	#get_tree().paused = true
	retry_button.connect("pressed", on_retry_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		trigger_restart()

func trigger_restart() -> void:
	print("Restart trigger")
	SignalBus.emit_signal("restart_level")


func on_retry_pressed() -> void:
	print("Button pressed")
	trigger_restart()
