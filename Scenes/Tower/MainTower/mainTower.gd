class_name MainTower
extends Tower

@export_category("Tower Quadrants")
@export var quadrant1: MainTowerQuadrant
@export var quadrant2: MainTowerQuadrant
@export var quadrant3: MainTowerQuadrant
@export var quadrant4: MainTowerQuadrant
@onready var quadrants = [quadrant1,quadrant2,quadrant3,quadrant4]
@export var main_gun: MainGunPivot
@export var main_tower_sfx: AudioStreamPlayer

var quad1Health : float = 0

@onready var wantToShoot: bool = false
@export var animGun : AnimatedSprite2D

@onready var canShoot = true

var cooldown : float = 0
var stillAlive : bool = true

var FRlvl = 0
var DMGlvl = 0
var RNGlvl = 0


func _ready():
	super._ready()
	animGun.play()
	#print(get_children())
func _process(delta: float) -> void:
	for quad in quadrants:
		if not is_instance_valid(quad):
			quadrants.erase(quad)
	
	if not quadrants:
		SceneInteraction.gameEnd = true
		
	attackRange.attackRange = UpgradesManager.mainRNG[RNGlvl]*18
	
	if Input.is_action_just_pressed("shoot") and canShoot:
		projectileSpawner.shoot()
		canShoot = false
		start_tweening()
		main_tower_sfx.play()
	if not canShoot:
		shootCooldown(delta)
			
func start_tweening():
	var tween = create_tween()
	tween.tween_property(main_gun, "scale", Vector2(1.2,  1.2), 0.1)
	tween.tween_property(main_gun, "scale", Vector2(1.0,  1.0), 0.5)

func shootCooldown(delta):
	cooldown += delta
	if cooldown > UpgradesManager.mainFR[FRlvl]:
		canShoot = true
		cooldown = 0
