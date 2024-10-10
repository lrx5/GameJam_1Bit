extends Control

var fire_rate_level = 1
var damage_level = 1
var range_level = 1

@onready var upgrade_1: Label = $MainShop/MainShopContainer/VBoxContainer/Upgrade1
@onready var upgrade_2: Label = $MainShop/MainShopContainer/VBoxContainer2/Upgrade2
@onready var upgrade_3: Label = $MainShop/MainShopContainer/VBoxContainer3/Upgrade3
@onready var fire_rate_level_label: Label = $MainShop/MainShopContainer/VBoxContainer/FireRateLevel
@onready var fire_rate_details: Label = $MainShop/MainShopContainer/FireRateDetails
@onready var damage_level_label: Label = $MainShop/MainShopContainer/VBoxContainer2/DamageLevel
@onready var damage_details: Label = $MainShop/MainShopContainer/DamageDetails
@onready var range_level_label: Label = $MainShop/MainShopContainer/VBoxContainer3/RangeLevel
@onready var range_details: Label = $MainShop/MainShopContainer/RangeDetails

@onready var mainTower = get_tree().get_first_node_in_group("mainTower")

func _ready() -> void:
	$MainShop/MainShopContainer.connect("mouse_entered",onShopEnter)
	$MainShop/MainShopContainer.connect("mouse_exited",onShopExit)
	setLabels()

func setLabels():
	# Set Level 1 Main Tower Gem Shop Text Labels
	fire_rate_level_label.text = "Lvl. 1"
	fire_rate_details.text = UpgradesManager.get_main_turret_stats("firerate", 1)
	damage_level_label.text = "Lvl. 1"
	damage_details.text = UpgradesManager.get_main_turret_stats("damage", 1)
	range_level_label.text = "Lvl. 1"
	range_details.text = UpgradesManager.get_main_turret_stats("range", 1)

func onShopEnter():
	SceneInteraction.toggleBuildMode(true)
func onShopExit():
	SceneInteraction.toggleBuildMode(false)

func decreaseGems(value):
	var gameHUD = get_node("/root/SceneSwitcher/GameHUD")
	ResourceManager.changeGems(value)
	gameHUD.updateGems()

func changeLabels(upgradeStat, level):
	if upgradeStat == "firerate":
		fire_rate_details.text = UpgradesManager.get_main_turret_stats(upgradeStat, level)
		fire_rate_level += 1
		fire_rate_level_label.text = "Lvl. " + str(fire_rate_level)
		mainTower.FRlvl += 1
	elif upgradeStat == "damage":
		damage_details.text = UpgradesManager.get_main_turret_stats(upgradeStat, level)
		damage_level += 1
		damage_level_label.text = "Lvl. " + str(damage_level)
		mainTower.DMGlvl += 1
	elif upgradeStat == "range":
		range_details.text = UpgradesManager.get_main_turret_stats(upgradeStat, level)
		range_level += 1
		range_level_label.text = "Lvl. " + str(range_level)
		mainTower.RNGlvl += 1
	else:
		print("Invalid upgradeStat")

#region Fire Rate Upgrade
func _on_upgrade_1_mouse_entered() -> void:
	upgrade_1.text = "[+] Upgrade?"
func _on_upgrade_1_mouse_exited() -> void:
	upgrade_1.text = "[+]"
func _on_upgrade_1_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_LMB"):
		if fire_rate_level == 1 and ResourceManager.gems >= 1:
			decreaseGems(-1)
			changeLabels("firerate", 2)
		elif fire_rate_level == 2 and ResourceManager.gems >= 1:
			decreaseGems(-1)
			changeLabels("firerate", 3)
		elif fire_rate_level == 3 and ResourceManager.gems >= 2:
			decreaseGems(-2)
			changeLabels("firerate", 4)
		elif fire_rate_level == 4 and ResourceManager.gems >= 3:
			decreaseGems(-3)
			changeLabels("firerate", 5)
			upgrade_1.visible = false
		else:
			upgrade_1.text = "[+] Low Gems"
#endregion

#region Damage Upgrade
func _on_upgrade_2_mouse_entered() -> void:
	upgrade_2.text = "[+] Upgrade?"
func _on_upgrade_2_mouse_exited() -> void:
	upgrade_2.text = "[+]"
func _on_upgrade_2_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_LMB"):
		if damage_level == 1 and ResourceManager.gems >= 1:
			decreaseGems(-1)
			changeLabels("damage", 2)
		elif damage_level == 2 and ResourceManager.gems >= 1:
			decreaseGems(-1)
			changeLabels("damage", 3)
		elif damage_level == 3 and ResourceManager.gems >= 2:
			decreaseGems(-2)
			changeLabels("damage", 4)
		elif damage_level == 4 and ResourceManager.gems >= 3:
			decreaseGems(-3)
			changeLabels("damage", 5)
			upgrade_2.visible = false
		else:
			upgrade_2.text = "[+] Low Gems"
#endregion

#region Range Upgrade
func _on_upgrade_3_mouse_entered() -> void:
	upgrade_3.text = "[+] Upgrade?"
func _on_upgrade_3_mouse_exited() -> void:
	upgrade_3.text = "[+]"
func _on_upgrade_3_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_LMB"):
		if range_level == 1 and ResourceManager.gems >= 1:
			decreaseGems(-1)
			changeLabels("range", 2)
		elif range_level == 2 and ResourceManager.gems >= 1:
			decreaseGems(-1)
			changeLabels("range", 3)
		elif range_level == 3 and ResourceManager.gems >= 2:
			decreaseGems(-2)
			changeLabels("range", 4)
		elif range_level == 4 and ResourceManager.gems >= 3:
			decreaseGems(-3)
			changeLabels("range", 5)
			upgrade_3.visible = false
		else:
			upgrade_3.text = "[+] Low Gems"
#endregion
