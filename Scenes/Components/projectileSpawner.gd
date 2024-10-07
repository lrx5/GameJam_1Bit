class_name ProjectileSpawner
extends Node2D

@export_category("Gun Variables")
@export var gunPivot 				: GunPivot					##Reference to the Gun Pivot
@export var defaultAngle			: Vector2 = Vector2.UP	##Vector angle of the projectile Sprite. Y values are inverted meaning that the up direction is negative rather than the usual being positive.
@onready var projectileSpawner		: ProjectileSpawner = self

@export_category("Projectile")
@export var projectilePacker : ProjectilePacker
@onready var projectileField : Node = get_tree().get_first_node_in_group("projectileField")

var tower = self
var projectile

func _ready():
	while not tower is Tower:
		tower = tower.get_parent()

func shoot():
	projectile = projectilePacker.projectileScene.instantiate() as Projectile
	projectileField.add_child(projectile)
	projectile.name = projectilePacker.projectileName
	projectile.global_position = projectileSpawner.global_position
	#Set projectile tier depending on the tier of the tower
	projectile.setProjectile(tower.towerTier)
	if tower.towerStats:
		projectile.projectileDamage = tower.towerStats["damage"]
	
	#Direction the gun is looking offseted by the default angle
	var gunDirection = defaultAngle.rotated(gunPivot.global_rotation)
	#Sprite rotation of the projectile
	projectile.rotation = gunPivot.global_rotation
	#Assigns a direction to the projectile velocity
	projectile.shoot(gunDirection)
	
