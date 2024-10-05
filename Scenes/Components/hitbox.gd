class_name Hitbox
extends Area2D

signal hit(target: Hurtbox) ##A node has to reference this hitbox to connect
@export var projectileType: Projectile ##Reference to the projectile

var towersDetected

func _ready() -> void:
	area_entered.connect(_onAreaEntered)
	
func _physics_process(delta: float) -> void:
	if get_parent() is Enemy:
		if has_overlapping_areas():
			for tower in get_overlapping_areas():
				if get_parent().damaging:
					processDamage(tower)
	
func _onAreaEntered(hurtArea : Hurtbox):
	processDamage(hurtArea)

func processDamage(hurtbox: Hurtbox):
	if hurtbox.isNotDeadYet():
		if hurtbox.get_parent() is Enemy:
			var knockbackDirection = projectileType.global_position.direction_to(hurtbox.global_position)
			hurtbox.receiveDamage(projectileType.projectileDamage, projectileType.projectileKnockback * knockbackDirection)
			hit.emit(hurtbox)
			
		if hurtbox.get_parent() is Tower:
			hurtbox.receiveDamage(get_parent().damage)
			hit.emit(hurtbox)
			
	else: return
