class_name MainTower
extends Tower

@export_category("Tower Quadrants")
@export var quadrant1: MainTowerQuadrant
@export var quadrant2: MainTowerQuadrant
@export var quadrant3: MainTowerQuadrant
@export var quadrant4: MainTowerQuadrant

var quad1Health : float = 0

@export_category("Gun Parts")
@export var gunPivot 		: GunPivot
@export var bulletSpawn		: Node2D
@export var defaultPosition	: Vector2 = Vector2.RIGHT


@export_category("Projectiles")
@export var projectilePacker : ProjectilePacker
@onready var projectileField : Node = get_tree().get_first_node_in_group("projectileField")

var projectile
@onready var wantToShoot: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		wantToShoot = true
		if wantToShoot:
			shoot()
			wantToShoot = false
			
func shoot():
	projectile = projectilePacker.projectileScene.instantiate() as Projectile
	projectileField.add_child(projectile)
	projectile.name = projectilePacker.projectileName
	projectile.global_position = bulletSpawn.global_position
	var gunDirection = defaultPosition.rotated(gunPivot.global_rotation)
	
	projectile.shoot(gunDirection)
	
