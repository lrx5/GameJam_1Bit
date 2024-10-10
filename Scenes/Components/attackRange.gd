class_name AttackRange
extends Area2D

@export var tower : Tower
@export_enum("Farthest","Nearest","Highest HP", "Fastest") var targetPriority = "Nearest"
@export_range(20,100,1, "or_greater") var attackRange 	: int = 80	##Set the range of the tower

@export var range : CollisionShape2D

@onready var hasDetectedEnemy 	: bool = false
var target 			: Enemy
var prevTarget		: Enemy

var enemiesDetected	: Array
var enemiesStatDict : Dictionary

var newRange
	
func _ready():
	connect("body_exited", _onEnemyExit)
	connect("body_entered", _onEnemyEnter)
	
	createNewRange()
	
func _process(_delta: float) -> void:
	_setTarget()

func _physics_process(_delta: float) -> void:
	updateRange()
	
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
		if not enemiesDetected.has(body) and is_instance_valid(body):
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
					if is_instance_valid(enemiesStatDict.find_key(valueSort.max())):
						target = enemiesStatDict.find_key(valueSort.max())
				else:
					if is_instance_valid(enemiesStatDict.find_key(valueSort.min())):
						target = enemiesStatDict.find_key(valueSort.min())
			"Fastest":
				for enemy in enemiesDetected:
					enemiesStatDict[enemy] = enemy.runSpeed
					valueSort.append(enemy.runSpeed)
				if is_instance_valid(enemiesStatDict.find_key(valueSort.max())):
					target = enemiesStatDict.find_key(valueSort.max())
			"HighestHP":
				for enemy in enemiesDetected:
					if enemy.healthManager:
						enemiesStatDict[enemy]= enemy.healthManager.currentHealth
						valueSort.append(enemy.healthManager.currentHealth)
					if is_instance_valid(enemiesStatDict.find_key(valueSort.max())):
						target = enemiesStatDict.find_key(valueSort.max())
	if is_instance_valid(target):
		target = target
	else:
		target = null
func createNewRange():
	if newRange:
		newRange = null	
	newRange = CircleShape2D.new()
	newRange.radius = attackRange
	if range:
		range.shape = newRange
		
func updateRange():
	if range and is_instance_valid(range):
		if range.shape.radius != attackRange:
			range.shape.radius = attackRange
	
