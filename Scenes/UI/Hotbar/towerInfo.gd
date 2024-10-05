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

func _ready() -> void:
	global_position = towerShop.get_rect().position - Vector2(get_rect().size.x-leftMargin*4+leftBorder*5,0)
