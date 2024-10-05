extends TextureButton

@onready var gem_shop: Control = $"../GemShop"
@export var shown_pos = Vector2(240.0,152.0)
@export var hidden_pos = Vector2(240.0,410.0)
var shop_hidden = true
var is_tweening = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gem_shop.position = hidden_pos

func _on_pressed() -> void:
	if shop_hidden and !is_tweening:
		is_tweening = true
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT).tween_property(gem_shop, "position", shown_pos, 0.5)
		tween.tween_callback(func(): is_tweening = false)
		shop_hidden = false
	if !shop_hidden and !is_tweening:
		is_tweening = true
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT).tween_property(gem_shop, "position", hidden_pos, 0.5)
		tween.tween_callback(func(): is_tweening = false)
		shop_hidden = true
