extends TowerPanel

@onready var sprite_material = $TowerPanelBG.material as ShaderMaterial

func _on_tower_panel_bg_mouse_entered() -> void:
	sprite_material.set_shader_parameter("hover_effect", true)
	print("Hover True!")
	
func _on_tower_panel_bg_mouse_exited() -> void:
	sprite_material.set_shader_parameter("hover_effect", false)
