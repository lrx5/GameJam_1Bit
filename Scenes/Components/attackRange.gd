class_name AttackRange
extends Area2D

@onready var hasDetectedEnemy 	: bool = false
@onready var enemy 				: Characters

func _ready() -> void:
	body_entered.connect(_onEnemyDetected)
	body_exited.connect(_onEnemyOutOfRange)
	
func _process(delta: float) -> void:
	#if enemy:
	#	print("I'm tracking the position of the enemy in ",enemy.global_position)
	
	body_exited.disconnect(_onEnemyDetected)

func _onEnemyDetected(body : Characters):
	#hasDetectedEnemy = true
	print("Body detected")
	enemy = body
		
func _onEnemyOutOfRange(body : Characters):
	print("Enemy out of range")
	enemy = null
