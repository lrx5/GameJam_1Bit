class_name Attack
extends ActionState

func _enter():
	print("Enter Attack")
	
func _exit():
	pass

func _processState(delta):
	pass
	if character.velocity != Vector2.ZERO:
		character.velocity = Vector2.ZERO
