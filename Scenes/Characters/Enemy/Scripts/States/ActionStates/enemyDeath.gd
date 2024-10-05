class_name EnemyDeath
extends ActionState

func _enter():
	print("I died")
	character.process_mode = PROCESS_MODE_DISABLED
	character.queue_free()
