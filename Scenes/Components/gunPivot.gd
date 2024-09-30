class_name GunPivot
extends Node2D

@export var defaultSpriteDirection	: Vector2		= Vector2.DOWN
@export var inRange					: AttackRange
@export_range(0,1, 0.01, "or_greater") var rotationSpeed = 0.08

@onready var startShooting : bool = false

func _ready():
	print(inRange.targetPriority)

func _process(_delta: float) -> void:
	if inRange.target and is_instance_valid(inRange.target):
		var enemyPosition = inRange.target.global_position
		var gunRotation = global_position.angle_to_point(enemyPosition)
		var finalRotation = defaultSpriteDirection.rotated(gunRotation).angle()
		if round(finalRotation) == round(rotation):
			startShooting = true
		else:
			startShooting = false
		rotation = move_toward(rotation,finalRotation, rotationSpeed)
	else:
		startShooting = false

	
