extends TextureButton

func _ready() -> void:
	var settings = get_node("/root/SceneSwitcher/Settings")
	settings.visible = false
func _on_pressed() -> void:
	print("Clicked!")
	var settings = get_node("/root/SceneSwitcher/Settings")
	settings.visible = true
