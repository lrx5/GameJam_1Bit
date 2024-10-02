class_name Tower
extends StaticBody2D

@export var projectileSpawner	: ProjectileSpawner
@export var attackRange			: AttackRange
@export var gunPivot			: GunPivot

var attackTimer : float = 0


@export_range(0,10,0.1,"or_greater") var attackSpeed: float = 2: ##Number of projectiles shot per second
	set(value):
		attackSpeed = 1 / value

func _ready():
	print("My global position to the world is: ", global_position)
	print("My canvas position is: ",get_global_transform_with_canvas().get_origin())

func attackCooldown(delta):
	attackTimer += delta
	if attackTimer >= attackSpeed:
		attackTimer = 0
		return true
	else:
		return false

func _onMouseEnter() -> void:
	if not SceneInteraction.buildMode:
		print("My canvas origin is: ", get_global_transform_with_canvas().origin)

		SceneInteraction.toggleBuildMode(true)

		SceneInteraction.toggleSelect(true,get_global_transform_with_canvas().origin)

func _onMouseExit() -> void:
	if SceneInteraction.buildMode:
		SceneInteraction.toggleBuildMode(false)
		SceneInteraction.toggleSelect(false)
