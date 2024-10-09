class_name EnemyIdleMove
extends MoveState

func _enter():
	character.animTree.set(character.isIdle, true)

func _processState(_delta):
	pass
	#if character.name == "EnemyBig":
	#	print("EnemyBig is not moving")

func _exit():
	character.animTree.set(character.isIdle, false)
