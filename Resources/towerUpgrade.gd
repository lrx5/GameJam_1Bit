extends PanelContainer

@export var left 		: Panel
@export var targetLabel : Label
@export var right		: Panel

@export var towerName	: Label
@export var stats		: Label

@export var upgrade		: PanelContainer
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
		
	else:
		cancelUpgrade()


func _input(event: InputEvent) -> void:
	if isUpgrading(event):
		if not get_global_rect().has_point(get_global_mouse_position()):
			cancelUpgrade()
	if hoveredSell() and mouseClick(event):
		print("sell")
		newTower.queue_free()
	if hoveredUpgrade() and mouseClick(event) and not justUpgraded:
		match newTower.towerTier:
			"tier1":
				newTower.towerTier = "tier2"
			"tier2":
				newTower.towerTier = "tier3"
			"tier3":
				upgrade.visible = false
		justUpgraded = true
		await get_tree().create_timer(0.13).timeout
		justUpgraded = false

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
	
