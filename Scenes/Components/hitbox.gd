class_name Hitbox
extends Area2D

signal hit(target: Hurtbox) ##A node has to reference this hitbox to connect
@export var projectileType: Projectile ##Reference to the projectile

func _ready() -> void:
	area_entered.connect(_onAreaEntered)
	
func _onAreaEntered(hurtArea : Area2D):
	var hurtbox = hurtArea as Hurtbox
	if not hurtbox is Hurtbox || not hurtbox.isNotDeadYet():
		return
	else:
		var knockbackDirection = projectileType.global_position.direction_to(hurtbox.global_position)
		
		hurtbox.receiveDamage(projectileType.projectileDamage, projectileType.projectileKnockback * knockbackDirection)
		hit.emit(hurtbox)
