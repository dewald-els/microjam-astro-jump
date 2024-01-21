extends Node

signal player_entered_fan_zone(fan_power: float, direction: String)
signal player_exited_fan_zone

signal oxygen_depleted
signal oxygen_collect(oxygen_value: float)
