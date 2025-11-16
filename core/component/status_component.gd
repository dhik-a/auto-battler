class_name StatusComponent
extends Node

@export var health : int = 30
@export var max_health : int = 30
@export var agility : int = 20
@export var mana : int = 30

func take_damage(value : int) -> void:
	if value >= health:
		health = 0
	else:
		health -= value
		
func restore_health(value : int) -> void:
	if(value + health) > max_health:
		health = max_health
	else:
		health += value

func is_dead() -> bool:
	return health <= 0
