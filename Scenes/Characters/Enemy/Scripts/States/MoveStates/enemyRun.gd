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
			targetPos = character.target.global_position
	elif character.initTarget and not character.target:
		targetPos = character.initTarget.global_position
	
	myPos = character.global_position
	var newDirection = myPos.direction_to(targetPos)
	character.set_velocity(newDirection * character.runSpeed)
	character.rotation = newDirection.angle() - deg_to_rad(90)


func directionToDestination(pos):
	var newX = abs(round(pos.x))
	var newY = abs(round(pos.y))
	var newPos = Vector2(newX,newY)
	if newPos == Vector2.ZERO:
		character.direction = Vector2.ZERO
	else:
		character.direction = myPos.direction_to(targetPos)
