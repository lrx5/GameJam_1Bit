class_name CannonTower
extends Tower

var tween
@onready var cannon_sprite: Sprite2D = $GunPivot/CannonSprite

func _process(delta: float) -> void:
	if attackRange.target and attackCooldown(delta) and gunPivot.startShooting:
		projectileSpawner.shoot()
		startTweening()

#region Turret Recoil Tween TESTING
func startTweening():
	tween = create_tween()
	# Cannon Recoil
	tween.set_ease(Tween.EASE_IN_OUT).tween_property(cannon_sprite, "position:y", 2, 0.1).as_relative()
	# Cannon Recoil Reset
	tween.set_ease(Tween.EASE_IN_OUT).tween_property(cannon_sprite, "position:y", -2, 1).as_relative()
#endregion
		
