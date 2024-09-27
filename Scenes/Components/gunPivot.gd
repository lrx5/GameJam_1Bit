class_name GunPivot
extends Node2D

@export var inRange	: AttackRange



func _process(delta: float) -> void:
	if inRange.enemy:
		var enemyPosition = inRange.enemy.global_position
		rotation = global_position.angle_to_point(enemyPosition)
		
	#get mouse position
	#var mousePos = get_global_mouse_position()
	#set the rotation of self into the direction of mouse
	#calculates the angle of the line that forms from the
	#global position of the launcher and the mouse position 
	#rotation = global_position.angle_to_point(mousePos)

	
