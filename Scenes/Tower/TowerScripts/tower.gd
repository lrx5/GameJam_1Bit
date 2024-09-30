class_name Tower
extends StaticBody2D

@export var projectileSpawner	: ProjectileSpawner
@export var attackRange			: AttackRange
@export var gunPivot			: GunPivot


var attackTimer : float = 0


@export_range(0,10,0.1,"or_greater") var attackSpeed: float = 2: ##Number of projectiles shot per second
	set(value):
		attackSpeed = 1 / value

func attackCooldown(delta):
	attackTimer += delta
	if attackTimer >= attackSpeed:
		attackTimer = 0
		return true
	else:
		return false
