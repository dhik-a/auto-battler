class_name Actor
extends Node2D

@export var turn_gauge_bar : ProgressBar
@export var health_label : RichTextLabel

@onready var status : StatusComponent = $StatusComponent
@onready var turn : TurnComponent = $TurnComponent
@onready var state : StateComponent = $StateComponent
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

signal attacking
signal is_dead

func _ready() -> void:
	turn.turn_ready.connect(_on_turn_ready)
	state.state_changed.connect(_on_state_changed)
	sprite.animation_finished.connect(_on_anim_finished)
	_set_turn_gauge_bar()

func _process(delta: float) -> void:
	_health_check()
	_set_gauge_speed()
	_set_turn_gauge_bar()
	_set_health_label()

### ----------------------------------------------
### UI Modification
### ----------------------------------------------

func _set_turn_gauge_bar() -> void:
	turn_gauge_bar.max_value = turn.get_max_gauge()
	turn_gauge_bar.value = turn.get_current_gauge()

func _set_health_label() -> void:
	health_label.text = str(status.health) + "/" + str(status.max_health)

### ----------------------------------------------
### Status Modification
### ----------------------------------------------

func _set_gauge_speed() -> void:
	var agility = status.agility
	if state.current_state != state.State.IDLE:
		agility = 0
	turn.set_speed(agility)

func _health_check() -> void:
	if status.is_dead():
		state.set_state(state.State.DEAD)
		turn.reset_gauge()
		emit_signal("is_dead")

### ----------------------------------------------
### Turn / State Modification
### ----------------------------------------------

func _on_turn_ready() -> void:
	state.set_state(state.State.ATTACK)

func _on_state_changed(new_state) -> void:
	match new_state:
		state.State.IDLE:
			sprite.play("default")
		state.State.ATTACK:
			sprite.play("attack")
			emit_signal("attacking")
		state.State.HURT:
			sprite.play("hurt")
		state.State.DEAD:
			sprite.play("dead")
		state.State.VICTORY:
			sprite.play("victory")

### ----------------------------------------------
### Animation / Sprite Modification
### ----------------------------------------------

func _on_anim_finished() -> void:
	if state.current_state == state.State.ATTACK:
		turn.reset_gauge()
	if state.current_state != state.State.DEAD:
		state.next_state()

### ----------------------------------------------
### Public Functions
### ----------------------------------------------

func attacked(attack_strength : int) -> void:
	state.set_state(state.State.HURT)
	var damage = status.calculate_damage(attack_strength)
	status.reduce_health(damage)
	
func victory_achieved() -> void:
	turn.reset_gauge()
	state.set_state(state.State.VICTORY)
