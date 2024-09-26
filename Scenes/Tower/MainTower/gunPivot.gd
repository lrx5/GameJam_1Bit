class_name GunPivot
extends Node2D

@onready var defaultPosition : Vector2 = Vector2.UP

func _process(delta: float) -> void:
	#get mouse position
	var mousePos = get_global_mouse_position()
	#set the rotation of self into the direction of mouse
	#calculates the angle of the line that forms from the
	#global position of the launcher and the mouse position 
	rotation = global_position.angle_to_point(mousePos)
