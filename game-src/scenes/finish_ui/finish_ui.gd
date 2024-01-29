class_name FinishScreen
extends CanvasLayer

@onready var play_again_button: Button = %PlayAgainButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_again_button.connect("pressed", on_retry_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		trigger_restart()

func trigger_restart() -> void:
	SignalBus.emit_signal("restart_level")


func on_retry_pressed() -> void:
	trigger_restart()
