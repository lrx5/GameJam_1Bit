class_name EnemyDeath
extends ActionState

func _enter():
	character.queue_free()
	print("I died")
