class_name Projectile
extends CharacterBody2D

@export_range(0,50,0.5, "or_greater") var projectileDamage : float = 1		##Damage dealt by the projectile
@export_range(100,400,10, "or_greater") var projectileSpeed : float = 250	##Movement speed of the projectile
@export var defaultAngle : Vector2 = Vector2.DOWN							##Vector angle of the projectile Sprite. Y values are inverted meaning that the up direction is negative rather than the usual being positive.

func shoot(projectileDirection : Vector2):
	velocity = projectileSpeed * projectileDirection
