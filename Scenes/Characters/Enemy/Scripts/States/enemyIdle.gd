class_name EnemyIdleMove
extends MoveState

func _enter():
	character.animTree.set(character.isIdle, true)

func _exit():
	character.animTree.set(character.isIdle, false)
