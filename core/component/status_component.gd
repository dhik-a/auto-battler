class_name StatusComponent
extends Node

@export var health : int = 30
@export var max_health : int = 30
@export var mana : int = 30
@export var max_mana : int = 30

@export var strength : int = 20
@export var agility : int = 20
@export var defense : int = 20

func reduce_health(value : int) -> void:
	if value >= health:
		health = 0
	else:
		health -= value
		
func restore_health(value : int) -> void:
	if(value + health) > max_health:
		health = max_health
	else:
		health += value
		
func reduce_mana(value : int) -> void:
	if value >= mana:
		mana = 0
	else:
		mana -= value

func restore_mana(value : int) -> void:
	if(value + mana) > max_mana:
		mana = max_mana
	else:
		mana += value

func calculate_damage(attack_strength : int) -> int:
	## use this formula --> damage = STR * (K / (K + DEF)) where K = 20
	## use 20.0 to assign float type, because int can't divide with larger value (will result in 0)
	return floori(attack_strength * (20.0 / (20.0 + defense)))

func is_dead() -> bool:
	return health <= 0
