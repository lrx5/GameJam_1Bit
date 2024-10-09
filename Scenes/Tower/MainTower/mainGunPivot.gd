extends GunPivot
class_name MainGunPivot



func _process(_delta: float) -> void:
	var currentRotation = rotation
	var gunRotation = global_position.angle_to_point(get_global_mouse_position())
	var finalRotation = defaultSpriteDirection.rotated(gunRotation).angle()
	
		
	rotation = finalRotation
