class_name AutoSprite
extends Sprite2D

@export var tier1 : Texture2D
@export var tier2 : Texture2D
@export var tier3 : Texture2D

func _ready() -> void:
	if not texture:
		texture = tier1

func _onTowerUpgraded(tier) -> void:
	match tier:
		"tier1":
			texture = tier1
		"tier2":
			texture = tier2
		"tier3":
			texture = tier3
