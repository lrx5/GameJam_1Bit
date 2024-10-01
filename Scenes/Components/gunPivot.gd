class_name GunPivot
extends Node2D

@export var defaultSpriteDirection	: Vector2		= Vector2.DOWN
@export var inRange					: AttackRange
@export_range(0,1, 0.01, "or_greater") var rotationSpeed = 0.08

@onready var startShooting : bool = false

func _process(_delta: float) -> void:
	if inRange.prevTarget and is_instance_valid(inRange.prevTarget):
		
		var currentRotation = rotation
		var enemyPosition = inRange.prevTarget.global_position
		var gunRotation = global_position.angle_to_point(enemyPosition)
		var finalRotation = defaultSpriteDirection.rotated(gunRotation).angle()
	
		finalRotation = _adjustFinalRotation(currentRotation,finalRotation)
		
		rotation = move_toward(rotation,finalRotation, rotationSpeed)
		
		startShooting = true if round(rotation) == round(finalRotation) else false
		
	else:
		rotation = move_toward(rotation,0,rotationSpeed)
		startShooting = false

func _adjustFinalRotation(currentRotation,finalRotation):
		
	if abs(sign(currentRotation)) != 0:
		if sign(currentRotation) != sign(finalRotation):
			if sign(currentRotation) == -1:
				finalRotation -= deg_to_rad(360)
			elif sign(currentRotation) == 1:
				finalRotation += deg_to_rad(360)

	return finalRotation
		
