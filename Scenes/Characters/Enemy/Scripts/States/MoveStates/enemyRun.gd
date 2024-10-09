class_name EnemyRun
extends MoveState


var myPos
var targetPos
var myRot


func _enter():
	character.animTree.set(character.isRunning, true)
	setInitTarget()
	
func _exit():
	character.animTree.set(character.isRunning, false)

func _processState(delta):
	#	print("I should have a target now in the name of: ",character.initTarget.name)
	setTarget()
	
	
func _processPhysics(_delta):
	pass

func setInitTarget():
	character._setInitTarget()
	
	if character.target:
		targetPos = character.target.global_position
	elif character.initTarget and not character.target:
		targetPos = character.initTarget.global_position
	else:
		return
	
	myPos = character.global_position
	var initDirection = myPos.direction_to(targetPos)
	character.velocity = initDirection * character.runSpeed
	character.rotation = initDirection.angle() - deg_to_rad(90)

func setTarget():
	if character.target:
		if is_instance_valid(character.target):
			if character.target is MainTowerQuadrant:
				targetPos = quadrantOffset(character.target)
			else:
				targetPos = character.target.global_position
	elif character.initTarget and not character.target:
		if is_instance_valid(character.initTarget):
			targetPos = character.initTarget.global_position
	
	myPos = character.global_position
	var newDirection = myPos.direction_to(targetPos)
	character.set_velocity(newDirection * character.runSpeed)
	character.rotation = newDirection.angle() - deg_to_rad(90)



func quadrantOffset(target):
	var quadrantNewPos
	match target.name:
		"Quadrant1":
			quadrantNewPos = target.global_position + Vector2(-5,-5)
		"Quadrant2":
			quadrantNewPos = target.global_position + Vector2(5,-5)
		"Quadrant3":
			quadrantNewPos = target.global_position + Vector2(5,5)
		"Quadrant4":
			quadrantNewPos = target.global_position + Vector2(-5,5)
	
	return quadrantNewPos
