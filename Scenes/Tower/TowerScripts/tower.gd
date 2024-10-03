class_name Tower
extends StaticBody2D

signal towerUpgraded

@export var projectileSpawner	: ProjectileSpawner
@export var attackRange			: AttackRange
@export var gunPivot			: GunPivot

@export_range(0,10,0.1,"or_greater") var attackSpeed: float = 2: ##Number of projectiles shot per second
	set(value):
		attackSpeed = 1 / value


@export_enum("tier1","tier2", "tier3") var towerTier = "tier1":
	set(value):
		emit_signal("towerUpgraded",value)
		towerTier = value

@export var healthManager : HealthManager


var attackTimer : float = 0

func attackCooldown(delta):
	attackTimer += delta
	if attackTimer >= attackSpeed:
		attackTimer = 0
		return true
	else:
		return false

func _onMouseEnter() -> void:
	if not SceneInteraction.buildMode:

		SceneInteraction.toggleBuildMode(true)

		SceneInteraction.toggleSelect(true,get_global_transform_with_canvas().origin)

func _onMouseExit() -> void:
	if SceneInteraction.buildMode:
		SceneInteraction.toggleBuildMode(false)
		SceneInteraction.toggleSelect(false)
