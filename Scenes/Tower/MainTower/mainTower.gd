class_name MainTower
extends Tower

@export_category("Tower Quadrants")
@export var quadrant1: MainTowerQuadrant
@export var quadrant2: MainTowerQuadrant
@export var quadrant3: MainTowerQuadrant
@export var quadrant4: MainTowerQuadrant

var quad1Health : float = 0


@onready var wantToShoot: bool = false
@export var animGun : AnimatedSprite2D

@onready var canShoot = true

var cooldown : float = 0

func _ready():
	super._ready()
	animGun.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and canShoot:
		projectileSpawner.shoot()
		canShoot = false
		
	if not canShoot:
		shootCooldown(delta)
			
func shootCooldown(delta):
	cooldown += delta
	if cooldown > 5:
		canShoot = true
		cooldown = 0
