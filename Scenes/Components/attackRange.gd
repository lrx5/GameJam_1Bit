class_name AttackRange
extends Area2D


@export_enum("Farthest","Nearest","Highest HP", "Fastest") var targetPriority = "Farthest"
@export_range(20,100,1, "or_greater") var attackRange 	: int = 80	##Set the range of the tower

@onready var shape = get_child(0).shape

@onready var hasDetectedEnemy 	: bool = false
var target 			: Enemy
var prevTarget		: Enemy

var parent = self
var enemiesDetected	: Array
var enemiesStatDict : Dictionary
	
func _ready():
	while not parent is Tower:
		parent = parent.get_parent()
	
	shape.radius = attackRange
	connect("body_exited", _onEnemyExit)
	connect("body_entered", _onEnemyEnter)
	
func _process(_delta: float) -> void:
	_setTarget()
	if shape.radius != attackRange:
		shape.radius = attackRange

func _physics_process(_delta: float) -> void:
	if get_overlapping_bodies():
		for enemy in get_overlapping_bodies():
			if enemy is Enemy and not enemy in enemiesDetected:
				enemiesDetected.append(enemy)
	else:
		enemiesDetected = []
		target = null		
	
	if prevTarget !=  target:
		prevTarget = target

func _onEnemyEnter(body: Node2D):
	if body is Enemy:
		if not enemiesDetected.has(body):
			enemiesDetected.append(body)

func _onEnemyExit(body: Node2D):
	#Ensures that when an enemy dies within the range it would get removed from the enemies array
	if body is Enemy:
		enemiesDetected.erase(body)
		#Removes the targeting since the enemy has died. 
		#It will also ensure that whenever the enemy goes past a tower's range, it would get removed
		#as a target
		target = null

func _setTarget():
	var valueSort : Array
	if enemiesDetected:
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
					valueSort.append(enemy.runSpeed)
				target =  enemiesStatDict.find_key(valueSort.max())
			"HighestHP":
				for enemy in enemiesDetected:
					if enemy.healthManager:
						enemiesStatDict[enemy]= enemy.healthManager.currentHealth
						valueSort.append(enemy.healthManager.currentHealth)
					target = enemiesStatDict.find_key(valueSort.max())
		
