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
		hurtbox.receiveDamage(projectileType.projectileDamage) #projectileType.knockbackForce * sign(projectileType.velocity.x))
		hit.emit(hurtbox)
