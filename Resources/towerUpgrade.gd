extends PanelContainer

@export var left 		: Panel
@export var targetLabel : Label
@export var right		: Panel

@export var towerName	: Label
@export var stats		: Label

@export var upgrade		: PanelContainer
@export var upgradePrice: Label
@export var sell		: Label


var targetOptions = {
	0:"Nearest",
	1:"Farthest",
	2:"Fastest",
	3:"Highest HP"
}

@onready var canUpgrade : bool = true
@onready var justUpgraded : bool = false
@onready var targetIndex = 0
var target
var newTower
var newStats

var parent = self

func _ready():
	left.connect("gui_input",_onMouseClickLeft)
	right.connect("gui_input",_onMouseClickRight)

func _onMouseClickSell(event: InputEvent):
	print("sell connected")
	if event is InputEventMouseButton and event.button_mask == 1:
		print("Clicked Sell")

func _process(_delta) -> void:
	if is_instance_valid(newTower):
		towerName.text = setTowerName()
		stats.text = setStats()
		match newTower.towerTier:
			"tier1":
				upgradePrice.text = str(UpgradesManager.get_turret_stats(towerString(),2)["price"])
			"tier2":
				upgradePrice.text = str(UpgradesManager.get_turret_stats(towerString(),3)["price"])
				
		
	else:
		cancelUpgrade()


func _input(event: InputEvent) -> void:
	if isUpgrading(event):
		if not get_global_rect().has_point(get_global_mouse_position()):
			cancelUpgrade()
	if hoveredSell() and mouseClick(event):
		print("sell")
		
		match newTower.towerTier:
			"tier1":
				ResourceManager.changeCoins(UpgradesManager.get_turret_stats(towerString(),1)["price"])
			"tier2":
				ResourceManager.changeCoins(UpgradesManager.get_turret_stats(towerString(),1)["price"]*0.75)
			"tier3":
				ResourceManager.changeCoins(UpgradesManager.get_turret_stats(towerString(),1)["price"]*0.5)
			
		newTower.queue_free()
	if hoveredUpgrade() and mouseClick(event) and not justUpgraded:
		match newTower.towerTier:
			"tier1":
				if ResourceManager.coins >= UpgradesManager.get_turret_stats(towerString(),2)["price"]:
					ResourceManager.changeCoins(-UpgradesManager.get_turret_stats(towerString(),2)["price"])
					newTower.towerTier = "tier2"
			"tier2":
				if ResourceManager.coins >= UpgradesManager.get_turret_stats(towerString(),3)["price"]:
					ResourceManager.changeCoins(-UpgradesManager.get_turret_stats(towerString(),3)["price"])
					newTower.towerTier = "tier3"
					upgrade.visible = false
			"tier3":
				upgrade.visible = false
		justUpgraded = true
		await get_tree().create_timer(0.13).timeout
		justUpgraded = false

func towerString():
	var towerString 
	if "Cannon" in newTower.name:
		towerString = "cannon"
	if "Beam" in newTower.name:
		towerString = "beam"
	if "Rocket" in newTower.name:
		towerString = "rocket"
		
	return towerString


func _onMouseClickLeft(event: InputEvent):
	if event is InputEventMouseButton and event.button_mask == 1:
		var newIndex = 3 if targetIndex - 1 < 0 else targetIndex - 1
		setTarget(newIndex)
		targetIndex = targetOptions.find_key(target)
	
func _onMouseClickRight(event: InputEvent):
	if event is InputEventMouseButton and event.button_mask == 1:
		var newIndex = 0 if targetIndex + 1  > 3 else targetIndex + 1
		setTarget(newIndex)
		targetIndex = targetOptions.find_key(target)
	
func setTarget(index: int):
	target = targetOptions[index]
	targetLabel.text = str(target).to_upper()

func setTower(tower: Tower):
	newTower = tower
	upgrade.visible = false if newTower.towerTier == "tier3" else true
	canUpgrade = false
	await get_tree().create_timer(0.13).timeout
	canUpgrade = true
	justUpgraded = false
	
func setTowerName():
	var towerString = ""
	if "Cannon" in newTower.name:
		towerString = "CANNON TOWER"
	if "Beam" in newTower.name:
		towerString = "BEAM TOWER"
	if "Rocket" in newTower.name:
		towerString = "ROCKET TOWER"
		
	return towerString
	
func setStats():
	var statsString = "Damage : " + str(newTower.towerStats["damage"]) + "\n" \
					+ "Range : " + str(newTower.towerStats["range"]) + "\n" \
					+ "Fire Rate : " + str(newTower.towerStats["fire_rate"]) + "\n" \
					+ "Health: " + str(newTower.healthManager.currentHealth)
					
	return statsString

func mouseClick(event):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT

func hoveredSell():
	return sell.get_global_rect().has_point(get_global_mouse_position())
	
func hoveredUpgrade():
	return upgrade.get_global_rect().has_point(get_global_mouse_position())
	
func isUpgrading(event):
	return canUpgrade and SceneInteraction.buildMode and mouseClick(event)
	
func cancelUpgrade():
	canUpgrade = false
	visible = false
	process_mode = PROCESS_MODE_DISABLED
	SceneInteraction.toggleBuildMode(false)
	SceneInteraction.toggleSelect(false)
	if is_instance_valid(newTower):
		newTower.selected = false
	newTower = null
	
