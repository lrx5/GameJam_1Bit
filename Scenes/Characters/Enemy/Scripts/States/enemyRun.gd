class_name EnemyRun
extends MoveState


var myPos
var targetPos
var myRot


func _enter():
	character.animTree.set(character.isRunning, true)
	if not character.initTarget:
		character._setInitTarget()
		myPos =  character.global_position
		targetPos = character.initTarget.global_position
		var initDirection = myPos.direction_to(targetPos)
		character.rotation = initDirection.angle() - deg_to_rad(90)
		
func _exit():
	character.animTree.set(character.isRunning, false)

func _processState(_delta):
	#	print("I should have a target now in the name of: ",character.initTarget.name)
	if character.initTarget:
		myPos = character.global_position
		targetPos = character.initTarget.global_position
		directionToDestination(myPos)
		character.velocity = character.direction * character.runSpeed
		character.rotation = character.direction.angle() - deg_to_rad(90)
	
		
func _processPhysics(_delta):
	pass

func directionToDestination(pos):
	var newX = abs(round(pos.x))
	var newY = abs(round(pos.y))
	var newPos = Vector2(newX,newY)
	if newPos == Vector2.ZERO:
		character.direction = Vector2.ZERO
	else:
		character.direction = myPos.direction_to(targetPos)
