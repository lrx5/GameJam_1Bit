class_name Enemy
extends Characters

var initTarget 	: MainTowerQuadrant

var isIdle 		= "parameters/StateMachine/conditions/isIdle"
var isRunning 	= "parameters/StateMachine/conditions/isRunning"


func _ready():
	_setInitTarget()

func _process(_delta: float) -> void:
	move_and_slide()

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

	#print("I am enemy: ", name)
	#print("The shortest distance to a quadrant is ", towerDistance.min(),". This quadrant is "\
	#,quadDict.find_key(towerDistance.min()))
	initTarget = quadDict.find_key(towerDistance.min())
	
	
