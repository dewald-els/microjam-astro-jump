extends Area2D


@onready var booster_particles: GPUParticles2D = %BoosterParticles
@onready var booster_light: PointLight2D = %BoosterLight
@onready var ship: Node2D = %Ship


var can_take_off: bool = false
var move_speed: float = 25.0


func _ready() -> void:
	connect("body_entered", on_body_entered)
	SignalBus.connect("finish_can_take_off", on_finish_can_take_off)
	
	
func _process(delta: float) -> void:
	if can_take_off and ship.position.y > -1000:
		ship.position.y = move_toward(ship.position.y, -1000, delta * move_speed)
		booster_light.energy = lerp(booster_light.energy, get_booster_light_next(), delta)
		
		
func get_booster_light_next() -> float:
	if booster_light.energy >= 1.0:
		return 0.0
	if booster_light.energy <= 0.0:
		return 1.0
	
	return 1.0
	

func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_reached_exit")
		booster_particles.emitting = true
		booster_light.enabled = true


func on_finish_can_take_off() -> void:
	can_take_off = true
	
