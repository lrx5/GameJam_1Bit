class_name AttackRange
extends Area2D

@onready var hasDetectedEnemy 	: bool = false
@onready var target 				: Characters

@export_enum("Farthest","Nearest","Highest HP", "Fastest") var targetPriority = "Farthest"

var enemiesDetected	: Array
var enemiesStatDict : Dictionary


func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	_setTarget()

func _physics_process(_delta: float) -> void:
	enemiesDetected = get_overlapping_bodies()

func _setTarget():
	var valueSort : Array
	match targetPriority:
		"Farthest", "Nearest":
			for enemy in enemiesDetected:
				enemiesStatDict[enemy] = global_position.distance_to(enemy.global_position)
				valueSort.append(global_position.distance_to(enemy.global_position))
			if targetPriority == "Farthest":
				target = enemiesStatDict.find_key(valueSort.max())
			else:
				target = enemiesStatDict.find_key(valueSort.min())
		"Fastest":
			for enemy in enemiesDetected:
				enemiesStatDict[enemy] = enemy.runSpeed
				print(enemy.runSpeed)
				valueSort.append(enemy.runSpeed)
			target =  enemiesStatDict.find_key(valueSort.max())
		"HighestHP":
			for enemy in enemiesDetected:
				if enemy.healthManager:
					enemiesStatDict[enemy]= enemy.healthManager.currentHealth
					valueSort.append(enemy.healthManager.currentHealth)
				target = enemiesStatDict.find_key(valueSort.max())
				
			
		
