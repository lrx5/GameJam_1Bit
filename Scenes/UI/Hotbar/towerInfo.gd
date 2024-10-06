extends PanelContainer

@export var towerShop : PanelContainer
@onready var stylebox = towerShop.get_theme_stylebox("panel") as StyleBoxFlat

@onready var leftMargin 	= stylebox.content_margin_left
@onready var rightMargin	= stylebox.content_margin_right
@onready var topMargin		= stylebox.content_margin_top
@onready var bottomMargin	= stylebox.content_margin_bottom

@onready var leftBorder		= stylebox.border_width_left
@onready var rightBorder	= stylebox.border_width_right
@onready var topBorder		= stylebox.border_width_top
@onready var bottomBorder	= stylebox.border_width_bottom

@onready var statsDictionary
@onready var tower_name: Label = $InfoContainer/TowerName
@onready var gold_cost: Label = $InfoContainer/GoldCost
@onready var stats: Label = $InfoContainer/Stats


func _ready() -> void:
	pass
	#global_position = towerShop.get_rect().position - Vector2(get_rect().size.x-leftMargin*4+leftBorder*5,0)


func _on_cannon_panel_mouse_entered() -> void:
	setLabelInfo("cannon")
	tower_name.text = "CANNON TOWER"
	visible = true
func _on_cannon_panel_mouse_exited() -> void:
	visible = false


func _on_beam_panel_mouse_entered() -> void:
	setLabelInfo("beam")
	tower_name.text = "BEAM TOWER"
	visible = true
func _on_beam_panel_mouse_exited() -> void:
	visible = false


func _on_rocket_panel_mouse_entered() -> void:
	setLabelInfo("rocket")
	tower_name.text = "ROCKET TOWER"
	visible = true
func _on_rocket_panel_mouse_exited() -> void:
	visible = false


func setLabelInfo(turret_name: String):
	statsDictionary = UpgradesManager.get_turret_stats(turret_name, 1)
	gold_cost.text = "Gold Cost : " + str(statsDictionary["price"])
	stats.text = 	"Damage: " + str(statsDictionary["damage"]) + "\n" +\
					"Range: " + str(statsDictionary["range"]) + "\n" +\
					"Fire Rate: " + str(statsDictionary["fire_rate"]) + "\n" +\
					"Health: " + str(statsDictionary["hp"])
