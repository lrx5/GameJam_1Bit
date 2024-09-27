class_name ProjectileSpawner
extends Node2D

@export_category("Gun Variables")
@export var gunPivot 				: GunPivot					##Reference to the Gun Pivot
@export var defaultAngle			: Vector2 = Vector2.RIGHT	##Vector angle of the projectile Sprite. Y values are inverted meaning that the up direction is negative rather than the usual being positive.
@onready var projectileSpawner		: ProjectileSpawner = self


@export_category("Projectile")
@export var projectilePacker : ProjectilePacker
@onready var projectileField : Node = get_tree().get_first_node_in_group("projectileField")

var projectile

func shoot():
	projectile = projectilePacker.projectileScene.instantiate() as Projectile
	projectileField.add_child(projectile)
	projectile.name = projectilePacker.projectileName
	projectile.global_position = projectileSpawner.global_position
	var gunDirection = defaultAngle.rotated(gunPivot.global_rotation)
	projectile.rotation = Vector2.DOWN.rotated(gunPivot.global_rotation).angle()#projectilePosition.rotated(gunPivot.rotation) 
	projectile.shoot(gunDirection)
	
