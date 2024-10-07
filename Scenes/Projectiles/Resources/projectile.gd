class_name Projectile
extends CharacterBody2D

@export var projectileSprite : AutoSprite
@export var defaultAngle : Vector2 = Vector2.DOWN							##Vector angle of the projectile Sprite. Y values are inverted meaning that the up direction is negative rather than the usual being positive.

@export_category("Projectile Variables")
@export_range(0,50,0.5, "or_greater") var projectileDamage			: float = 1		##Damage dealt by the projectile
@export_range(100,400,10, "or_greater") var projectileSpeed			: float = 250	##Movement speed of the projectile
@export_range(0,40,0.5, "or_greater")	var projectileKnockback		: float = 5

@export_category("Hitbox")
@export var hitbox : Hitbox :
	set(value):
		if is_instance_valid(hitbox):
			hitbox.hit.disconnect(_onHit)
		
		hitbox = value
		
		if is_instance_valid(hitbox):
			hitbox.hit.connect(_onHit)

func _process(delta: float) -> void:
	move_and_slide()


func shoot(projectileDirection : Vector2):
	velocity = projectileSpeed * projectileDirection

func _onHit(target : Hurtbox):
	queue_free()


func setProjectile(type: StringName):	##Set tier of projectile
	var newProjectile : Texture2D
	match type:
		"tier1":
			newProjectile = projectileSprite.tier1
		"tier2":
			newProjectile = projectileSprite.tier2
		"tier3":
			newProjectile = projectileSprite.tier3
			
	if projectileSprite.texture != newProjectile:
		projectileSprite.texture = newProjectile

func _onScreenExit() -> void:
	queue_free()
