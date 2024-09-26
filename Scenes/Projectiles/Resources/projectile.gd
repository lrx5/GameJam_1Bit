class_name Projectile
extends CharacterBody2D

@export_range(0,50,0.5, "or_greater") var projectileDamage : float = 1
@export_range(100,400,10, "or_greater") var projectileSpeed : float = 1

func launch(projectileDirection : Vector2):
	velocity = projectileSpeed * projectileDirection
