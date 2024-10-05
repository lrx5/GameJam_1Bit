class_name Enemy
extends Characters

@export_range(0,100,0.5,"or_greater") var damage : float = 10
@export var detectionRange 	: Area2D
@export var hitbox			: Hitbox
var knockbackDir : Vector2


var towersDetected	: Array
var target			: Tower
var initTarget 		: MainTowerQuadrant

var isIdle 		= "parameters/StateMachine/conditions/isIdle"
var isRunning 	= "parameters/StateMachine/conditions/isRunning"
var isAttacking = "parameters/isAttacking/request"

@onready var damaging	: bool = false
@onready var attackBool : bool = false
@onready var detectBool : bool = false
@onready var hurtBool 	: bool = false
@onready var deathBool	: bool = false

	
func _physics_process(delta: float) -> void:
	_setNewTarget()
	move_and_slide()


func _setNewTarget():
	if detectionRange.has_overlapping_bodies():
		detectBool = true
		var sortDistance	: Array
		var sortTargetTower : Dictionary
		for tower in detectionRange.get_overlapping_bodies():
			if tower is Tower and not tower in sortTargetTower:
				sortDistance.append(global_position.distance_to(tower.global_position))
				sortTargetTower[tower] = global_position.distance_to(tower.global_position)
				
		var closeDist = sortDistance.min()
		var closeTarget = sortTargetTower.find_key(closeDist)
		
		if target != closeTarget:
			target = closeTarget
	
	else:
		target = null
		detectBool = false


func _setInitTarget():
	var quadDict		: Dictionary
	var towerDistance 	: Array
	var mainTower = get_tree().get_first_node_in_group("mainTower")
	
	for child in mainTower.get_child_count():
		if mainTower.get_child(child) is MainTowerQuadrant:
			var quad = mainTower.get_child(child)
			var quadVector = quad.defaultVector.rotated(quad.global_rotation)
			#convert the value of the quad vector into the nearest tenths
			var x = snappedf(quadVector.x, 0.1)
			var y = snappedf(quadVector.y, 0.1)
			quadVector = Vector2(x,y)
			var quadDirection = quad.global_position + quadVector
			var distance = global_position.distance_to(quadDirection)
			quadDict[quad] = distance
			towerDistance.append(distance)

	initTarget = quadDict.find_key(towerDistance.min())


func onTowerExit(area: Area2D) -> void:
	if target.is_ancestor_of(area):
		target = null
	attackBool = false

func onTowerEnter(area: Area2D) -> void:
	attackBool = true
