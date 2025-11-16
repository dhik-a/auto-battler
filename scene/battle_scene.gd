class_name BattleScene
extends Node2D

@onready var player : Player = $Player
@onready var enemy : Enemy = $Enemy
@onready var battleStateLabel : RichTextLabel = $CanvasLayer/Control/BattleStateLabel

enum BattleState {
	STARTING,
	ONGOING,
	VICTORY,
	LOST
}

var battle_state : = BattleState.ONGOING

func _ready() -> void:
	player.attacking.connect(_on_player_attack)
	enemy.attacking.connect(_on_enemy_attack)
	
	player.is_dead.connect(_on_player_defeated)
	enemy.is_dead.connect(_on_enemy_defeated)

func _process(delta: float) -> void:
	match battle_state:
		BattleState.STARTING:
			battleStateLabel.text = "Encounter!"
		BattleState.ONGOING:
			battleStateLabel.text = ""
		BattleState.VICTORY:
			battleStateLabel.text = "Victory!"
		BattleState.LOST:
			battleStateLabel.text = "Defeated..."
	
func _on_player_attack() -> void:
	enemy.attacked()

func _on_enemy_attack() -> void:
	player.attacked()

func _on_player_defeated() -> void:
	battle_state = BattleState.LOST

func _on_enemy_defeated() -> void:
	battle_state = BattleState.VICTORY
