class_name BeamTower
extends Tower

func _process(delta: float) -> void:
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
	
