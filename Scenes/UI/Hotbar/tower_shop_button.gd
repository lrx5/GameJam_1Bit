extends TextureButton

@onready var tower_shop: Control = $"../TowerShop"
@export var shown_pos = Vector2(446.0,90.0)
@export var hidden_pos = Vector2(486.0,90.0)
var shop_hidden = true
var is_tweening = false
var justClicked = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tower_shop.position = hidden_pos
	connect("mouse_entered",onShopEnter)
	connect("mouse_exited",onShopExit)

func onShopEnter():
	SceneInteraction.toggleBuildMode(true)
	
func onShopExit():
	if not justClicked:
		SceneInteraction.toggleBuildMode(false)


func _on_pressed() -> void:
	if not justClicked:
		justClicked = true
	else:
		justClicked = false
		
	
	if justClicked:
		if shop_hidden and !is_tweening:
			is_tweening = true
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN_OUT).tween_property(tower_shop, "position", shown_pos, 0.2)
			tween.tween_callback(func(): is_tweening = false)
			shop_hidden = false
	if not justClicked:
		if !shop_hidden and !is_tweening:
			is_tweening = true
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN_OUT).tween_property(tower_shop, "position", hidden_pos, 0.2)
			tween.tween_callback(func(): is_tweening = false)
			shop_hidden = true
		
