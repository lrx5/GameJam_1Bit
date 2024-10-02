class_name CannonTower
extends Tower

var tween
@onready var cannon_sprite: Sprite2D = $GunPivot/CannonSprite



func _process(delta: float) -> void:
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
