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

#region Fire Rate Upgrade
func _on_upgrade_1_mouse_entered() -> void:
	pass #TODO For Anim
func _on_upgrade_1_mouse_exited() -> void:
	pass #TODO For Anim
func _on_upgrade_1_gui_input(event: InputEvent) -> void:
	var gameHUD = get_node("/root/SceneSwitcher/GameHUD")
	if event.is_action_pressed("ui_LMB"):
		if fire_rate_level == 1 and ResourceManager.gems >= 1:
			ResourceManager.changeGems(-1)
			fire_rate_level = 2
			fire_rate_details.text = "                        0.7s >>> 0.9s        Cost: 1 Gem"
			fire_rate_level_label.text = "Lvl. 2"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if fire_rate_level == 2 and ResourceManager.gems >= 1:
			ResourceManager.changeGems(-1)
			fire_rate_level = 3
			fire_rate_details.text = "                        0.9s >>> 1.2s        Cost: 2 Gem"
			fire_rate_level_label.text = "Lvl. 3"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if fire_rate_level == 3 and ResourceManager.gems >= 2:
			ResourceManager.changeGems(-2)
			fire_rate_level = 4
			fire_rate_details.text = "                        1.2s >>> 1.5s        Cost: 3 Gem"
			fire_rate_level_label.text = "Lvl. 4"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if fire_rate_level == 4 and ResourceManager.gems >= 3:
			ResourceManager.changeGems(-3)
			fire_rate_level = 5
			fire_rate_details.text = "                        Max Level"
			fire_rate_level_label.text = "Lvl. 5 ★"
			gameHUD.updateGems()
			upgrade_1.visible = false
			#Change Main Turret Values
			return
#endregion

#region Damage Upgrade
func _on_upgrade_2_mouse_entered() -> void:
	pass #TODO For Anim
func _on_upgrade_2_mouse_exited() -> void:
	pass #TODO For Anim
func _on_upgrade_2_gui_input(event: InputEvent) -> void:
	var gameHUD = get_node("/root/SceneSwitcher/GameHUD")
	if event.is_action_pressed("ui_LMB"):
		if damage_level == 1 and ResourceManager.gems >= 1:
			ResourceManager.changeGems(-1)
			damage_level = 2
			damage_details.text = "                        75 >>> 100        Cost: 1 Gem"
			damage_level_label.text = "Lvl. 2"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if damage_level == 2 and ResourceManager.gems >= 1:
			ResourceManager.changeGems(-1)
			damage_level = 3
			damage_details.text = "                        100 >>> 125        Cost: 2 Gem"
			damage_level_label.text = "Lvl. 3"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if damage_level == 3 and ResourceManager.gems >= 2:
			ResourceManager.changeGems(-2)
			damage_level = 4
			damage_details.text = "                        125 >>> 150        Cost: 3 Gem"
			damage_level_label.text = "Lvl. 4"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if damage_level == 4 and ResourceManager.gems >= 3:
			ResourceManager.changeGems(-3)
			damage_level = 5
			damage_details.text = "                        Max Level"
			damage_level_label.text = "Lvl. 5 ★"
			gameHUD.updateGems()
			upgrade_2.visible = false
			#Change Main Turret Values
			return
#endregion

#region Range Upgrade
func _on_upgrade_3_mouse_entered() -> void:
	pass # Replace with function body.
func _on_upgrade_3_mouse_exited() -> void:
	pass # Replace with function body.
func _on_upgrade_3_gui_input(event: InputEvent) -> void:
	var gameHUD = get_node("/root/SceneSwitcher/GameHUD")
	if event.is_action_pressed("ui_LMB"):
		if range_level == 1 and ResourceManager.gems >= 1:
			ResourceManager.changeGems(-1)
			range_level = 2
			range_details.text = "                        Med+ >>> Far-        Cost: 1 Gem"
			range_level_label.text = "Lvl. 2"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if range_level == 2 and ResourceManager.gems >= 1:
			ResourceManager.changeGems(-1)
			range_level = 3
			range_details.text = "                        Far- >>> Far+        Cost: 2 Gem"
			range_level_label.text = "Lvl. 3"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if range_level == 3 and ResourceManager.gems >= 2:
			ResourceManager.changeGems(-2)
			range_level = 4
			range_details.text = "                        Far+ >>> Global        Cost: 3 Gem"
			range_level_label.text = "Lvl. 4"
			gameHUD.updateGems()
			#Change Main Turret Values
			return
		if range_level == 4 and ResourceManager.gems >= 3:
			ResourceManager.changeGems(-3)
			range_level = 5
			range_details.text = "                        Max Level"
			range_level_label.text = "Lvl. 5 ★"
			gameHUD.updateGems()
			upgrade_3.visible = false
			#Change Main Turret Values
			return
#endregion
