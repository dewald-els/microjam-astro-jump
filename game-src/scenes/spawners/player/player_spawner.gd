class_name CharacterSpawner
extends Marker2D

@export var player_scene: PackedScene
@onready var spawn_timer: Timer = %SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_spawn", on_player_spawn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_player_spawn(wait_time: float = 0.0) -> void:
	if spawn_timer.is_stopped() and wait_time > 0.0:
		spawn_timer.wait_time = wait_time
		spawn_timer.start()
		await spawn_timer.timeout
		
	var instance: Player = player_scene.instantiate() as Player
	get_parent().add_child(instance)
	instance.global_position = global_position
	SignalBus.emit_signal("player_was_spawned", instance)
	
