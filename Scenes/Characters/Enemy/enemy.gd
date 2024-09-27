class_name Enemy
extends Characters

func _ready():
	velocity.y = runSpeed
	print("I am the enemy and my position is: ",global_position)

func _process(delta: float) -> void:
	move_and_slide()
	
