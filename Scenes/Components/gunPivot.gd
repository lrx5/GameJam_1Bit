class_name GunPivot
extends Node2D

@export var inRange	: AttackRange

func _ready():
	print(inRange.targetPriority)

func _process(_delta: float) -> void:
	if inRange.target:
		var enemyPosition = inRange.target.global_position
		rotation = global_position.angle_to_point(enemyPosition)
		
		
	#get mouse position
	#var mousePos = get_global_mouse_position()
	#set the rotation of self into the direction of mouse
	#calculates the angle of the line that forms from the
	#global position of the launcher and the mouse position 
	#rotation = global_position.angle_to_point(mousePos)

	
