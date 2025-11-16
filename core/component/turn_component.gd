class_name TurnComponent
extends Node

signal turn_ready

var gauge := 0.0
var max_gauge := 10.0
var speed := 2.5

func _process(delta: float) -> void:
	if gauge < max_gauge:
		gauge += speed * delta
		if gauge >= max_gauge:
			gauge = max_gauge
			emit_signal("turn_ready")
			
func get_max_gauge() -> float:
	return max_gauge

func get_current_gauge() -> float:
	return gauge
			
func reset_gauge() -> void:
	gauge = 0.0

func set_speed(agility : int) -> void:
	speed = agility / 10
	
