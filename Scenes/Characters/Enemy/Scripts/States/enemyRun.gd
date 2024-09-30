class_name EnemyRun
extends MoveState



func _enter():
	character.animTree.set(character.isRunning, true)
	if not character.initTarget:
		character._setInitTarget()
		#print("Character original rotation: ", character.rotation)
		#character.global_rotation = character.global_position.angle_to_point(character.initTarget.global_position)
		var myPos =  character.global_position
		var targetPos = character.initTarget.global_position
		var initDirection = myPos.direction_to(targetPos)
		character.rotation = initDirection.angle() - deg_to_rad(90)
		
func _exit():
	character.animTree.set(character.isRunning, false)

func _processState(_delta):
	
	#	print("I should have a target now in the name of: ",character.initTarget.name)
	if character.initTarget:
		character.direction = character.global_position.direction_to(character.initTarget.global_position)
		character.velocity = character.direction * character.runSpeed
		
func _processPhysics(_delta):
	pass
