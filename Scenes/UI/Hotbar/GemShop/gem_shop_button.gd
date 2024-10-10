extends TextureButton

@onready var gem_shop: Control = $"../GemShop"
@export var shown_pos = Vector2(240.0,152.0)
@export var hidden_pos = Vector2(240.0,410.0)
var shop_hidden = true
var is_tweening = false
var justClicked = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gem_shop.position = hidden_pos
	connect("mouse_entered",onShopEnter)
	connect("mouse_exited",onShopExit)

func _process(_delta) -> void:
	if !shop_hidden and !is_tweening and Input.is_action_just_pressed("escape"):
		justClicked = true
		is_tweening = true
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).tween_property(gem_shop, "position", hidden_pos, 0.2)
		tween.tween_callback(func(): is_tweening = false)
		shop_hidden = true
		justClicked = false


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
			tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).tween_property(gem_shop, "position", shown_pos, 0.2)
			tween.tween_callback(func(): is_tweening = false)
			shop_hidden = false
			
	else:
		if !shop_hidden and !is_tweening:
			is_tweening = true
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).tween_property(gem_shop, "position", hidden_pos, 0.2)
			tween.tween_callback(func(): is_tweening = false)
			shop_hidden = true
