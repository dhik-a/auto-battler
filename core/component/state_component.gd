class_name StateComponent
extends Node

enum State {
	IDLE,
	ATTACK,
	HURT,
	DEAD
}

signal state_changed(new_state)

var current_state := State.IDLE
var queue_state := State.IDLE

func set_state(new_state : State) -> void:
	if new_state == current_state:
		return
	
	## put the state in queue if actor is busy doing something else
	if current_state != State.IDLE:
		queue_state = new_state
	else:
		current_state = new_state
		emit_signal("state_changed", new_state)
	
func next_state() -> void:
	if current_state == queue_state:
		return
	current_state = queue_state
	queue_state = State.IDLE
	emit_signal("state_changed", current_state)
