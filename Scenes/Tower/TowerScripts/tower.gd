class_name Tower
extends StaticBody2D

signal towerUpgraded

@export var projectileSpawner	: ProjectileSpawner
@export var attackRange			: AttackRange
@export var gunPivot			: GunPivot

@export_range(0,10,0.1,"or_greater") var attackSpeed: float = 2 ##Number of projectiles shot per second
	#set(value):
	#	attackSpeed = 1 / value
@onready var damage : float = 0

@export_enum("tier1","tier2", "tier3") var towerTier = "tier1":
	set(value):
		emit_signal("towerUpgraded",value)
		towerTier = value

@export var healthManager : HealthManager

@onready var towerStats : Dictionary

@onready var hovered: bool = false
@onready var selected: bool = false
var attackTimer : float = 0


func _ready():
	connect("mouse_entered",_onMouseEnter)
	connect("mouse_exited",_onMouseExit)

func attackCooldown(delta):
	attackTimer += delta
	if attackTimer >= attackSpeed:
		attackTimer = 0
		return true
	else:
		return false


func setTowerStats(towerType: String):
	match towerTier:
		"tier1":
			towerStats = UpgradesManager.get_turret_stats(towerType,1)
		"tier2":
			towerStats = UpgradesManager.get_turret_stats(towerType,2)
		"tier3":
			towerStats = UpgradesManager.get_turret_stats(towerType,3)
			
	if attackSpeed != towerStats["fire_rate"]:
		attackSpeed = towerStats["fire_rate"]
	if attackRange.attackRange != towerStats["range"]*18:
		attackRange.attackRange = towerStats["range"]*18
	if healthManager.maxHealth != towerStats["hp"]:
		healthManager.maxHealth = towerStats["hp"]
	if damage != towerStats["damage"]:
		damage = towerStats["damage"]


func mouseSelect(input: InputEvent):
	if hovered and input is InputEventMouseButton and input.button_index == MOUSE_BUTTON_LEFT:
		hovered = false
		selected = true
		SceneInteraction.toggleUpgrade(true,self)
	if selected:
		if attackRange.targetPriority != SceneInteraction.upgradePanel.target:
			attackRange.targetPriority = SceneInteraction.upgradePanel.target


func _onMouseEnter() -> void:
	hovered = true
	if not SceneInteraction.buildMode:
		SceneInteraction.toggleSelect(true,get_global_transform_with_canvas().origin)


func _onMouseExit() -> void:
	hovered = false
	if not selected:
		SceneInteraction.toggleSelect(false)
	#if SceneInteraction.buildMode and not selected:
		#SceneInteraction.toggleBuildMode(false)
		#SceneInteraction.toggleSelect(false)
