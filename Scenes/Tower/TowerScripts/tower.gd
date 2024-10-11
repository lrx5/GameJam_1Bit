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
signal healthUpgraded()

var tween
@export var towerSprite : Sprite2D
var towerBase : TowerBase

@export_enum("tier1","tier2", "tier3") var towerTier = "tier1":
	set(value):
		towerTier = value
		emit_signal("towerUpgraded",value)

@export var healthManager : HealthManager

@onready var towerStats : Dictionary

@onready var hovered: bool = false
@onready var selected: bool = false
@onready var canDraw: bool = true
var attackTimer : float = 0
@onready var initStats = false

func _ready():
	for child in get_children():
		if child is TowerBase:
			towerBase = child
	if towerBase:
		towerBase.connect("mouse_entered",_onMouseEnter)
		towerBase.connect("mouse_exited",_onMouseExit)
	connect("healthUpgraded", onHealthUpgraded)
		
func onHealthUpgraded():
	await get_tree().create_timer(0.2).timeout
	healthManager.maxHealth = towerStats["hp"]
	healthManager.currentHealth = healthManager.maxHealth
	

func toggleUpgrade():
	emit_signal("healthUpgraded")
		
func attackCooldown(delta):
	attackTimer += delta
	if attackTimer >= 1/attackSpeed:
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
	if healthManager.maxHealth != towerStats["hp"]:
		healthManager.maxHealth = towerStats["hp"]
		if not initStats:
			healthManager.currentHealth = towerStats["hp"]
	if attackRange.attackRange != towerStats["range"] * 18:
		attackRange.attackRange = towerStats["range"] * 18
	if damage != towerStats["damage"]:
		damage = towerStats["damage"]


func cancelSelection():
	if selected:
		if SceneInteraction.upgradePanel.newTower.name != self.name:
			SceneInteraction.upgradePanel.cancelUpgrade()
			selected = false
			queue_redraw()

#region Turret Recoil Tween TESTING
func startTweening(recoil: float, recoilRecovery: float):
	tween = create_tween()
	# Cannon Recoil
	tween.set_ease(Tween.EASE_IN_OUT).tween_property(towerSprite, "position:y", 1/attackSpeed/2, recoil).set_ease(Tween.EASE_OUT)
	# Cannon Recoil Reset
	tween.tween_property(towerSprite, "position:y", towerSprite.position.y, recoilRecovery).set_ease(Tween.EASE_IN).set_delay(recoil)

#endregion

func mouseSelect(input: InputEvent):
		
	if hovered and input is InputEventMouseButton and input.button_index == MOUSE_BUTTON_LEFT:
		hovered = false
		selected = true
		
		SceneInteraction.toggleUpgrade(true,self)
		
	if selected:
		if SceneInteraction.upgradePanel.visible:
			await get_tree().create_timer(0.15).timeout
			queue_redraw()
		if attackRange.targetPriority != SceneInteraction.upgradePanel.target:
			attackRange.targetPriority = SceneInteraction.upgradePanel.target

func _draw() -> void:
	if (self is CannonTower or self is RocketTower or self is BeamTower) and selected:
		draw_circle(Vector2.ZERO,attackRange.attackRange,Color(255,255,255),false,1,false)
	elif not selected:
		return


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
