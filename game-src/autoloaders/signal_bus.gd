extends Node

signal player_entered_fan_zone(fan_power: float, direction: String)
signal player_exited_fan_zone
signal player_dead
signal player_reached_exit

signal oxygen_depleted
signal oxygen_collect(oxygen_value: float)

signal restart_level
